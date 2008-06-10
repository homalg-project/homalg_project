#############################################################################
##
## ToolFunctors.gd             homalg package               Mohamed Barakat
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

## AsComplex
DeclareGlobalFunction( "_Functor_AsComplex_OnObjects" );

DeclareGlobalVariable( "Functor_AsComplex" );

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

DeclareOperation( "AsComplex",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AsChainMapForPullback",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AsChainMapForPushout",
        [ IsHomalgMap, IsHomalgMap ] );

