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

## AsChainMorphismForPullback
DeclareGlobalFunction( "_Functor_AsChainMorphismForPullback_OnObjects" );

DeclareGlobalVariable( "functor_AsChainMorphismForPullback" );

## AsChainMorphismForPushout
DeclareGlobalFunction( "_Functor_AsChainMorphismForPushout_OnObjects" );

DeclareGlobalVariable( "functor_AsChainMorphismForPushout" );

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

DeclareOperation( "PreCompose",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "GeneralizedComposedMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "SetPropertiesOfComposedMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "CoproductMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "GeneralizedCoproductMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "SetPropertiesOfCoproductMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "ProductMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "GeneralizedProductMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "SetPropertiesOfProductMorphism",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AsChainMorphismForPullback",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "/",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "PostDivide",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "PreDivide",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AsChainMorphismForPushout",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

