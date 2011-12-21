#############################################################################
##
##  Polymake.gd               ConvexForHomalg package           Sebastian Gutsche
##
##  Copyright 2011-2012 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Gives the Methods for Polymake
##
#############################################################################

####################################
#
# Cone Methods
#
####################################

##
InstallMethod( EXT_CREATE_CONE_BY_RAYS,
               "Create Cone in Polymake",
               [ IsList ],
               
  function( rays )
    
    return POLYMAKE_CREATE_CONE_BY_RAYS( rays );
    
end );

##
InstallMethod( EXT_CREATE_DUAL_CONE_OF_CONE,
               "Create Cone in Polymake",
               [ IsPolymakeConeRep ],
               
  function( cone )
    
    return POLYMAKE_CREATE_DUAL_CONE_OF_CONE( WeakPointerToExternalObject( cone ) );
    
end );


##
InstallMethod( EXT_GENERATING_RAYS_OF_CONE,
               "Create Cone in Polymake",
               [ IsPolymakeConeRep ],
               
  function( cone )
    
    return POLYMAKE_GENERATING_RAYS_OF_CONE( WeakPointerToExternalObject( cone ) );
    
end );

##
InstallMethod( EXT_RAYS_IN_FACETS,
               " for polymake cones.",
               [ IsPolymakeConeRep ],
               
  function( cone )
    
    return POLYMAKE_RAYS_IN_FACETS( WeakPointerToExternalObject( cone ) );
    
end );

####################################
##
## Fan Methods
##
####################################

##
InstallMethod( EXT_FAN_BY_CONES,
               " for lists of cones",
               [ IsList ],
               
  function( cones )
    
    return POLYMAKE_FAN_BY_CONES( cones );
    
end );

####################################
##
## PolytopeMethods
##
####################################

##
InstallMethod( EXT_CREATE_POLYTOPE_BY_POINTS,
               "create polytope in polymake.",
               [ IsList ],
               
  function( points )
    
    return POLYMAKE_CREATE_POLYTOPE_BY_POINTS( points );
    
end );

##
InstallMethod( EXT_CREATE_POLYTOPE_BY_INEQUALITIES,
               "create polytope in polymake.",
               [ IsList ],
               
  function( points )
    
    return POLYMAKE_CREATE_POLYTOPE_BY_INEQUALITIES( points );
    
end );

##
InstallMethod( EXT_LATTICE_POINTS_OF_POLYTOPE,
               " for polymake polytopes.",
               [ IsPolymakePolytopeRep ],
                
  function( polytope )
    
    return POLYMAKE_LATTICE_POINTS_OF_POLYTOPE( WeakPointerToExternalObject( polytope ) );
    
end );


####################################
##
## Property functions
##
####################################

##
InstallMethod( EXT_IS_POINTED_CONE,
                "Checks if some cone is pointed",
                [ IsPolymakeConeRep ],
                
  function( cone )
    
    return POLYMAKE_IS_STRICTLY_CONVEX_CONE( WeakPointerToExternalObject( cone ) );
    
end );

##
InstallMethod( EXT_IS_SMOOTH_CONE,
                "Checks if some cone is pointed",
                [ IsPolymakeConeRep ],
                
  function( cone )
    
    return POLYMAKE_IS_SMOOTH_CONE( WeakPointerToExternalObject( cone ) );
    
end );

##
InstallMethod( EXT_IS_VERY_AMPLE_POLYTOPE,
               " for homalg polytope.",
               [ IsPolymakePolytopeRep ],
               
  function( polytope )
    
    return POLYMAKE_IS_VERYAMPLE_OBJECT( WeakPointerToExternalObject ( polytope ) );
    
end );

##################################
##
## Attribute Methods
##
##################################

##
InstallMethod( EXT_AMBIENT_DIM_OF_CONE,
               "computes ambient dim of polymake cone.",
               [ IsPolymakeConeRep ],
               
  function( cone )
    
    return POLYMAKE_AMBIENT_DIM_OF_CONE( WeakPointerToExternalObject( cone ) );
    
end );

##
InstallMethod( EXT_DIM_OF_CONE,
               "computes ambient dim of polymake cone.",
               [ IsPolymakeConeRep ],
               
  function( cone )
    
    return POLYMAKE_DIM_OF_CONE( WeakPointerToExternalObject( cone ) );
    
end );

##
InstallMethod( EXT_HILBERT_BASIS_OF_CONE,
               "computes hilbert basis for polymake cone",
               [ IsPolymakeConeRep ],
               
  function( cone )
    
    return POLYMAKE_HILBERT_BASIS_OF_CONE( WeakPointerToExternalObject( cone ) );
    
end );
