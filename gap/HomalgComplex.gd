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
        IsAdditiveElementWithZero
        and IsExtLElement
        and IsAttributeStoringRep );

DeclareCategory( "IsHomalgComplexOfLeftModules",
        IsHomalgComplex );

DeclareCategory( "IsHomalgComplexOfRightModules",
        IsHomalgComplex );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsSequence",
        IsHomalgComplex );

DeclareProperty( "IsComplex",
        IsHomalgComplex );

DeclareProperty( "IsGradedObject",
        IsHomalgComplex );

DeclareProperty( "IsExactSequence",
        IsHomalgComplex );

DeclareProperty( "IsShortExactSequence",	## we also need this as property!!!
        IsHomalgComplex );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "homalgResetFiltersOfComplex" );

# constructor methods:

DeclareGlobalFunction( "HomalgComplex" );

DeclareGlobalFunction( "HomalgCocomplex" );

# basic operations:

DeclareOperation( "IsLeft",
        [ IsHomalgComplex ] );

DeclareOperation( "ModuleIndicesOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "HomalgRing",
        [ IsHomalgComplex ] );

DeclareOperation( "MorphismIndicesOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "MorphismsOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "ModulesOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "LowestDegreeModuleInComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "HighestDegreeModuleInComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "SupportOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "Add",
        [ IsHomalgComplex, IsHomalgMorphism ] );

DeclareOperation( "Add",
        [ IsHomalgComplex, IsHomalgMatrix ] );

