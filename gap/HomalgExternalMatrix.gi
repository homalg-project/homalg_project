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
    
    if nargs = 2 and ( IsHomalgMatrix( arg[1] ) or IsString( arg[1] ) ) and IsHomalgRing( arg[2] ) then
        
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
        
    elif nargs = 4 and ( IsHomalgMatrix( arg[1] ) or IsString( arg[1] ) ) and IsHomalgRing( arg[4] ) then
        
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
    
    local R, directory, pointer, pid, filename, fs, MM;
    
    R := HomalgRing( M ); # the source ring
    
    if IsBound( HOMALG_IO.DirectoryForTemporaryFiles ) then
        directory := HOMALG_IO.DirectoryForTemporaryFiles;
        if directory[Length(directory)] <> '\/' then
            directory[Length(directory) + 1] := '\/';
        fi;
    else
        directory := "";
    fi;
    
    if IsHomalgExternalMatrixRep( M ) then
        pointer := homalgPointer( M );
        pid := String( homalgExternalCASystemPID( R ) );
    else
        pointer := "Internal"; #FIXME
        pid := "GAP";
    fi;
    
    filename := Concatenation( directory, pointer, "_PID_", pid );
    
    fs := IO_File( filename, "w" );
    
    if fs = fail then
        Error( "unable to open the file ", filename, " for writing\n" );
    fi;
    
    if IO_Close( fs ) = fail then
        Error( "unable to close the file ", filename, "\n" );
    fi;
    
    SaveDataOfHomalgMatrixInFile( filename, M );
    
    MM := LoadDataOfHomalgMatrixFromFile( filename, RR ); # matrix in target ring
    
    if not ( IsBound( HOMALG_IO.do_not_delete_tmp_files ) and HOMALG_IO.do_not_delete_tmp_files = true ) then
        Exec( Concatenation( "/bin/rm -f \"", filename, "\"" ) );
    fi;
    
    return MM;
    
end );

##
InstallMethod( SaveDataOfHomalgMatrixInFile,
        "for two arguments instead of three",
        [ IsString, IsHomalgMatrix ],
        
  function( filename, M )
    
    return SaveDataOfHomalgMatrixInFile( filename, M, HomalgRing( M ) );
    
end );

##
InstallMethod( SaveDataOfHomalgMatrixInFile,
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
        
    fi;
    
    return M;
    
end );
