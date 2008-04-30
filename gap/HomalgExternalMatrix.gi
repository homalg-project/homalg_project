#############################################################################
##
##  HomalgExternalMatrix.gi   IO_ForHomalg package           Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg matrices.
##
#############################################################################

##
InstallMethod( homalgPointer,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    
    return homalgPointer( Eval( M ) ); ## here we must evaluate
    
end );

##
InstallMethod( homalgExternalCASystem,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if IsHomalgExternalRingRep( R ) then
        return homalgExternalCASystem( R ); ## avoid evaluating the matrix
    else
        return homalgExternalCASystem( Eval( M ) );
    fi;
    
end );

##
InstallMethod( homalgExternalCASystemVersion,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if IsHomalgExternalRingRep( R ) then
        return homalgExternalCASystemVersion( R ); ## avoid evaluating the matrix
    else
        return homalgExternalCASystemVersion( Eval( M ) );
    fi;
    
end );

##
InstallMethod( homalgStream,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if IsHomalgExternalRingRep( R ) then
        return homalgStream( R ); ## avoid evaluating the matrix
    else
        return homalgStream( Eval( M ) );
    fi;
    
end );

##
InstallMethod( homalgExternalCASystemPID,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if IsHomalgExternalRingRep( R ) then
        return homalgExternalCASystemPID( R ); ## avoid evaluating the matrix
    else
        return homalgExternalCASystemPID( Eval( M ) );
    fi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( CreateHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgExternalRingRep ],
        
  function( M, R )
    
    return CreateHomalgMatrix( String( Eval( M ) ), R );
    
end );

##
InstallGlobalFunction( ConvertHomalgMatrix,
  function( arg )
    local nargs, M, o, R, r, c;
    
    nargs := Length( arg );
    
    if nargs = 2 and ( IsHomalgMatrix( arg[1] ) or IsStringRep( arg[1] ) ) and IsHomalgRing( arg[2] ) then
        
        M := arg[1];
        R := arg[2];
	
        if IsHomalgMatrix( M ) then
            
            if IsBound( M!.ExtractHomalgMatrixToFile ) and M!.ExtractHomalgMatrixToFile = true then
                return ConvertHomalgMatrixViaFile( M, R );
            fi;
            
            if IsBound( M!.ExtractHomalgMatrixAsSparse ) and M!.ExtractHomalgMatrixAsSparse = true then
                M := GetSparseListOfHomalgMatrixAsString( M );
            else
                M := GetListListOfHomalgMatrixAsString( M );
            fi;
            
        fi;
        
        if IsHomalgMatrix( arg[1] ) and IsBound( arg[1]!.ExtractHomalgMatrixAsSparse ) and arg[1]!.ExtractHomalgMatrixAsSparse = true then
            return CreateHomalgSparseMatrix( M, NrRows( arg[1] ), NrColumns( arg[1] ), R );
        else
            return CreateHomalgMatrix( M, R );
        fi;
        
    elif nargs = 4 and ( IsHomalgMatrix( arg[1] ) or IsStringRep( arg[1] ) ) and IsHomalgRing( arg[4] ) then
        
        M := arg[1];
        r := arg[2];
        c := arg[3];
        R := arg[4];
        
        if IsHomalgMatrix( M ) then
            if IsBound( M!.ExtractHomalgMatrixAsSparse ) and M!.ExtractHomalgMatrixAsSparse = true then
                M := GetSparseListOfHomalgMatrixAsString( M );
            else
                M := GetListOfHomalgMatrixAsString( M );
            fi;
        fi;
        
        if IsHomalgMatrix( arg[1] ) and IsBound( arg[1]!.ExtractHomalgMatrixAsSparse ) and arg[1]!.ExtractHomalgMatrixAsSparse = true then
            return CreateHomalgSparseMatrix( M, r, c, R );
        else
            return CreateHomalgMatrix( M, r, c, R );
        fi;
        
    fi;
    
    Error( "wrong syntax\n" );
    
end );

