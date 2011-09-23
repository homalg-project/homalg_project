#############################################################################
##
##  LIGrRNG.gd                  LIGrRNG subpackage           Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##         LIGrRNG = Logical Implications for homalg GRaded RiNGs
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations for the LIGrRNG subpackage.
##
#############################################################################

# our info class:
DeclareInfoClass( "InfoLIGRNG" );
SetInfoLevel( InfoLIGRNG, 1 );

# a central place for configurations:
DeclareGlobalVariable( "LIGrRNG" );

####################################
#
# properties:
#
####################################

####################################
#
# attributes:
#
####################################

DeclareAttribute( "MaximalIdealAsColumnMatrix",
        IsHomalgGradedRing );

DeclareAttribute( "MaximalIdealAsRowMatrix",
        IsHomalgGradedRing );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "HelperToInstallMethodsForGradedRingElementsAttributes" );
