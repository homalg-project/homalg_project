#############################################################################
##
##  GradedRing.gd                                GradedRingForHomalg package
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

DeclareAttribute( "DegreeOfRingElementFunction",
        IsHomalgGradedRing );

DeclareAttribute( "DegreeOfRingElement",
        IsHomalgGradedRingElement );

DeclareAttribute( "DegreesOfEntriesFunction",
        IsHomalgGradedRing );

DeclareAttribute( "NonTrivialDegreePerRowFunction",
        IsHomalgGradedRing );

DeclareAttribute( "NonTrivialDegreePerRowWithColDegreesFunction",
        IsHomalgGradedRing );

DeclareAttribute( "NonTrivialDegreePerColumnFunction",
        IsHomalgGradedRing );

DeclareAttribute( "NonTrivialDegreePerColumnWithRowDegreesFunction",
        IsHomalgGradedRing );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "UnderlyingNonGradedRing",
        [ IsHomalgGradedRing ] );
        
DeclareOperation( "UnderlyingNonGradedRing",
        [ IsHomalgGradedRingElement ] );

DeclareOperation( "UnderlyingNonGradedRingElement",
        [ IsHomalgGradedRingElement ] );

DeclareOperation( "ListOfDegreesOfMultiGradedRing",
        [ IsInt, IsHomalgGradedRing, IsList ] );

# constructor methods:

DeclareGlobalFunction( "GradedRingElement" );

DeclareOperation ( "GradedRing",
        [ IsHomalgRing ] );
