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
InstallMethod( CreateHomalgMatrixInExternalCAS,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgExternalRingRep ],
        
  function( M, R )
    
    return CreateHomalgMatrixInExternalCAS( String( Eval( M ) ), R );
    
end );

##
InstallGlobalFunction( ConvertHomalgMatrix,
  function( arg )
    local nargs, M, o, R, r, c;
    
    nargs := Length( arg );
    
    if nargs = 2 and ( IsHomalgMatrix( arg[1] ) or IsString( arg[1] ) ) and IsHomalgRing( arg[2] ) then
        
        if IsHomalgInternalMatrixRep( arg[1] ) or IsString( arg[1] ) then
            M := arg[1];
        else
            M := GetListListOfHomalgExternalMatrixAsString( arg[1] );
            o := homalgStream( HomalgRing( arg[1] ) );
            if not ( IsBound( o.leave_spaces ) and o.leave_spaces = true ) then
                RemoveCharacters( M, " " );
            fi;
        fi;
        
        R := arg[2];
        
        if IsHomalgInternalRingRep( R ) then
            return HomalgMatrix( EvalString( M ), R );
        else
            return CreateHomalgMatrixInExternalCAS( M, R );
        fi;
        
    elif nargs = 4 and ( IsHomalgMatrix( arg[1] ) or IsString( arg[1] ) ) and IsHomalgRing( arg[4] ) then
        
        if IsHomalgInternalMatrixRep( arg[1] ) or IsString( arg[1] ) then
            M := arg[1];
        else
            M := GetListOfHomalgExternalMatrixAsString( arg[1] );
            o := homalgStream( HomalgRing( arg[1] ) );
            if not ( IsBound( o.leave_spaces ) and o.leave_spaces = true ) then
                RemoveCharacters( M, " " );
            fi;
        fi;
        
        r := arg[2];
        c := arg[3];
        R := arg[4];
        
        if IsHomalgInternalRingRep( R ) then
            M := EvalString( M );
            M := ListToListList( M );
            return HomalgMatrix( M, R );
        else
            return CreateHomalgMatrixInExternalCAS( M, r, c, R );
        fi;
        
    fi;
    
    Error( "wrong syntax\n" );
    
end );

##
InstallMethod( GetListOfHomalgExternalMatrixAsString,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    
    return GetListOfHomalgExternalMatrixAsString( M, HomalgRing( M ) );
    
end );

##
InstallMethod( GetListListOfHomalgExternalMatrixAsString,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    
    return GetListListOfHomalgExternalMatrixAsString( M, HomalgRing( M ) );
    
end );

