#############################################################################
##
## OtherFunctors.gd             homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for some other functors.
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

## TorsionSubmodule
DeclareGlobalFunction( "_Functor_TorsionSubmodule_OnObjects" );

DeclareGlobalVariable( "Functor_TorsionSubmodule" );

## DirectSum
DeclareGlobalFunction( "_Functor_DirectSum_OnObjects" );

DeclareGlobalFunction( "_Functor_DirectSum_OnMorphisms" );

DeclareGlobalVariable( "Functor_DirectSum" );

## Pullback
DeclareGlobalFunction( "_Functor_Pullback_OnObjects" );

DeclareGlobalVariable( "functor_Pullback" );

## Pushout
DeclareGlobalFunction( "_Functor_Pushout_OnObjects" );

DeclareGlobalVariable( "functor_Pushout" );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "TorsionFreeFactorEpi",
        IsHomalgMap );

DeclareAttribute( "TorsionSubmoduleEmb",
        IsHomalgMap );

DeclareAttribute( "DirectSumEmbs",
        IsHomalgMap );

DeclareAttribute( "DirectSumEpis",
        IsHomalgMap );

DeclareAttribute( "PullbackPairOfMaps",
        IsHomalgMap );

DeclareAttribute( "PushoutPairOfMaps",
        IsHomalgMap );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "TorsionFreeFactor",
        [ IsHomalgModule ] );

DeclareOperation( "TorsionSubmodule",
        [ IsHomalgModule ] );

DeclareOperation( "DirectSum",
        [ IsHomalgModule, IsHomalgModule ] );

DeclareOperation( "Pullback",
        [ IsHomalgChainMap ] );

DeclareOperation( "Pullback",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "Pushout",
        [ IsHomalgChainMap ] );

DeclareOperation( "Pushout",
        [ IsHomalgMap, IsHomalgMap ] );

