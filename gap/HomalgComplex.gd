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

# a new GAP-category:

DeclareCategory( "IsHomalgComplex",
        IsHomalgObject );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsSequence",
        IsHomalgComplex );

DeclareProperty( "IsComplex",
        IsHomalgComplex );

DeclareProperty( "IsAcyclic",
        IsHomalgComplex );

DeclareProperty( "IsGradedObject",
        IsHomalgComplex );

DeclareProperty( "IsExactSequence",
        IsHomalgComplex );

DeclareProperty( "IsShortExactSequence",	## we also need this as property!!!
        IsHomalgComplex );

DeclareProperty( "IsComplexForDefectOfExactness",		## the output of AsComplex (and only this) is marked as IsComplexForDefectOfExactness in order to distinguish
        IsHomalgComplex );			##  between different methods for DefectOfExactness which all apply to complexes

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

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgComplex ] );	## provided to avoid branching in the code and always returns fail

DeclareOperation( "ObjectDegreesOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "MorphismDegreesOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "CertainMorphism",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "CertainObject",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "MorphismsOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "ObjectsOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "LowestDegreeInComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "HighestDegreeInComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "LowestDegreeObjectInComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "HighestDegreeObjectInComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "LowestDegreeMorphismInComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "HighestDegreeMorphismInComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "SupportOfComplex",
        [ IsHomalgComplex ] );

DeclareOperation( "Add",
        [ IsHomalgComplex, IsHomalgMorphism ] );

DeclareOperation( "Add",
        [ IsHomalgComplex, IsHomalgModule ] );

DeclareOperation( "Add",
        [ IsHomalgComplex, IsHomalgMatrix ] );

DeclareOperation( "Shift",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "CertainMorphismAsSubcomplex",
        [ IsHomalgComplex, IsInt ] );

DeclareOperation( "CertainTwoMorphismsAsSubcomplex",
        [ IsHomalgComplex, IsInt ] );

