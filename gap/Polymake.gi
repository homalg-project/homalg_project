#############################################################################
##
##  Polymake.gd             ConvexForHomalg package        Sebastian Gutsche
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
InstallMethod( EXT_CREATE_CONE_BY_INEQUALITIES,
               "create cone in polymake",
               [ IsList ],
               
    POLYMAKE_CREATE_CONE_BY_INEQUALITIES
    
);

##
InstallMethod( EXT_CREATE_CONE_BY_EQUALITIES_AND_INEQUALITIES,
               "create cone in polymake",
               [ IsList, IsList ],
               
    POLYMAKE_CREATE_CONE_BY_EQUALITIES_AND_INEQUALITIES
    
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

##
InstallMethod( EXT_LINEAR_SUBSPACE,
               "for polymake cones",
               [ IsExternalPolymakeCone ],
               
  POLYMAKE_LINEALITY_SPACE_OF_CONE
  
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

##
InstallMethod( EXT_FAN_BY_RAYS_AND_CONES_UNSAVE,
               "for lists of rays and cones.",
               [ IsList, IsList ],
               
  POLYMAKE_FAN_BY_RAYS_AND_CONES_UNSAVE
  
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
               
  POLYMAKE_IS_SIMPLICIAL_OBJECT
  
);

##
InstallMethod( EXT_IS_SIMPLE_POLYTOPE,
               " for polymake polytopes.",
               [ IsExternalPolymakePolytope ],
               
  POLYMAKE_IS_SIMPLE_OBJECT
  
);

##
InstallMethod( EXT_IS_LATTICE_POLYTOPE,
               " for polymake polytopes.",
               [ IsExternalPolymakePolytope ],
               
  POLYMAKE_IS_LATTICE_OBJECT
  
);

##
InstallMethod( EXT_IS_NOT_EMPTY_POLYTOPE,
               " for polymake polytopes.",
               [ IsExternalPolymakePolytope ],
               
  POLYMAKE_IS_NONEMPTY_POLYTOPE
  
);

##
InstallMethod( EXT_IS_NORMAL_POLYTOPE,
               " for polymake polytopes.",
               [ IsExternalPolymakePolytope ],
               
  POLYMAKE_IS_NORMAL_OBJECT
  
);

##
InstallMethod( EXT_IS_REGULAR_FAN,
               " for polymake polytopes.",
               [ IsExternalPolymakeFan ],
               
  POLYMAKE_IS_REGULAR_OBJECT
  
);

##
InstallMethod( EXT_IS_FULL_DIMENSIONAL_CONE,
               " for polymake cones.",
               [ IsExternalPolymakeCone ],
               
  POLYMAKE_IS_FULL_DIMENSIONAL_OBJECT
  
);

##
InstallMethod( EXT_IS_FULL_DIMENSIONAL_FAN,
               " for polymake cones.",
               [ IsExternalPolymakeFan ],
               
  POLYMAKE_IS_FULL_DIMENSIONAL_OBJECT
  
);

##
InstallMethod( EXT_EQUALITIES_OF_CONE,
               " for polymake cones.",
               [ IsExternalPolymakeCone ],
               
  POLYMAKE_EQUALITIES_OF_CONE
  
);

##################################
##
## Attribute Methods
##
##################################

##
InstallMethod( EXT_AMBIENT_DIM_OF_CONE,
               "computes ambient dim of polymake cone.",
               [ IsExternalPolymakeCone ],
               
  POLYMAKE_AMBIENT_DIM_OF_CONE
  
);

##
InstallMethod( EXT_DIM_OF_CONE,
               "computes ambient dim of polymake cone.",
               [ IsExternalPolymakeCone ],
               
  POLYMAKE_DIM_OF_CONE
  
);

##
InstallMethod( EXT_HILBERT_BASIS_OF_CONE,
               "computes hilbert basis for polymake cone",
               [ IsExternalPolymakeCone ],
               
  POLYMAKE_HILBERT_BASIS_OF_CONE
  
);

##
InstallMethod( EXT_RAYS_OF_FAN,
               " computes fans of polymake fan",
               [ IsExternalPolymakeFan ],
               
  POLYMAKE_RAYS_OF_FAN
  
);

# ##
# InstallMethod( EXT_RAYS_OF_FAN,
#                " computes fans of polymake fan",
#                [ IsExternalPolymakeCone ],
#                
#   POLYMAKE_RAYS_OF_FAN
#   
# );

##
InstallMethod( EXT_RAYS_IN_MAXCONES_OF_FAN,
               " computes fans of polymake fan",
               [ IsExternalPolymakeFan ],
               
  POLYMAKE_RAYS_IN_MAXCONES_OF_FAN
  
);

##
InstallMethod( EXT_NORMALFAN_OF_POLYTOPE,
               " computes fans of polymake fan",
               [ IsExternalPolymakePolytope ],
               
  POLYMAKE_NORMALFAN_OF_POLYTOPE
  
);

##
InstallMethod( EXT_DIM_OF_FAN,
               " computes fans of polymake fan",
               [ IsExternalPolymakeFan ],
               
  POLYMAKE_DIM_OF_FAN
  
);

##
InstallMethod( EXT_AMBIENT_DIM_OF_FAN,
               " computes fans of polymake fan",
               [ IsExternalPolymakeFan ],
               
  POLYMAKE_AMBIENT_DIM_OF_FAN
  
);

##
InstallMethod( EXT_DRAW,
               "draws a polymake object",
               [ IsExternalPolymakeObject ],
               
  POLYMAKE_DRAW
  
);

##
InstallMethod( EXT_DEFINING_INEQUALITIES_OF_CONE,
               " computes inequalities of polymake cone",
               [ IsExternalPolymakeCone ],
               
  POLYMAKE_DEFINING_INEQUALITIES_OF_CONE
  
);

##
InstallMethod( EXT_FACET_INEQUALITIES_OF_POLYTOPE,
               " for polymake polytopes",
               [ IsExternalPolymakePolytope ],
               
  POLYMAKE_FACET_INEQUALITIES_OF_POLYTOPE
  
);

##
InstallMethod( EXT_VERTICES_IN_FACETS,
               " for polymake polytopes",
               [ IsExternalPolymakePolytope ],
               
  POLYMAKE_RAYS_IN_FACETS
  
);

##
InstallMethod( EXT_INT_LATTICE_POINTS,
               " for polymake polytopes.",
               [ IsExternalPolymakePolytope ],
               
  POLYMAKE_INTERIOR_LATTICE_POINTS
  
);

##
InstallMethod( EXT_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS,
               "for polymake polytopes.",
               [ IsList ],
               
  POLYMAKE_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS
  
);

##
InstallMethod( EXT_HOMOGENEOUS_POINTS_OF_POLYTOPE,
               "for polymake polytopes",
               [ IsExternalPolymakePolytope ],
               
  POLYMAKE_HOMOGENEOUS_POINTS_OF_POLYTOPE
  
);

##
InstallMethod( EXT_TAIL_CONE_OF_POLYTOPE,
               "for polymake polytopes",
               [ IsExternalPolymakePolytope ],
               
  POLYMAKE_TAIL_CONE_OF_POLYTOPE
  
);

##
InstallMethod( EXT_MINKOWSKI_SUM,
               "for polymake polytopes",
               [ IsExternalPolymakePolytope, IsExternalPolymakePolytope ],
               
  POLYMAKE_MINKOWSKI_SUM
  
);

##
InstallMethod( EXT_STELLAR_SUBDIVISION,
               "for polymake polytopes",
               [ IsExternalPolymakeCone , IsExternalPolymakeFan ],
               
  POLYMAKE_STELLAR_SUBDIVISION
  
);

##
InstallMethod( EXT_INTERSECTION_OF_CONES,
               "for polymake cones",
        [ IsExternalPolymakeCone, IsExternalPolymakeCone ], 
        
  POLYMAKE_INTERSECTION_OF_CONES
  
);

##
InstallMethod( EXT_EQUALITIES_OF_POLYTOPE,
               "for polymake polytopes",
               [ IsExternalPolymakePolytope ],
               
  POLYMAKE_EQUALITIES_OF_POLYTOPE
  
);
