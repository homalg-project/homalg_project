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
               
    POLYMAKE_CREATE_CONE_BY_RAYS
  
);

##
InstallMethod( EXT_CREATE_DUAL_CONE_OF_CONE,
               "Create Cone in Polymake",
               [ IsExternalPolymakeCone ],
               
    POLYMAKE_CREATE_DUAL_CONE_OF_CONE
  
);


##
InstallMethod( EXT_GENERATING_RAYS_OF_CONE,
               "Create Cone in Polymake",
               [ IsExternalPolymakeCone ],
               
  POLYMAKE_GENERATING_RAYS_OF_CONE
  
);

##
InstallMethod( EXT_RAYS_IN_FACETS,
               " for polymake cones.",
               [ IsExternalPolymakeCone ],
               
  POLYMAKE_RAYS_IN_FACETS
  
);

##
InstallMethod( EXT_IS_BOUNDED_POLYTOPE,
               " for polymake cones.",
               [ IsExternalPolymakePolytope ],
               
  POLYMAKE_IS_BOUNDED_POLYTOPE
  
);


####################################
##
## Fan Methods
##
####################################

##
InstallMethod( EXT_FAN_BY_CONES,
               " for lists of cones",
               [ IsList ],
               
  POLYMAKE_FAN_BY_CONES
  
);

##
InstallMethod( EXT_FAN_BY_RAYS_AND_CONES,
               " for lists of rays and cones.",
               [ IsList, IsList ],
               
  POLYMAKE_FAN_BY_RAYS_AND_CONES
  
);

####################################
##
## PolytopeMethods
##
####################################

##
InstallMethod( EXT_CREATE_POLYTOPE_BY_POINTS,
               "create polytope in polymake.",
               [ IsList ],
               
  POLYMAKE_CREATE_POLYTOPE_BY_POINTS
  
);

##
InstallMethod( EXT_CREATE_POLYTOPE_BY_INEQUALITIES,
               "create polytope in polymake.",
               [ IsList ],
               
  POLYMAKE_CREATE_POLYTOPE_BY_INEQUALITIES
  
);

##
InstallMethod( EXT_LATTICE_POINTS_OF_POLYTOPE,
               " for polymake polytopes.",
               [ IsExternalPolymakePolytope ],
                
  POLYMAKE_LATTICE_POINTS_OF_POLYTOPE
  
);

##
InstallMethod( EXT_VERTICES_OF_POLYTOPE,
               " for polymake polytopes.",
               [ IsExternalPolymakePolytope ],
                
  POLYMAKE_VERTICES_OF_POLYTOPE
  
);

####################################
##
## Property functions
##
####################################

##
InstallMethod( EXT_IS_POINTED_CONE,
                "Checks if some cone is pointed",
                [ IsExternalPolymakeCone ],
                
  POLYMAKE_IS_STRICTLY_CONVEX_CONE
  
);

##
InstallMethod( EXT_IS_SMOOTH_CONE,
                "Checks if some cone is pointed",
                [ IsExternalPolymakeCone ],
                
  POLYMAKE_IS_SMOOTH_CONE
  
);

##
InstallMethod( EXT_IS_VERY_AMPLE_POLYTOPE,
               " for homalg polytope.",
               [ IsExternalPolymakePolytope ],
               
  POLYMAKE_IS_VERYAMPLE_OBJECT
  
);

##
InstallMethod( EXT_IS_COMPLETE_FAN,
               " for polymake fans.",
               [ IsExternalPolymakeFan ],
               
  POLYMAKE_IS_COMPLETE_FAN
  
);

##
InstallMethod( EXT_IS_POINTED_FAN,
               " for polymake fans.",
               [ IsExternalPolymakeFan ],
               
  POLYMAKE_IS_POINTED_FAN
  
);

##
InstallMethod( EXT_IS_SMOOTH_FAN,
               " for polymake fans.",
               [ IsExternalPolymakeFan ],
               
  POLYMAKE_IS_SMOOTH_FAN
  
);

##
InstallMethod( EXT_IS_SIMPLICIAL_CONE,
               " for polymake cones.",
               [ IsExternalPolymakeCone ],
               
  POLYMAKE_IS_SIMPLICIAL_CONE
  
);

##
InstallMethod( EXT_IS_SIMPLICIAL_POLYTOPE,
               " for polymake polytopes.",
               [ IsExternalPolymakePolytope ],
               
  function( polytope )
    
    return POLYMAKE_IS_SIMPLICIAL_OBJECT( polytope );
    
end );

##
InstallMethod( EXT_IS_SIMPLE_POLYTOPE,
               " for polymake polytopes.",
               [ IsExternalPolymakePolytope ],
               
  function( polytope )
    
    return POLYMAKE_IS_SIMPLE_OBJECT( polytope );
    
end );

##
InstallMethod( EXT_IS_LATTICE_POLYTOPE,
               " for polymake polytopes.",
               [ IsExternalPolymakePolytope ],
               
  function( polytope )
    
    return POLYMAKE_IS_LATTICE_OBJECT( polytope );
    
end );

