#############################################################################
##
##  MatricesForHomalg.gd        MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg.
##
#############################################################################


# our info classes:
DeclareInfoClass( "InfoMatricesForHomalg" );
SetInfoLevel( InfoMatricesForHomalg, 1 );

DeclareInfoClass( "InfoHomalgBasicOperations" );
SetInfoLevel( InfoHomalgBasicOperations, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_MATRICES" );

####################################
#
# categories:
#
####################################

# three new categories:

## this is the super super GAP-category which will include the GAP-categories
## IsStructureObjectOrObject and IsHomalgObjectOrMorphism:
DeclareCategory( "IsStructureObjectOrObjectOrMorphism",
        IsAttributeStoringRep );

## this is the super GAP-category which will include the GAP-categories
## IsHomalgRing, IsHomalgModule, IsHomalgRingOrModule and IsHomalgComplex
DeclareCategory( "IsStructureObjectOrObject",
        IsStructureObjectOrObjectOrMorphism );

## this is the super GAP-category which will include the GAP-categories IsHomalgRing
## we need this GAP-category to define things like Hom(M,R) as easy as Hom(M,N)
## without distinguishing between structure objects (e.g. rings) and objects (e.g. modules)
DeclareCategory( "IsStructureObject",
        IsStructureObjectOrObject );

## this is the super GAP-category which will include the GAP-categories
## IsHomalgRing, IsHomalgModule:
DeclareCategory( "IsHomalgRingOrModule",
        IsStructureObjectOrObject );

# a new GAP-category:

DeclareCategory( "IsContainerForWeakPointers",
        IsComponentObjectRep );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "ContainerForWeakPointers" );

DeclareGlobalFunction( "homalgTotalRuntimes" );

DeclareGlobalFunction( "AddLeftRightLogicalImplicationsForHomalg" );

DeclareGlobalFunction( "LogicalImplicationsForOneHomalgObject" );

DeclareGlobalFunction( "LogicalImplicationsForTwoHomalgBasicObjects" );

DeclareGlobalFunction( "InstallLogicalImplicationsForHomalgBasicObjects" );

DeclareGlobalFunction( "LeftRightAttributesForHomalg" );

DeclareGlobalFunction( "InstallLeftRightAttributesForHomalg" );

DeclareGlobalFunction( "MatchPropertiesAndAttributes" );

DeclareGlobalFunction( "InstallImmediateMethodToPullPropertyOrAttribute" );

DeclareGlobalFunction( "InstallImmediateMethodToConditionallyPullPropertyOrAttribute" );

DeclareGlobalFunction( "InstallImmediateMethodToPullPropertyOrAttributeWithDifferentName" );

DeclareGlobalFunction( "InstallImmediateMethodToPullPropertiesOrAttributes" );

DeclareGlobalFunction( "InstallImmediateMethodToPullTrueProperty" );

DeclareGlobalFunction( "InstallImmediateMethodToConditionallyPullTrueProperty" );

DeclareGlobalFunction( "InstallImmediateMethodToPullTruePropertyWithDifferentName" );

DeclareGlobalFunction( "InstallImmediateMethodToPullTrueProperties" );

DeclareGlobalFunction( "InstallImmediateMethodToPullFalseProperty" );

DeclareGlobalFunction( "InstallImmediateMethodToConditionallyPullFalseProperty" );

DeclareGlobalFunction( "InstallImmediateMethodToPullFalsePropertyWithDifferentName" );

DeclareGlobalFunction( "InstallImmediateMethodToPullFalseProperties" );

DeclareGlobalFunction( "InstallImmediateMethodToPushPropertyOrAttribute" );

DeclareGlobalFunction( "InstallImmediateMethodToConditionallyPushPropertyOrAttribute" );

DeclareGlobalFunction( "InstallImmediateMethodToPushPropertyOrAttributeWithDifferentName" );

DeclareGlobalFunction( "InstallImmediateMethodToPushPropertiesOrAttributes" );

DeclareGlobalFunction( "InstallImmediateMethodToPushTrueProperty" );

DeclareGlobalFunction( "InstallImmediateMethodToPushTruePropertyWithDifferentName" );

DeclareGlobalFunction( "InstallImmediateMethodToPushTrueProperties" );

DeclareGlobalFunction( "InstallImmediateMethodToPushFalseProperty" );

DeclareGlobalFunction( "InstallImmediateMethodToPushFalsePropertyWithDifferentName" );

DeclareGlobalFunction( "InstallImmediateMethodToPushFalseProperties" );

DeclareGlobalFunction( "AppendToAhomalgTable" );

DeclareGlobalFunction( "homalgNamesOfComponentsToIntLists" );

DeclareGlobalFunction( "homalgMode" );

DeclareGlobalFunction( "IncreaseExistingCounterInObject" );

DeclareGlobalFunction( "IncreaseCounterInObject" );

DeclareGlobalFunction( "MemoryToString" );

# basic operations:

DeclareOperation( "homalgLaTeX",
        [ IsObject ] );

DeclareOperation( "ExamplesForHomalg",
        [ ] );

DeclareOperation( "ExamplesForHomalg",
        [ IsInt ] );

DeclareOperation( "UpdateContainerOfWeakPointers",
        [ IsContainerForWeakPointers ] );

DeclareOperation( "_AddElmWPObj_ForHomalg",
        [ IsContainerForWeakPointers, IsObject ] );

DeclareOperation( "_ElmWPObj_ForHomalg",
        [ IsContainerForWeakPointers, IsObject, IsObject ] );
