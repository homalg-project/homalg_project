#############################################################################
##
##  ToolsForHomalg.gd                                 ToolsForHomalg package
##
##  Copyright 2007-2012, Mohamed Barakat, University of Kaiserslautern
##                       Sebastian Gutsche, RWTH-Aachen University
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations for ToolsForHomalg.
##
#############################################################################


# our info classes:
DeclareInfoClass( "InfoToolsForHomalg" );
SetInfoLevel( InfoToolsForHomalg, 1 );

DeclareInfoClass( "InfoHomalgBasicOperations" );
SetInfoLevel( InfoHomalgBasicOperations, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_TOOLS" );

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
## IsHomalgRingMap, etc.
DeclareCategory( "IsStructureObjectMorphism",
        IsAttributeStoringRep );

## this is the super GAP-category which will include the GAP-categories
## IsHomalgRing, IsHomalgModule:
DeclareCategory( "IsHomalgRingOrModule",
        IsStructureObjectOrObject );

# a new GAP-category:

DeclareCategory( "IsContainerForWeakPointers",
        IsComponentObjectRep );

DeclareCategory( "IsContainerForPointers",
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

DeclareGlobalFunction( "DeclareAttributeWithCustomGetter" );

DeclareGlobalFunction( "AppendToAhomalgTable" );

DeclareGlobalFunction( "homalgNamesOfComponentsToIntLists" );

DeclareGlobalFunction( "IncreaseExistingCounterInObject" );

DeclareGlobalFunction( "IncreaseExistingCounterInObjectWithTiming" );

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

DeclareGlobalFunction( "_AddElmWPObj_ForHomalg" );

DeclareGlobalFunction( "_AddTwoElmWPObj_ForHomalg" );

DeclareOperation( "_ElmWPObj_ForHomalg",
        [ IsContainerForWeakPointers, IsObject, IsObject ] );

DeclareOperation( "Display",
        [ IsContainerForWeakPointers, IsString ] );

# PointerObject Operations

DeclareGlobalFunction( "ContainerForPointers" );

DeclareOperation( "UpdateContainerOfPointers",
        [ IsContainerForPointers ] );

DeclareGlobalFunction( "_AddElmPObj_ForHomalg" );

DeclareGlobalFunction( "_AddTwoElmPObj_ForHomalg" );

DeclareOperation( "_ElmPObj_ForHomalg",
        [ IsContainerForPointers, IsObject, IsObject ] );

DeclareOperation( "Display",
        [ IsContainerForPointers, IsString ] );
