#############################################################################
##
##  ModuleForHomalg.gd          homalg package               Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
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
        IsLeftModule and IsModuleForHomalg );

DeclareProperty( "IsStablyFreeLeftModule",
        IsLeftModule and IsModuleForHomalg );

DeclareProperty( "IsProjectiveLeftModule",
        IsLeftModule and IsModuleForHomalg );

DeclareProperty( "IsReflexiveLeftModule",
        IsLeftModule and IsModuleForHomalg );

DeclareProperty( "IsTorsionFreeLeftModule",
        IsLeftModule and IsModuleForHomalg );

DeclareProperty( "IsArtinianLeftModule",
        IsLeftModule and IsModuleForHomalg );

DeclareProperty( "IsCyclicLeftModule",
        IsLeftModule and IsModuleForHomalg );

DeclareProperty( "IsTorsionLeftModule",
        IsLeftModule and IsModuleForHomalg );

DeclareProperty( "IsHolonomicLeftModule",
        IsLeftModule and IsModuleForHomalg );

## all modules:

DeclareProperty( "IsZeroModule",
        IsModuleForHomalg );

####################################
#
# attributes:
#
####################################

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareOperation( "LeftPresentation",
        [ IsList, IsSemiringWithOneAndZero ] );

DeclareOperation( "LeftPresentation",
        [ IsList, IsList, IsSemiringWithOneAndZero ] );

DeclareOperation( "RightPresentation",
        [ IsList, IsSemiringWithOneAndZero ] );

DeclareOperation( "RightPresentation",
        [ IsList, IsList, IsSemiringWithOneAndZero ] );

# basic operations:

DeclareOperation( "SetsOfGenerators",
        [ IsModuleForHomalg ] );

DeclareOperation( "SetsOfRelations",
        [ IsModuleForHomalg ] );

DeclareOperation( "NumberOfKnownPresentations",
        [ IsModuleForHomalg ] );

DeclareOperation( "NumberOfTheDefaultSetOfRelations",
        [ IsModuleForHomalg ] );

DeclareSynonym( "NumberOfTheDefaultSetOfGenerators",
        NumberOfTheDefaultSetOfRelations );

DeclareOperation( "GeneratorsOfModule",
        [ IsModuleForHomalg ] );

DeclareOperation( "RelationsOfModule",
        [ IsModuleForHomalg ] );

DeclareOperation( "NrGenerators",
        [ IsModuleForHomalg ] );

DeclareOperation( "NrRelations",
        [ IsModuleForHomalg ] );

