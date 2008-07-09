#############################################################################
##
## ToolFunctors.gd              homalg package               Mohamed Barakat
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

## Compose
DeclareGlobalFunction( "_Functor_Compose_OnObjects" );

DeclareGlobalVariable( "functor_Compose" );

## AsChainMapForPullback
DeclareGlobalFunction( "_Functor_AsChainMapForPullback_OnObjects" );

DeclareGlobalVariable( "functor_AsChainMapForPullback" );

## PostDivide
DeclareGlobalFunction( "_Functor_PostDivide_OnObjects" );

DeclareGlobalVariable( "functor_PostDivide" );

## AsChainMapForPushout
DeclareGlobalFunction( "_Functor_AsChainMapForPushout_OnObjects" );

DeclareGlobalVariable( "functor_AsChainMapForPushout" );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "AsATwoSequence",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AsATwoSequence",
        [ IsHomalgComplex ] );

DeclareOperation( "Compose",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AsChainMapForPullback",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "/",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "PostDivide",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AsChainMapForPushout",
        [ IsHomalgMap, IsHomalgMap ] );

