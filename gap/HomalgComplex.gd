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

DeclareProperty( "IsComplex",
        IsHomalgComplex );

DeclareProperty( "IsExactSequence",
        IsHomalgComplex );

DeclareProperty( "IsShortExactSequence",
        IsHomalgComplex );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "HomalgComplex" );

DeclareOperation( "HomalgRing",
        [ IsHomalgComplex ] );

