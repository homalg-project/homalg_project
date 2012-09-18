#############################################################################
##
##  OtherFunctors.gd            homalg package
##
##  Copyright 2007-2008 Mohamed Barakat, RWTH Aachen
##
##  Declarations for some other functors.
##
#############################################################################

####################################
#
# global variables:
#
####################################

## TorsionFreeFactor
DeclareGlobalFunction( "_Functor_TorsionFreeFactor_OnObjects" );

DeclareGlobalVariable( "Functor_TorsionFreeFactor" );

## TorsionObject
DeclareGlobalFunction( "_Functor_TorsionObject_OnObjects" );

DeclareGlobalVariable( "Functor_TorsionObject" );

## Pullback
DeclareGlobalFunction( "_Functor_Pullback_OnObjects" );

DeclareGlobalVariable( "functor_Pullback" );

## Pushout
DeclareGlobalFunction( "_Functor_Pushout_OnObjects" );

DeclareGlobalVariable( "functor_Pushout" );

## AuslanderDual
DeclareGlobalFunction( "_Functor_AuslanderDual_OnObjects" );

DeclareGlobalVariable( "functor_AuslanderDual" );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "TorsionFreeFactorEpi",
        IsHomalgStaticObject );

DeclareAttribute( "TorsionObjectEmb",
        IsHomalgStaticObject );

DeclareAttribute( "MonoOfLeftSummand",
        IsHomalgStaticObject );

DeclareAttribute( "MonoOfRightSummand",
        IsHomalgStaticObject );

DeclareAttribute( "EpiOnLeftFactor",
        IsHomalgStaticObject );

DeclareAttribute( "EpiOnRightFactor",
        IsHomalgStaticObject );

DeclareAttribute( "PullbackPairOfMorphisms",
        IsHomalgStaticObject );

DeclareAttribute( "PushoutPairOfMorphisms",
        IsHomalgStaticObject );

DeclareAttribute( "EpiOfPushout",
        IsHomalgStaticObject );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "TorsionFreeFactor",
        [ IsHomalgObject ] );

DeclareOperation( "TorsionObject",
        [ IsHomalgObject ] );

DeclareOperation( "DirectSumOp",
        [ IsList, IsStructureObjectOrObjectOrMorphism ] );

DeclareOperation( "SetPropertiesOfDirectSum",
        [ IsList, IsHomalgObject,
          IsHomalgMorphism, IsHomalgMorphism,
          IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "Pullback",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "Pullback",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "Pushout",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "Pushout",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "Pushout",
        [ IsHomalgMorphism, IsHomalgMorphism,
          IsHomalgMorphism, IsHomalgMorphism,
          IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "LeftPushoutMorphism",
        [ IsHomalgObject ] );

DeclareOperation( "RightPushoutMorphism",
        [ IsHomalgObject ] );

DeclareOperation( "AuslanderDual",
        [ IsHomalgObject ] );

