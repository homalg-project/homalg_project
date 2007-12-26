#############################################################################
##
##  ModuleForHomalg.gd       homalg package                  Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for modules.
##
#############################################################################


####################################
#
# Declarations for modules:
#
####################################

# A new category of objects:

DeclareCategory( "IsModuleForHomalg",
        IsAttributeStoringRep );

# Now the constructor method:

DeclareOperation( "Presentation",
        [ IsList, IsSemiringWithOneAndZero ] );
DeclareOperation( "Presentation",
        [ IsList, IsList, IsSemiringWithOneAndZero ] );

# Basic operations:

DeclareOperation( "GeneratorsOfModule",
        [ IsModuleForHomalg ] );

DeclareOperation( "RelationsOfModule",
        [ IsModuleForHomalg ] );

DeclareOperation( "NrGenerators",
        [ IsModuleForHomalg ] );

DeclareOperation( "NrRelations",
        [ IsModuleForHomalg ] );

DeclareOperation( "NumberOfKnownGeneratorRelationPairs",
        [ IsModuleForHomalg ] );

####################################
#
# filters:
#
####################################

####################
# module properties:
####################

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

DeclareProperty( "IsCyclicLeftModule",
        IsLeftModule and IsModuleForHomalg );

DeclareProperty( "IsTorsionLeftModule",
        IsLeftModule and IsModuleForHomalg );

DeclareProperty( "IsHolonomicLeftModule",
        IsLeftModule and IsModuleForHomalg );

## all modules:

DeclareProperty( "IsZeroModule",
        IsModuleForHomalg );

####################
# module attributes:
####################

#DeclareAttribute( "GeneratorsOfLeftOperatorAdditiveGroup",
#        IsModuleForHomalg );
#DeclareAttribute( "DimensionOfVectors",
#        IsModuleForHomalg );

DeclareAttribute( "NumberOfDefaultSetOfRelations",
        IsModuleForHomalg, "mutable" );

DeclareSynonymAttr( "NumberOfDefaultSetOfGenerators",
        NumberOfDefaultSetOfRelations );

#######################################################################
# The following loads the sub-package "XX":
# Note that this requires other GAP packages, which are automatically
# loaded by this command if available.
#######################################################################
#DeclareGlobalFunction( "LoadXX" );

