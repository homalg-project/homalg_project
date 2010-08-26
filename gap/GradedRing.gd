#############################################################################
##
##  GradedRing.gd           GradedRingForHomalg package      Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations of procedures for graded rings.
##
#############################################################################

DeclareCategory( "IsHomalgGradedRing",
        IsHomalgRing );

####################################
#
# attributes:
#
####################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "UnderlyingNonGradedRing",
        [ IsHomalgGradedRing ] );
        
DeclareOperation( "UnderlyingNonGradedRing",
        [ IsHomalgRingElement ] );

DeclareOperation( "UnderlyingNonGradedRing",
        [ IsHomalgMatrix ] );

DeclareOperation( "UnderlyingNonGradedMatrix",
        [ IsHomalgMatrix ] );

DeclareOperation( "UnderlyingNonGradedRingElement",
        [ IsHomalgRingElement ] );

DeclareOperation( "ListOfDegreesOfMultiGradedRing",
        [ IsInt, IsHomalgGradedRing, IsList ] );

DeclareOperation( "MonomialMatrix",
        [ IsInt, IsHomalgGradedRing, IsList ] );

DeclareOperation( "MonomialMatrix",
        [ IsInt, IsHomalgGradedRing ] );

DeclareOperation( "MonomialMatrix",
        [ IsList, IsHomalgGradedRing, IsList ] );

DeclareOperation( "MonomialMatrix",
        [ IsList, IsHomalgGradedRing ] );

DeclareOperation( "RandomMatrixBetweenGradedFreeLeftModules",
        [ IsList, IsList, IsHomalgRing ] );

DeclareOperation( "RandomMatrixBetweenGradedFreeRightModules",
        [ IsList, IsList, IsHomalgRing ] );


# constructor methods:

DeclareGlobalFunction( "GradedRingElement" );

DeclareOperation( "BlindlyCopyMatrixPropertiesToGradedMatrix",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "BlindlyCopyRingPropertiesToGradedRing",
        [ IsHomalgRing, IsHomalgGradedRing ] );

DeclareOperation( "GradedMatrix",
        [ IsHomalgMatrix, IsHomalgGradedRing ] );

DeclareOperation ( "GradedRing",
        [ IsHomalgRing ] );