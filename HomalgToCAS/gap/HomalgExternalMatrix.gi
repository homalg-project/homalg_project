# SPDX-License-Identifier: GPL-2.0-or-later
# HomalgToCAS: A window to the outer world
#
# Implementations
#

##  Implementation stuff for homalg matrices.

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( homalgPointer,
        "for homalg external matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    
    return homalgPointer( Eval( M ) ); ## here we must evaluate
    
end );

##
InstallMethod( homalgExternalCASystem,
        "for homalg external matrices",
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
        "for homalg external matrices",
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
        "for homalg external matrices",
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
        "for homalg external matrices",
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

##
InstallMethod( SetMatElm,
        "for homalg external matrices",
        [ IsHomalgMatrix and IsMutable, IsPosInt, IsPosInt, IsHomalgExternalRingElementRep ],
        
  function( M, r, c, s )
    
    SetMatElm( M, r, c, homalgPointer( s ), HomalgRing( M ) );
    
end );

##
InstallMethod( SetMatElm,
        "for homalg external matrices",
        [ IsHomalgMatrix and IsMutable, IsPosInt, IsPosInt, IsHomalgExternalRingElementRep, IsHomalgExternalRingRep ],
        
  function( M, r, c, s, R )
    
    SetMatElm( M, r, c, homalgPointer( s ), R );
    
end );

## MatrixBaseChange to an external ring
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgExternalRingRep, IsHomalgMatrix ],
        
  function( R, m )
    local RP, mat;
    
    RP := homalgTable( R );
    
    if not IsIdenticalObj( HomalgRing( m ), R ) and
       IsHomalgExternalRingRep( HomalgRing( m ) ) and
       IsIdenticalObj( homalgStream( HomalgRing( m ) ), homalgStream( R ) ) and
       IsBound( RP!.CopyMatrix ) then ## make a "copy" over a different ring
        
        Eval( m ); ## enforce evaluation
        
        mat := HomalgMatrix( R );
        
        ## this is quicker and safer than calling the
        ## constructor HomalgMatrix with all arguments
        SetEval( mat, RP!.CopyMatrix( m, R ) );
        
        BlindlyCopyMatrixProperties( m, mat );
        
        return mat;
        
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( CreateHomalgMatrixFromList,
        "constructor for homalg matrices",
        [ IsList, IsHomalgExternalRingRep ],
        
  function( L, R )
    local M;
    
    if IsEmpty( L ) then
        return HomalgZeroMatrix( 0, 0, R );
    elif ForAll( L, IsList and IsEmpty ) then
        return HomalgZeroMatrix( Length( L ), 0, R );
    fi;
    
    if IsList( L[1] ) then
        if not ForAll( L[1], IsHomalgExternalRingElementRep ) then
            TryNextMethod( );
        elif not IsIdenticalObj( HomalgRing( L[1][1] ), R ) then
            TryNextMethod( );
        fi;
        M := List( L, r -> List( r, homalgPointer ) );
        M := Concatenation( "[[", JoinStringsWithSeparator( List( M, r -> JoinStringsWithSeparator( r ) ), "],[" ), "]]" );
    else
        if not ForAll( L, IsHomalgExternalRingElementRep ) then
            TryNextMethod( );
        elif not IsIdenticalObj( HomalgRing( L[1] ), R ) then
            TryNextMethod( );
        fi;
        ## this resembles NormalizeInput in Maple's homalg ( a legacy ;) )
        M := Concatenation( "[[", JoinStringsWithSeparator( List( L, homalgPointer ), "],[" ), "]]" );
        ## What is the use case for this? Wouldn't it be better to replace this by an error message?
        # Error( "the number of rows and columns must be specified to construct a matrix from a list" );
    fi;
    
    return CreateHomalgMatrixFromString( M, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromList,
        "constructor for homalg matrices",
        [ IsList, IsInt, IsInt, IsHomalgExternalRingRep ],
        
  function( L, r, c, R )
    local M;
    
    if r * c = 0 then
        return HomalgZeroMatrix( r, c, R );
    fi;
    
    if IsList( L[1] ) then
        if not ForAll( L[1], IsHomalgExternalRingElementRep ) then
            TryNextMethod( );
        elif not IsIdenticalObj( HomalgRing( L[1][1] ), R ) then
            TryNextMethod( );
        fi;
        M := List( Concatenation( L ), homalgPointer );
        M := Concatenation( "[", JoinStringsWithSeparator( M ), "]" );
    else
        if not ForAll( L, IsHomalgExternalRingElementRep ) then
            TryNextMethod( );
        elif not IsIdenticalObj( HomalgRing( L[1] ), R ) then
            TryNextMethod( );
        fi;
        M := Concatenation( "[", JoinStringsWithSeparator( List( L, homalgPointer ) ), "]" );
    fi;
    
    return CreateHomalgMatrixFromString( M, r, c, R );
    
end );

##
InstallMethod( ConvertHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgRing ],
        
  function( M, R )
    
    if IsBound( M!.ConvertHomalgMatrixViaFile ) and M!.ConvertHomalgMatrixViaFile = false then
        TryNextMethod( );
    elif IsBound( M!.ConvertHomalgMatrixViaSparseString ) and M!.ConvertHomalgMatrixViaSparseString = true then
        return ConvertHomalgMatrixViaSparseString( M, R );
    fi;
    
    return ConvertHomalgMatrixViaFile( M, R );
    
end );

