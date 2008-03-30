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

DeclareOperation( "LeftPresentation",
        [ IsHomalgMatrix ] );

DeclareOperation( "RightPresentation",
        [ IsList, IsSemiringWithOneAndZero ] );

DeclareOperation( "RightPresentation",
        [ IsList, IsList, IsSemiringWithOneAndZero ] );

DeclareOperation( "RightPresentation",
        [ IsHomalgMatrix ] );

DeclareOperation( "HomalgFreeLeftModule",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "HomalgFreeRightModule",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "HomalgZeroLeftModule",
        [ IsHomalgRing ] );

DeclareOperation( "HomalgZeroRightModule",
        [ IsHomalgRing ] );

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

DeclareOperation( "GeneratorsOfModule",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "RelationsOfModule",
        [ IsHomalgModule ] );

DeclareOperation( "RelationsOfModule",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "MatrixOfGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "MatrixOfGenerators",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "MatrixOfRelations",
        [ IsHomalgModule ] );

DeclareOperation( "MatrixOfRelations",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "NrGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "NrGenerators",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "NrRelations",
        [ IsHomalgModule ] );

DeclareOperation( "NrRelations",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "TransitionMatrix",
        [ IsHomalgModule, IsPosInt, IsPosInt ] );

DeclareOperation( "AddANewPresentation",
        [ IsHomalgModule, IsHomalgGenerators ] );

DeclareOperation( "AddANewPresentation",
        [ IsHomalgModule, IsHomalgRelations ] );

DeclareOperation( "AddANewPresentation",
        [ IsHomalgModule, IsHomalgRelations, IsHomalgMatrix, IsHomalgMatrix ] );

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

