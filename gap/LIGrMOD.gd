#############################################################################
##
##  LIGrMOD.gd                                            LIGrMOD subpackage
##
##         LIGrMOD = Logical Implications for Graded MODules
##
##  Copyright 2010,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declarations for the LIGrMOD subpackage.
##
#############################################################################

# our info class:
DeclareInfoClass( "InfoLIGrMOD" );
SetInfoLevel( InfoLIGrMOD, 1 );

####################################
#
# global variables:
#
####################################

# a central place for configurations:
DeclareGlobalVariable( "LIGrMOD" );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "HilbertPoincareSeries",
        [ IsBettiDiagram, IsInt, IsRingElement ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsBettiDiagram, IsInt ] );

DeclareOperation( "HilbertPolynomial",
        [ IsBettiDiagram, IsInt, IsRingElement ] );

DeclareOperation( "HilbertPolynomial",
        [ IsBettiDiagram, IsInt ] );
