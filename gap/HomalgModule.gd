#############################################################################
##
##  HomalgModule.gd             homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg modules.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new category of objects:

DeclareCategory( "IsHomalgModule",
        IsAttributeStoringRep );

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "SimpleLogicalImplicationsForHomalgModules" );

####################################
#
# properties:
#
####################################

## left modules:

DeclareProperty( "IsFreeModule", ## FIXME: the name should be changed to IsFreeLeftModule
        IsHomalgModule and IsLeftModule );

DeclareProperty( "IsStablyFreeLeftModule",
        IsHomalgModule and IsLeftModule );

DeclareProperty( "IsProjectiveLeftModule",
        IsHomalgModule and IsLeftModule );

DeclareProperty( "IsReflexiveLeftModule",
        IsHomalgModule and IsLeftModule );

DeclareProperty( "IsTorsionFreeLeftModule",
        IsHomalgModule and IsLeftModule );

DeclareProperty( "IsArtinianLeftModule",
        IsHomalgModule and IsLeftModule );

DeclareProperty( "IsCyclicLeftModule",
        IsHomalgModule and IsLeftModule );

DeclareProperty( "IsTorsionLeftModule",
        IsHomalgModule and IsLeftModule );

DeclareProperty( "IsHolonomicLeftModule",
        IsHomalgModule and IsLeftModule );

## all modules:

DeclareProperty( "IsZeroModule",
        IsHomalgModule );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "RankOfLeftModule",
        IsHomalgModule and IsLeftModule );

DeclareAttribute( "ElementaryDivisorsOfLeftModule",
        IsHomalgModule and IsLeftModule );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareOperation( "Presentation",
        [ IsHomalgRelations ] );

DeclareOperation( "Presentation",
        [ IsHomalgGenerators, IsHomalgRelations ] );

DeclareOperation( "LeftPresentation",
        [ IsList, IsSemiringWithOneAndZero ] );

DeclareOperation( "LeftPresentation",
        [ IsList, IsList, IsSemiringWithOneAndZero ] );

DeclareOperation( "RightPresentation",
        [ IsList, IsSemiringWithOneAndZero ] );

DeclareOperation( "RightPresentation",
        [ IsList, IsList, IsSemiringWithOneAndZero ] );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgModule ] );

DeclareOperation( "SetsOfGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "SetsOfRelations",
        [ IsHomalgModule ] );

DeclareOperation( "NumberOfKnownPresentations",
        [ IsHomalgModule ] );

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgModule ] );

DeclareOperation( "GeneratorsOfModule",
        [ IsHomalgModule ] );

DeclareOperation( "RelationsOfModule",
        [ IsHomalgModule ] );

DeclareOperation( "MatrixOfGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "MatrixOfRelations",
        [ IsHomalgModule ] );

DeclareOperation( "NrGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "NrRelations",
        [ IsHomalgModule ] );

DeclareOperation( "AddANewPresentation",
        [ IsHomalgModule, IsHomalgGenerators ] );

DeclareOperation( "AddANewPresentation",
        [ IsHomalgModule, IsHomalgRelations ] );

DeclareOperation( "AddANewPresentation",
        [ IsHomalgModule, IsHomalgGenerators, IsHomalgRelations ] );

DeclareOperation( "BasisOfModule",
        [ IsHomalgModule ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "DecideZeroEffectively",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgModule, IsHomalgModule ] );

DeclareOperation( "NonZeroGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "GetRidOfZeroGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "BetterGenerators",
        [ IsHomalgModule ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonym( "PositionOfTheDefaultSetOfGenerators",
        PositionOfTheDefaultSetOfRelations );

DeclareSynonym( "EulerCharacteristicOfLeftModule",
        RankOfLeftModule );

DeclareSynonym( "BetterPresentation",
        GetRidOfZeroGenerators );

