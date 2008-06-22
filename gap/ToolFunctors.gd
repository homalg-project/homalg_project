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

## AsSequence
DeclareGlobalFunction( "_Functor_AsSequence_OnObjects" );

DeclareGlobalVariable( "Functor_AsSequence" );

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

DeclareOperation( "AsSequence",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AsChainMapForPullback",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AsChainMapForPushout",
        [ IsHomalgMap, IsHomalgMap ] );