##
InstallMethod( ConvertHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ],
        
  function( M, r, c, R )
    
    if IsBound( M!.ConvertHomalgMatrixViaFile ) and M!.ConvertHomalgMatrixViaFile = false then
        TryNextMethod( );
    elif IsBound( M!.ConvertHomalgMatrixViaSparseString ) and M!.ConvertHomalgMatrixViaSparseString = true then
        return ConvertHomalgMatrixViaSparseString( M, r, c, R );
    fi;
    
    return ConvertHomalgMatrixViaFile( M, R );
    
end );

##
InstallMethod( ConvertHomalgMatrixViaFile,
        "convert an external matrix into an external ring via file saving and loading",
        [ IsHomalgMatrix, IsHomalgRing ],
        
  function( M, RR )
    
    local R, r, c, separator, pointer, pid, file, filename, fs, remove, MM;
    
    R := HomalgRing( M ); # the source ring
    
    r := NumberRows( M );
    c := NumberColumns( M );
    
    if IsHomalgExternalMatrixRep( M ) then
        pointer := homalgPointer( M );
        pid := Concatenation( "_PID_", String( homalgExternalCASystemPID( R ) ) );
    else
        if IsBound( HOMALG_IO.FileNameCounter ) then
            pointer := Concatenation( "homalg_file_", String( HOMALG_IO.FileNameCounter ) );
            HOMALG_IO.FileNameCounter := HOMALG_IO.FileNameCounter + 1;
        else
            Error( "HOMALG_IO.FileNameCounter is not bound, filename creation for internal object failed.\n" );
        fi;
        
        if not IsBound( HOMALG_IO.PID ) or not IsInt( HOMALG_IO.PID ) then
            HOMALG_IO.PID := -1; #this is not the real PID!
        fi;
        
        pid := Concatenation( "_PID_", String( HOMALG_IO.PID ) );
        
    fi;
    
    file := Concatenation( pointer, pid );
    
    filename := Filename( HOMALG_IO.DirectoryForTemporaryFiles, file );
    
    remove := SaveHomalgMatrixToFile( filename, M );
    
    MM := LoadHomalgMatrixFromFile( filename, r, c, RR ); # matrix in target ring
    
    ResetFilterObj( MM, IsVoidMatrix );
    
    if not ( IsBound( HOMALG_IO.DoNotDeleteTemporaryFiles ) and HOMALG_IO.DoNotDeleteTemporaryFiles = true ) then
        if not IsBool( remove ) then
            if IsList( remove ) and ForAll( remove, IsString ) then
                for file in remove do
                    Exec( Concatenation( "/bin/rm -f \"", file, "\"" ) );
                od;
            else
                Error( "expecting a list of strings indicating file names to be deleted\n" );
            fi;
        else
            Exec( Concatenation( "/bin/rm -f \"", filename, "\"" ) );
        fi;
    fi;
    
    return MM;
    
end );

##
InstallMethod( SaveHomalgMatrixToFile,
        "for two arguments instead of three",
        [ IsString, IsHomalgMatrix ],
        
  function( filename, M )
    local fs;
    
    if IsExistingFile( filename ) then
        Error( "the file ", filename, " already exists, please delete it first and then type return; to continue\n" );
        return SaveHomalgMatrixToFile( filename, M );
    fi;
    
    return SaveHomalgMatrixToFile( filename, M, HomalgRing( M ) );
    
end );

##
InstallMethod( SaveHomalgMatrixToFile,
        "for an internal homalg matrix",
        [ IsString, IsHomalgInternalMatrixRep, IsHomalgInternalRingRep ],
        
  function( filename, M, R )
    local mode;
    
    if not IsBound( M!.SaveAs ) then
        mode := "ListList";
    else
        mode := M!.SaveAs; ## FIXME: not yet supported
    fi;
    
    if mode = "ListList" then
        
        if FileString( filename, GetListListOfHomalgMatrixAsString( M ) ) = fail then
            Error( "unable to write in the file ", filename, "\n" );
        fi;
        
    fi;
    
    return true;
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for an internal homalg ring",
        [ IsString, IsHomalgInternalRingRep ],
        
  function( filename, R )
    local mode, str, z, M;
    
    if not IsBound( R!.LoadAs ) then
        mode := "ListList";
    else
        mode := R!.LoadAs; ## FIXME: not yet supported
    fi;
    
    if mode = "ListList" then
        
        str := StringFile( filename );
        
        if str = fail then
            Error( "unable to read lines from the file ", filename, "\n" );
        fi;
        
        if IsBound( R!.NameOfPrimitiveElement ) and
           HasCharacteristic( R ) and Characteristic( R ) > 0 and
           HasDegreeOverPrimeField( R ) and DegreeOverPrimeField( R ) > 1 then
            z := R!.NameOfPrimitiveElement;
            
            if IsBoundGlobal( z ) then
                Error( z, " is globally bound\n" );
            fi;
            
            BindGlobal( z, Z( Characteristic( R ) ^ DegreeOverPrimeField( R ) ) );
            
            str := EvalString( str );
            
            MakeReadWriteGlobal( z );
            
            UnbindGlobal( z );
            
        else
            M := EvalString( str );
        fi;
        
        M := HomalgMatrix( str, R );
        
        #if HasCharacteristic( R ) and HasCharacteristic( R ) > 0 then
            M := One( R ) * M;
        #fi;
    fi;
    
    return M;
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for an internal homalg ring",
        [ IsString, IsInt, IsInt, IsHomalgRing ], 0, ## lowest rank method
        
  function( filename, r, c, R )
    
    return LoadHomalgMatrixFromFile( filename, R );
    
    ## do not set NumberRows and NumberColumns for safety reasons
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( Display,
        "for homalg external matrices",
        [ IsHomalgExternalMatrixRep ], 0, ## never higher!!!
        
  function( o )
    
    Print( homalgSendBlocking( [ o ], "need_display", "Display" ) );
    
end );

