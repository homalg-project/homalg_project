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

DeclareGlobalVariable( "Functor_AsATwoSequence" );

## AsChainMapForPullback
DeclareGlobalFunction( "_Functor_AsChainMapForPullback_OnObjects" );

DeclareGlobalVariable( "Functor_AsChainMapForPullback" );

## AsChainMapForPushout
DeclareGlobalFunction( "_Functor_AsChainMapForPushout_OnObjects" );

DeclareGlobalVariable( "Functor_AsChainMapForPushout" );

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

DeclareOperation( "AsChainMapForPullback",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AsChainMapForPushout",
        [ IsHomalgMap, IsHomalgMap ] );

