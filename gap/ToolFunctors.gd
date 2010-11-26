#############################################################################
##
##  ToolFunctors.gd             homalg package
##
##  Copyright 2007-2008 Mohamed Barakat, RWTH Aachen
##
##  Declarations for some tool functors.
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

## PreCompose
DeclareGlobalFunction( "_Functor_PreCompose_OnObjects" );

DeclareGlobalVariable( "functor_PreCompose" );

## AsChainMapForPullback
DeclareGlobalFunction( "_Functor_AsChainMapForPullback_OnObjects" );

DeclareGlobalVariable( "functor_AsChainMapForPullback" );

## AsChainMapForPushout
DeclareGlobalFunction( "_Functor_AsChainMapForPushout_OnObjects" );

DeclareGlobalVariable( "functor_AsChainMapForPushout" );

## PreDivide
DeclareGlobalFunction( "_Functor_PreDivide_OnMorphisms" );

DeclareGlobalVariable( "functor_PreDivide" );

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
        [ IsRingElement, IsHomalgMorphism ] );

DeclareOperation( "SetPropertiesOfMulMorphism",
        [ IsRingElement, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AddMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "SetPropertiesOfSumMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "SubMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "SetPropertiesOfDifferenceMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "PreComposeMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "PreCompose",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "SetPropertiesOfComposedMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "CoproductMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "SetPropertiesOfCoproductMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "ProductMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "SetPropertiesOfProductMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

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

