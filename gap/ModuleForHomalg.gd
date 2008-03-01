#############################################################################
##
##  ModuleForHomalg.gd          homalg package               Mohamed Barakat
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

DeclareCategory( "IsModuleForHomalg",
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
        IsModuleForHomalg and IsLeftModule );

DeclareProperty( "IsStablyFreeLeftModule",
        IsModuleForHomalg and IsLeftModule );

DeclareProperty( "IsProjectiveLeftModule",
        IsModuleForHomalg and IsLeftModule );

DeclareProperty( "IsReflexiveLeftModule",
        IsModuleForHomalg and IsLeftModule );

DeclareProperty( "IsTorsionFreeLeftModule",
        IsModuleForHomalg and IsLeftModule );

DeclareProperty( "IsArtinianLeftModule",
        IsModuleForHomalg and IsLeftModule );

DeclareProperty( "IsCyclicLeftModule",
        IsModuleForHomalg and IsLeftModule );

DeclareProperty( "IsTorsionLeftModule",
        IsModuleForHomalg and IsLeftModule );

DeclareProperty( "IsHolonomicLeftModule",
        IsModuleForHomalg and IsLeftModule );

## all modules:

DeclareProperty( "IsZeroModule",
        IsModuleForHomalg );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "RankOfLeftModule",
        IsModuleForHomalg and IsLeftModule );

DeclareAttribute( "ElementaryDivisorsOfLeftModule",
        IsModuleForHomalg and IsLeftModule );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareOperation( "Presentation",
        [ IsRelationsForHomalg ] );

DeclareOperation( "Presentation",
        [ IsGeneratorsForHomalg, IsRelationsForHomalg ] );

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
        [ IsModuleForHomalg ] );

DeclareOperation( "SetsOfGenerators",
        [ IsModuleForHomalg ] );

DeclareOperation( "SetsOfRelations",
        [ IsModuleForHomalg ] );

DeclareOperation( "NumberOfKnownPresentations",
        [ IsModuleForHomalg ] );

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsModuleForHomalg ] );

DeclareOperation( "GeneratorsOfModule",
        [ IsModuleForHomalg ] );

DeclareOperation( "RelationsOfModule",
        [ IsModuleForHomalg ] );

DeclareOperation( "MatrixOfGenerators",
        [ IsModuleForHomalg ] );

DeclareOperation( "MatrixOfRelations",
        [ IsModuleForHomalg ] );

DeclareOperation( "NrGenerators",
        [ IsModuleForHomalg ] );

DeclareOperation( "NrRelations",
        [ IsModuleForHomalg ] );

DeclareOperation( "AddANewPresentation",
        [ IsModuleForHomalg, IsGeneratorsForHomalg ] );

DeclareOperation( "AddANewPresentation",
        [ IsModuleForHomalg, IsRelationsForHomalg ] );

DeclareOperation( "AddANewPresentation",
        [ IsModuleForHomalg, IsGeneratorsForHomalg, IsRelationsForHomalg ] );

DeclareOperation( "BasisOfModule",
        [ IsModuleForHomalg ] );

DeclareOperation( "DecideZero",
        [ IsMatrixForHomalg, IsModuleForHomalg ] );

DeclareOperation( "BasisCoeff",
        [ IsModuleForHomalg ] );

DeclareOperation( "EffectivelyDecideZero",
        [ IsMatrixForHomalg, IsModuleForHomalg ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsModuleForHomalg, IsModuleForHomalg ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsModuleForHomalg, IsList ] );

DeclareOperation( "NonZeroGenerators",
        [ IsModuleForHomalg ] );

DeclareOperation( "GetRidOfZeroGenerators",
        [ IsModuleForHomalg ] );

DeclareOperation( "BetterGenerators",
        [ IsModuleForHomalg ] );

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

