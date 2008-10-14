#############################################################################
##
##  HomalgFiltration.gd         homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for a filtration.
##
#############################################################################

####################################
#
# categories:
#
####################################

# A new GAP-category:

DeclareCategory( "IsHomalgFiltration",
        IsAttributeStoringRep );

## CAUTION: in the code the following two categories are the only ones for sets of generators,
##          i.e. IsHomalgFiltration and not IsHomalgFiltrationOfLeftModule => IsHomalgFiltrationOfRightModule

DeclareCategory( "IsHomalgFiltrationOfLeftModule",
        IsHomalgFiltration );

DeclareCategory( "IsHomalgFiltrationOfRightModule",
        IsHomalgFiltration );

DeclareCategory( "IsDescendingFiltration",
        IsHomalgFiltration );

DeclareCategory( "IsAscendingFiltration",
        IsHomalgFiltration );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsGradation",
        IsHomalgFiltration );

DeclareProperty( "IsFiltration",
        IsHomalgFiltration );

DeclareProperty( "IsPurityFiltration",
        IsHomalgFiltration );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "HomalgFiltration" );

DeclareGlobalFunction( "HomalgDescendingFiltration" );

DeclareGlobalFunction( "HomalgAscendingFiltration" );

# basic operations:

DeclareOperation( "DegreesOfFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "LowestDegree",
        [ IsHomalgFiltration ] );

DeclareOperation( "HighestDegree",
        [ IsHomalgFiltration ] );

DeclareOperation( "CertainMorphism",
        [ IsHomalgFiltration, IsInt ] );

DeclareOperation( "CertainObject",
        [ IsHomalgFiltration, IsInt ] );

DeclareOperation( "ObjectsOfFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "HomalgRing",
        [ IsHomalgFiltration ] );

DeclareOperation( "MorphismsOfFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "LowestDegreeMorphism",
        [ IsHomalgFiltration ] );

DeclareOperation( "HighestDegreeMorphism",
        [ IsHomalgFiltration ] );

DeclareOperation( "UnderlyingModule",
        [ IsHomalgFiltration ] );

DeclareOperation( "MatrixOfFiltration",
        [ IsHomalgFiltration, IsInt ] );

DeclareOperation( "MatrixOfFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "IsomorphismOfFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "BasisOfModule",
        [ IsHomalgFiltration ] );

DeclareOperation( "DecideZero",
        [ IsHomalgFiltration ] );

DeclareOperation( "OnLessGenerators",
        [ IsHomalgFiltration ] );

DeclareOperation( "ByASmallerPresentation",
        [ IsHomalgFiltration ] );

DeclareOperation( "UnlockModule",
        [ IsHomalgFiltration ] );

DeclareOperation( "UnlockFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "AssociatedSecondSpectralSequence",
        [ IsHomalgFiltration ] );

