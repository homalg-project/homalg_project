#############################################################################
##
##  ExternalSystem.gd          ConvexForHomalg package      Sebastian Gutsche
##
##  Copyright 2011-2012 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declares Methods for an external CAS
##
#############################################################################

####################################
##
## Cone Methods
##
####################################

DeclareOperation( "EXT_CREATE_CONE_BY_RAYS",
        [ IsList ] );
        
DeclareOperation( "EXT_CREATE_DUAL_CONE_OF_CONE",
        [ IsCone and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_RAYS_IN_FACETS",
        [ IsCone and IsExternalConvexObjectRep ] );

####################################
##
## Fan Methods
##
####################################

DeclareOperation( "EXT_FAN_BY_CONES",
        [ IsList ] );

DeclareOperation( "EXT_FAN_BY_RAYS_AND_CONES",
        [ IsList, IsList ] );

####################################
##
## Polytope Methods
##
####################################

DeclareOperation( "EXT_CREATE_POLYTOPE_BY_POINTS",
        [ IsList ] );

DeclareOperation( "EXT_CREATE_POLYTOPE_BY_INEQUALITIES",
        [ IsList ] );

####################################
##
## Property Functions
##
####################################

DeclareOperation( "EXT_IS_POINTED_CONE",
        [ IsCone and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_SMOOTH_CONE",
        [ IsCone and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_VERY_AMPLE_POLYTOPE",
        [ IsPolytope and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_COMPLETE_FAN",
        [ IsFan and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_POINTED_FAN",
        [ IsFan and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_SMOOTH_FAN",
        [ IsFan and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_SIMPLICIAL_CONE",
        [ IsCone and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_SIMPLICIAL_POLYTOPE",
        [ IsPolytope and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_SIMPLE_POLYTOPE",
        [ IsPolytope and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_LATTICE_POLYTOPE",
        [ IsPolytope and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_NOT_EMPTY_POLYTOPE",
        [ IsPolytope and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_NORMAL_POLYTOPE",
        [ IsPolytope and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_REGULAR_FAN",
        [ IsFan and IsExternalConvexObjectRep ] );

####################################
##
## Attribute Functions
##
####################################

DeclareOperation( "EXT_AMBIENT_DIM_OF_CONE",
        [ IsCone and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_DIM_OF_CONE",
        [ IsCone and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_LATTICE_POINTS_OF_POLYTOPE",
        [ IsPolytope and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_RAYS_OF_FAN",
        [ IsFan and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_RAYS_IN_MAXCONES_OF_FAN",
        [ IsFan and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_VERTICES_OF_POLYTOPE",
        [ IsPolytope and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_NORMALFAN_OF_POLYTOPE",
        [ IsPolytope and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_DIM_OF_FAN",
        [ IsFan and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_AMBIENT_DIM_OF_FAN",
        [ IsFan and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_FULL_DIMENSIONAL_CONE",
        [ IsCone and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_IS_FULL_DIMENSIONAL_FAN",
        [ IsFan and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_DRAW",
        [ IsConvexObject and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_DEFINING_INEQUALITIES_OF_CONE",
        [ IsCone and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_FACET_INEQUALITIES_OF_POLYTOPE",
        [ IsPolytope and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_VERTICES_IN_FACETS",
        [ IsPolytope and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_INT_LATTICE_POINTS",
        [ IsPolytope and IsExternalConvexObjectRep ] );


####################################
#
# Recover Methods
#
####################################
        
DeclareOperation( "EXT_GENERATING_RAYS_OF_CONE",
        [ IsCone and IsExternalConvexObjectRep ] );

DeclareOperation( "EXT_HILBERT_BASIS_OF_CONE",
        [ IsCone and IsExternalConvexObjectRep ] );

