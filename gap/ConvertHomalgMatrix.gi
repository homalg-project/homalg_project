#############################################################################
##
##  HomalgMatrix.gi             RingsForHomalg package       Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg matrices.
##
#############################################################################

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
    local nargs, M, R, r, c;
    
    nargs := Length( arg );
    
    if nargs = 2 and ( IsHomalgMatrix( arg[1] ) or IsString( arg[1] ) ) and IsHomalgRing( arg[2] ) then
        
        M := arg[1];
        R := arg[2];
        
        return CreateHomalgMatrixInExternalCAS( M, R );
        
    elif nargs = 4 and ( IsHomalgMatrix( arg[1] ) or IsString( arg[1] ) ) and IsHomalgRing( arg[4] ) then
        
        M := arg[1];
        r := arg[2];
        c := arg[3];
        R := arg[4];
        
        return CreateHomalgMatrixInExternalCAS( M, r, c, R );
        
    fi;
    
    Error( "wrong syntax\n" );
    
end );

