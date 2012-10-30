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

DeclareOperation( "EXT_CREATE_CONE_BY_INEQUALITIES",
        [ IsList ] );

DeclareOperation( "EXT_CREATE_CONE_BY_EQUALITIES_AND_INEQUALITIES",
        [ IsList, IsList ] );

DeclareOperation( "EXT_CREATE_DUAL_CONE_OF_CONE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_RAYS_IN_FACETS",
        [ IsExternalObject ] );

####################################
##
## Fan Methods
##
####################################

DeclareOperation( "EXT_FAN_BY_CONES",
        [ IsList ] );

DeclareOperation( "EXT_FAN_BY_RAYS_AND_CONES",
        [ IsList, IsList ] );

DeclareOperation( "EXT_FAN_BY_RAYS_AND_CONES_UNSAVE",
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
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_SMOOTH_CONE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_VERY_AMPLE_POLYTOPE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_COMPLETE_FAN",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_POINTED_FAN",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_SMOOTH_FAN",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_SIMPLICIAL_CONE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_SIMPLICIAL_POLYTOPE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_SIMPLE_POLYTOPE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_LATTICE_POLYTOPE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_NOT_EMPTY_POLYTOPE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_NORMAL_POLYTOPE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_REGULAR_FAN",
        [ IsExternalObject ] );

####################################
##
## Attribute Functions
##
####################################

DeclareOperation( "EXT_AMBIENT_DIM_OF_CONE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_DIM_OF_CONE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_LATTICE_POINTS_OF_POLYTOPE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_RAYS_OF_FAN",
        [ IsExternalObject ] );

DeclareOperation( "EXT_RAYS_IN_MAXCONES_OF_FAN",
        [ IsExternalObject ] );

DeclareOperation( "EXT_VERTICES_OF_POLYTOPE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_NORMALFAN_OF_POLYTOPE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_DIM_OF_FAN",
        [ IsExternalObject ] );

DeclareOperation( "EXT_AMBIENT_DIM_OF_FAN",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_FULL_DIMENSIONAL_CONE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_FULL_DIMENSIONAL_FAN",
        [ IsExternalObject ] );

DeclareOperation( "EXT_DRAW",
        [ IsExternalObject ] );

DeclareOperation( "EXT_DEFINING_INEQUALITIES_OF_CONE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_FACET_INEQUALITIES_OF_POLYTOPE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_VERTICES_IN_FACETS",
        [ IsExternalObject ] );

DeclareOperation( "EXT_INT_LATTICE_POINTS",
        [ IsExternalObject ] );

DeclareOperation( "EXT_IS_BOUNDED_POLYTOPE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS",
        [ IsList ] );

DeclareOperation( "EXT_HOMOGENEOUS_POINTS_OF_POLYTOPE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_TAIL_CONE_OF_POLYTOPE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_MINKOWSKI_SUM",
        [ IsExternalObject, IsExternalObject ] );

DeclareOperation( "EXT_LINEAR_SUBSPACE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_EQUALITIES_OF_CONE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_STELLAR_SUBDIVISION",
        [ IsExternalObject, IsExternalObject ] );

DeclareOperation( "EXT_INTERSECTION_OF_CONES",
        [ IsExternalObject, IsExternalObject ] );

DeclareOperation( "EXT_EQUALITIES_OF_POLYTOPE",
        [ IsExternalObject ] );

####################################
#
# Recover Methods
#
####################################
        
DeclareOperation( "EXT_GENERATING_RAYS_OF_CONE",
        [ IsExternalObject ] );

DeclareOperation( "EXT_HILBERT_BASIS_OF_CONE",
        [ IsExternalObject ] );