##
InstallMethod( ConvertHomalgMatrixViaFile,
        "convert an external matrix into an external ring via file saving and loading",
        [ IsHomalgMatrix, IsHomalgRing ],
        
  function( M, RR )
    
    local R, r, c, separator, directory, pointer, pid, file, filename, fs, MM;
    
    R := HomalgRing( M ); # the source ring
    
    r := NrRows( M );
    c := NrColumns( M );
    
    ## figure out the directory separtor:
    if IsBound( GAPInfo.UserHome ) then
        separator := GAPInfo.UserHome[1];
    else
        separator := '/';
    fi;
    
    if IsBound( HOMALG_IO.DirectoryForTemporaryFiles ) then
        directory := HOMALG_IO.DirectoryForTemporaryFiles;
        if directory[Length(directory)] <> separator then
            directory[Length(directory) + 1] := separator;
        fi;
    else
        directory := "";
    fi;
    
    if IsHomalgExternalMatrixRep( M ) then
        pointer := homalgPointer( M );
        pid := Concatenation( "_PID_", String( homalgExternalCASystemPID( R ) ) );
    else
        if IsBound( HOMALG_IO.FileNameCounter ) then
            pointer := Concatenation( "homalg_internal_", String( HOMALG_IO.FileNameCounter ) );
            HOMALG_IO.FileNameCounter := HOMALG_IO.FileNameCounter + 1;
        else
            Error( "HOMALG_IO.FileNameCounter is not bound, filename creation for internal object failed.\n" );
        fi;
        
        if not IsBound( HOMALG_IO.PID ) or not IsInt( HOMALG_IO.PID ) then
            HOMALG_IO.PID := 99999; #this is not the real PID!
        fi;
        
        pid := Concatenation( "_PID_", String( HOMALG_IO.PID ) );
        
    fi;
    
    file := Concatenation( pointer, pid );
    
    filename := Concatenation( directory, file );
    
    fs := IO_File( filename, "w" );
    
    if fs = fail then
        if not ( IsBound( HOMALG_IO.DoNotFigureOutAnAlternativeDirectoryForTemporaryFiles ) 
                 and HOMALG_IO.DoNotFigureOutAnAlternativeDirectoryForTemporaryFiles = true ) then
            directory := FigureOutAnAlternativeDirectoryForTemporaryFiles( file );
            if directory <> fail then
                filename := Concatenation( directory, file );
		fs := IO_File( filename, "w" );
            else
                Error( "unable to (find alternative directories to) open the file ", filename, " for writing\n" );
            fi;
        else
            Error( "unable to open the file ", filename, " for writing\n" );
        fi;
    fi;
    
    if IO_Close( fs ) = fail then
        Error( "unable to close the file ", filename, "\n" );
    fi;
    
    SaveDataOfHomalgMatrixToFile( filename, M );
    
    MM := LoadDataOfHomalgMatrixFromFile( filename, r, c, RR ); # matrix in target ring
    
    if not ( IsBound( HOMALG_IO.DoNotDeleteTemporaryFiles ) and HOMALG_IO.DoNotDeleteTemporaryFiles = true ) then
        Exec( Concatenation( "/bin/rm -f \"", filename, "\"" ) );
    fi;
    
    return MM;
    
end );

##
InstallMethod( SaveDataOfHomalgMatrixToFile,
        "for two arguments instead of three",
        [ IsString, IsHomalgMatrix ],
        
  function( filename, M )
    
    return SaveDataOfHomalgMatrixToFile( filename, M, HomalgRing( M ) );
    
end );

##
InstallMethod( SaveDataOfHomalgMatrixToFile,
        "for an internal homalg matrix",
        [ IsString, IsHomalgInternalMatrixRep, IsHomalgInternalRingRep ],
        
  function( filename, M, R )
    local mode, fs;
    
    if not IsBound( M!.SaveAs ) then
        mode := "ListList";
    else
        mode := M!.SaveAs; ## FIXME: not yet supported
    fi;
    
    if mode = "ListList" then
        
        fs := IO_File( filename, "w" );
        
        if fs = fail then
            Error( "unable to open the file ", filename, " for writing\n" );
        fi;
        
        if IO_WriteFlush( fs, GetListListOfHomalgMatrixAsString( M ) ) = fail then
            Error( "unable to write in the file ", filename, "\n" );
        fi;
        
        if IO_Close( fs ) = fail then
            Error( "unable to close the file ", filename, "\n" );
        fi;
        
    fi;
    
    return true;
    
end );

##
InstallMethod( LoadDataOfHomalgMatrixFromFile,
        "for an internal homalg ring",
        [ IsString, IsHomalgInternalRingRep ],
        
  function( filename, R )
    local mode, fs, str, M;
    
    if not IsBound( R!.LoadAs ) then
        mode := "ListList";
    else
        mode := R!.LoadAs; ## FIXME: not yet supported
    fi;
    
    if mode = "ListList" then
        
        fs := IO_File( filename, "r" );
        
        if fs = fail then
            Error( "unable to open the file ", filename, " for reading\n" );
        fi;
        
        str := IO_ReadUntilEOF( fs );
        
        if str = fail then
            Error( "unable to read lines from the file ", filename, "\n" );
        fi;
        
        if IO_Close( fs ) = fail then
            Error( "unable to close the file ", filename, "\n" );
        fi;
        
        M := HomalgMatrix( EvalString( str ), R );
        
        #if HasCharacteristic( R ) and HasCharacteristic( R ) > 0 then
            M := One( R ) * M;
        #fi;
    fi;
    
    return M;
    
end );

##
InstallMethod( LoadDataOfHomalgMatrixFromFile,
        "for an internal homalg ring",
        [ IsString, IsInt, IsInt, IsHomalgRing ], 0, ## lowest rank method
        
  function( filename, r, c, R )
    
    return LoadDataOfHomalgMatrixFromFile( filename, R );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ], 0, ## never higher!!!
        
  function( o )
    
    Print( homalgSendBlocking( [ o ], "need_display", "dsp" ) );
    
end );

