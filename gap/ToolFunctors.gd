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

## AsATwoSequence
DeclareGlobalFunction( "_Functor_AsATwoSequence_OnObjects" );

DeclareGlobalVariable( "functor_AsATwoSequence" );

## MulMorphism
DeclareGlobalFunction( "_Functor_MulMorphism_OnObjects" );

DeclareGlobalVariable( "functor_MulMorphism" );

## AddMorphisms
DeclareGlobalFunction( "_Functor_AddMorphisms_OnObjects" );

DeclareGlobalVariable( "functor_AddMorphisms" );

## SubMorphisms
DeclareGlobalFunction( "_Functor_SubMorphisms_OnObjects" );

DeclareGlobalVariable( "functor_SubMorphisms" );

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

DeclareOperation( "TheZeroMorphism",
        [ IsHomalgObject, IsHomalgObject ] );

DeclareOperation( "AsATwoSequence",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AsATwoSequence",
        [ IsHomalgComplex ] );

DeclareOperation( "MulMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AddMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "SubMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "Compose",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "StackMaps",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AugmentMaps",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AsChainMapForPullback",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "/",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "PostDivide",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "PreDivide",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AsChainMapForPushout",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

