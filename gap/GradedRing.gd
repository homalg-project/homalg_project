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

DeclareOperation( "ListOfDegreesOfMultiGradedRing",
        [ IsInt, IsHomalgRing, IsList ] );

# constructor methods:

DeclareGlobalFunction( "GradedRingElement" );

DeclareOperation ( "GradedRing",
        [ IsHomalgRing ] );
