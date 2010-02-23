#############################################################################
##
##  ToolFunctors.gd             homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for some tool functors.
##
#############################################################################

####################################
#
# global variables:
#
####################################

## TheZeroMap
DeclareGlobalFunction( "_Functor_TheZeroMap_OnObjects" );

DeclareGlobalVariable( "functor_TheZeroMap" );

## AsATwoSequence
DeclareGlobalFunction( "_Functor_AsATwoSequence_OnObjects" );

DeclareGlobalVariable( "functor_AsATwoSequence" );

## MulMap
DeclareGlobalFunction( "_Functor_MulMap_OnObjects" );

DeclareGlobalVariable( "functor_MulMap" );

## AddMap
DeclareGlobalFunction( "_Functor_AddMap_OnObjects" );

DeclareGlobalVariable( "functor_AddMap" );

## SubMap
DeclareGlobalFunction( "_Functor_SubMap_OnObjects" );

DeclareGlobalVariable( "functor_SubMap" );

## Compose
DeclareGlobalFunction( "_Functor_Compose_OnObjects" );

DeclareGlobalVariable( "functor_Compose" );

## StackMaps
DeclareGlobalFunction( "_Functor_StackMaps_OnObjects" );

DeclareGlobalVariable( "functor_StackMaps" );

## AugmentMaps
DeclareGlobalFunction( "_Functor_AugmentMaps_OnObjects" );

DeclareGlobalVariable( "functor_AugmentMaps" );

## AsChainMapForPullback
DeclareGlobalFunction( "_Functor_AsChainMapForPullback_OnObjects" );

DeclareGlobalVariable( "functor_AsChainMapForPullback" );

## PostDivide
DeclareGlobalFunction( "_Functor_PostDivide_OnObjects" );

DeclareGlobalVariable( "functor_PostDivide" );

## PreDivide
DeclareGlobalFunction( "_Functor_PreDivide_OnObjects" );

DeclareGlobalVariable( "functor_PreDivide" );

## AsChainMapForPushout
DeclareGlobalFunction( "_Functor_AsChainMapForPushout_OnObjects" );

DeclareGlobalVariable( "functor_AsChainMapForPushout" );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "TheZeroMap",
        [ IsHomalgModule, IsHomalgModule ] );

DeclareOperation( "AsATwoSequence",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AsATwoSequence",
        [ IsHomalgComplex ] );

DeclareOperation( "MulMap",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AddMap",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "SubMap",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "Compose",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "StackMaps",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AugmentMaps",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AsChainMapForPullback",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "/",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "PostDivide",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "PreDivide",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AsChainMapForPushout",
        [ IsHomalgMap, IsHomalgMap ] );

