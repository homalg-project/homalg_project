#############################################################################
##
##  OtherFunctors.gd            homalg package               Mohamed Barakat
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

## TorsionObject
DeclareGlobalFunction( "_Functor_TorsionObject_OnObjects" );

DeclareGlobalVariable( "Functor_TorsionObject" );

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

## AuslanderDual
DeclareGlobalFunction( "_Functor_AuslanderDual_OnObjects" );

DeclareGlobalVariable( "functor_AuslanderDual" );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "TorsionFreeFactorEpi",
        IsHomalgMap );

DeclareAttribute( "TorsionObjectEmb",
        IsHomalgMap );

DeclareAttribute( "MonoOfLeftSummand",
        IsHomalgMap );

DeclareAttribute( "MonoOfRightSummand",
        IsHomalgMap );

DeclareAttribute( "EpiOnLeftFactor",
        IsHomalgMap );

DeclareAttribute( "EpiOnRightFactor",
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
        [ IsHomalgObject ] );

DeclareOperation( "TorsionObject",
        [ IsHomalgObject ] );

DeclareOperation( "DirectSumOp",
        [ IsList, IsHomalgRingOrObjectOrMorphism ] );

DeclareOperation( "Pullback",
        [ IsHomalgChainMap ] );

DeclareOperation( "Pullback",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "Pushout",
        [ IsHomalgChainMap ] );

DeclareOperation( "Pushout",
        [ IsHomalgMap, IsHomalgMap ] );

DeclareOperation( "AuslanderDual",
        [ IsHomalgModule ] );

####################################
#
# temporary
#
####################################

DeclareGlobalFunction( "_UCT_Homology" );	## FIXME: generalize

DeclareGlobalFunction( "_UCT_Cohomology" );	## FIXME: generalize

