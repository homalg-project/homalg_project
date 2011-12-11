#############################################################################
##
##  Cone.gi         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Cones for ConvexForHomalg.
##
#############################################################################


InstallMethod( IsPointedCone,
               "for homalg cones."
               [ IsHomalgCone ]
  function( cone )
    
    return EXT_IS_POINTED_CONE( WeakPointerToExternalObject( cone ) );
    
end );