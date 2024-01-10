# SPDX-License-Identifier: GPL-2.0-or-later
# homalg: A homological algebra meta-package for computable Abelian categories
#
# Declarations
#

##  Declarations for some other functors.

####################################
#
# global variables:
#
####################################

DeclareGlobalName( "functor_Pushout" );

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

