#############################################################################
##
##  HomalgComplex.gd            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg complexes.
##
#############################################################################

####################################
#
# categories:
#
####################################

# four new category of objects:

DeclareCategory( "IsHomalgComplex",
        IsAttributeStoringRep );

DeclareCategory( "IsHomalgComplexOfLeftModules",
        IsHomalgComplex );

DeclareCategory( "IsHomalgComplexOfRightModules",
        IsHomalgComplex );

####################################
#
# properties:
#
####################################

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "HomalgComplex" );

DeclareGlobalFunction( "HomalgCocomplex" );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgComplex ] );

DeclareOperation( "IsSequence",
        [ IsHomalgComplex ] );

DeclareOperation( "IsComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "IsZeroComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "IsGradedObject",
        [ IsHomalgComplex ] );

DeclareOperation( "IsExactSequence",
        [ IsHomalgComplex ] );

DeclareOperation( "IsShortExactSequence",
        [ IsHomalgComplex ] );

