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

####################################
#
# categories:
#
####################################

DeclareCategory( "IsHomalgGradedRing",
        IsHomalgRing );

DeclareCategory( "IsHomalgGradedRingElement",
        IsHomalgRingElement );

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

DeclareOperation( "UnderlyingNonGradedRingElement",
        [ IsHomalgRingElement ] );

DeclareOperation( "DegreeMultivariatePolynomial",
        [ IsHomalgRingElement ] );

DeclareOperation( "ListOfDegreesOfMultiGradedRing",
        [ IsInt, IsHomalgRing, IsList ] );

DeclareOperation( "HasDegreeMultivariatePolynomial",
        [ IsHomalgGradedRingElement ] );

# constructor methods:

DeclareGlobalFunction( "GradedRingElement" );

DeclareOperation ( "GradedRing",
        [ IsHomalgRing ] );
