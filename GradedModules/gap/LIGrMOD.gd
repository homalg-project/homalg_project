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
        [ IsBettiTable, IsInt, IsRingElement ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsBettiTable, IsHomalgElement, IsRingElement ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsBettiTable, IsInt ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsBettiTable, IsHomalgElement ] );

DeclareOperation( "HilbertPolynomial",
        [ IsBettiTable, IsInt, IsRingElement ] );

DeclareOperation( "HilbertPolynomial",
        [ IsBettiTable, IsHomalgElement, IsRingElement ] );

DeclareOperation( "HilbertPolynomial",
        [ IsBettiTable, IsInt ] );

DeclareOperation( "HilbertPolynomial",
        [ IsBettiTable, IsHomalgElement ] );
