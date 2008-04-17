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
	
        if not ( IsHomalgInternalMatrixRep( M ) or IsString( M ) ) then
            if IsBound( M!.ExtractHomalgMatrixToFile ) and M!.ExtractHomalgMatrixToFile = true and IsHomalgExternalRingRep( arg[2] ) then
                return ConvertHomalgMatrixViaFile( M, arg[2] );
	    fi;
	    
	    if IsBound( M!.ExtractHomalgMatrixAsSparse ) and M!.ExtractHomalgMatrixAsSparse = true then
                M := GetSparseListOfHomalgMatrixAsString( M );
            else
                M := GetListListOfHomalgMatrixAsString( M );
            fi;
        fi;
        
        if IsHomalgInternalRingRep( R ) then
            if IsBound( arg[1]!.ExtractHomalgMatrixAsSparse ) and arg[1]!.ExtractHomalgMatrixAsSparse = true then
                return CreateHomalgSparseMatrix( M, NrRows( arg[1] ), NrColumns( arg[1] ), R );
            else
                return HomalgMatrix( EvalString( M ), R );
            fi;
        else
            if IsHomalgMatrix( arg[1] ) and IsBound( arg[1]!.ExtractHomalgMatrixAsSparse ) and arg[1]!.ExtractHomalgMatrixAsSparse = true then
                return CreateHomalgSparseMatrix( M, NrRows( arg[1] ), NrColumns( arg[1] ), R );
            else
                return CreateHomalgMatrix( M, R );
            fi;
        fi;
        
    elif nargs = 4 and ( IsHomalgMatrix( arg[1] ) or IsString( arg[1] ) ) and IsHomalgRing( arg[4] ) then
        
        M := arg[1];
        r := arg[2];
        c := arg[3];
        R := arg[4];
        
        if not ( IsHomalgInternalMatrixRep( M ) or IsString( M ) ) then
            if IsBound( M!.ExtractHomalgMatrixAsSparse ) and M!.ExtractHomalgMatrixAsSparse = true then
                M := GetSparseListOfHomalgMatrixAsString( M );
            else
                M := GetListOfHomalgMatrixAsString( M );
            fi;
        fi;
        
        if IsHomalgInternalRingRep( R ) then
            M := EvalString( M );
            M := ListToListList( M );
            return HomalgMatrix( M, R );
        else
            if IsHomalgMatrix( arg[1] ) and IsBound( arg[1]!.ExtractHomalgMatrixAsSparse ) and arg[1]!.ExtractHomalgMatrixAsSparse = true then
                return CreateHomalgSparseMatrix( M, r, c, R );
            else
                return CreateHomalgMatrix( M, r, c, R );
            fi;
        fi;
        
    fi;
    
    Error( "wrong syntax\n" );
    
end );

##
InstallMethod( ConvertHomalgMatrixViaFile,
        "convert an external matrix into an external ring via file saving and loading",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingRep ],
        
  function( M, R )
    
    local filename, MM;
    
    filename := "temporary.txt"; #temporary name for testing purposes
    
    SaveDataOfHomalgMatrixInFile( filename, M, HomalgRing( M ) );
    
    MM := LoadDataOfHomalgMatrixFromFile( filename, R );
    
    Exec( Concatenation( "/bin/rm -f \"", filename, "\"" ) );
    
    return MM;
    
end );