##
InstallMethod( EXT_IS_NOT_EMPTY_POLYTOPE,
               " for polymake polytopes.",
               [ IsExternalPolymakePolytope ],
               
  function( polytope )
    
    return POLYMAKE_IS_NONEMPTY_POLYTOPE( polytope );
    
end );

##
InstallMethod( EXT_IS_NORMAL_POLYTOPE,
               " for polymake polytopes.",
               [ IsExternalPolymakePolytope ],
               
  function( polytope )
    
    return POLYMAKE_IS_NORMAL_OBJECT( polytope );
    
end );

##
InstallMethod( EXT_IS_REGULAR_FAN,
               " for polymake polytopes.",
               [ IsExternalPolymakeFan ],
               
  function( fan )
    
    return POLYMAKE_IS_REGULAR_OBJECT( fan );
    
end );

##
InstallMethod( EXT_IS_FULL_DIMENSIONAL_CONE,
               " for polymake cones.",
               [ IsExternalPolymakeCone ],
               
  function( cone )
    
    return POLYMAKE_IS_FULL_DIMENSIONAL_OBJECT( cone );
    
end );

##
InstallMethod( EXT_IS_FULL_DIMENSIONAL_FAN,
               " for polymake cones.",
               [ IsExternalPolymakeFan ],
               
  function( fan )
    
    return POLYMAKE_IS_FULL_DIMENSIONAL_OBJECT( fan );
    
end );

##################################
##
## Attribute Methods
##
##################################

##
InstallMethod( EXT_AMBIENT_DIM_OF_CONE,
               "computes ambient dim of polymake cone.",
               [ IsExternalPolymakeCone ],
               
  function( cone )
    
    return POLYMAKE_AMBIENT_DIM_OF_CONE( cone );
    
end );

##
InstallMethod( EXT_DIM_OF_CONE,
               "computes ambient dim of polymake cone.",
               [ IsExternalPolymakeCone ],
               
  function( cone )
    
    return POLYMAKE_DIM_OF_CONE( cone );
    
end );

##
InstallMethod( EXT_HILBERT_BASIS_OF_CONE,
               "computes hilbert basis for polymake cone",
               [ IsExternalPolymakeCone ],
               
  function( cone )
    
    return POLYMAKE_HILBERT_BASIS_OF_CONE( cone );
    
end );

##
InstallMethod( EXT_RAYS_OF_FAN,
               " computes fans of polymake fan",
               [ IsExternalPolymakeFan ],
               
  function( fan )
    
    return POLYMAKE_RAYS_OF_FAN( fan );
    
end );

##
InstallMethod( EXT_RAYS_IN_MAXCONES_OF_FAN,
               " computes fans of polymake fan",
               [ IsExternalPolymakeFan ],
               
  function( fan )
    
    return POLYMAKE_RAYS_IN_MAXCONES_OF_FAN( fan );
    
end );

##
InstallMethod( EXT_NORMALFAN_OF_POLYTOPE,
               " computes fans of polymake fan",
               [ IsExternalPolymakePolytope ],
               
  function( polytope )
    
    return POLYMAKE_NORMALFAN_OF_POLYTOPE( polytope );
    
end );

##
InstallMethod( EXT_DIM_OF_FAN,
               " computes fans of polymake fan",
               [ IsExternalPolymakeFan ],
               
  function( fan )
    
    return POLYMAKE_DIM_OF_FAN( fan );
    
end );

##
InstallMethod( EXT_AMBIENT_DIM_OF_FAN,
               " computes fans of polymake fan",
               [ IsExternalPolymakeFan ],
               
  function( fan )
    
    return POLYMAKE_AMBIENT_DIM_OF_FAN( fan );
    
end );

##
InstallMethod( EXT_DRAW,
               " computes fans of polymake fan",
               [ IsExternalPolymakeFan ],
               
  function( convobj )
    
    return POLYMAKE_DRAW( convobj );
    
end );

##
InstallMethod( EXT_DRAW,
               " computes fans of polymake fan",
               [ IsExternalPolymakePolytope ],
               
  function( convobj )
    
    return POLYMAKE_DRAW( convobj );
    
end );

##
InstallMethod( EXT_DEFINING_INEQUALITIES_OF_CONE,
               " computes inequalities of polymake cone",
               [ IsExternalPolymakeCone ],
               
  function( cone )
    
    return POLYMAKE_DEFINING_INEQUALITIES_OF_CONE( cone );
    
end );

##
InstallMethod( EXT_FACET_INEQUALITIES_OF_POLYTOPE,
               " for polymake polytopes",
               [ IsExternalPolymakePolytope ],
               
  function( polytope )
    
    return POLYMAKE_FACET_INEQUALITIES_OF_POLYTOPE( polytope );
    
end );

##
InstallMethod( EXT_VERTICES_IN_FACETS,
               " for polymake polytopes",
               [ IsExternalPolymakePolytope ],
               
  function( polytope )
    
    return POLYMAKE_RAYS_IN_FACETS( polytope );
    
end );

##
InstallMethod( EXT_INT_LATTICE_POINTS,
               " for polymake polytopes.",
               [ IsExternalPolymakePolytope ],
               
  function( polytope )
    
    return POLYMAKE_INTERIOR_LATTICE_POINTS( polytope );
    
end );
