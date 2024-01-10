# SPDX-License-Identifier: GPL-2.0-or-later
# homalg: A homological algebra meta-package for computable Abelian categories
#
# Declarations
#

##  Declarations for some tool functors.

####################################
#
# global variables:
#
####################################


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

DeclareOperation( "SetPropertiesOfPostDivide",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "PreDivide",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AsChainMorphismForPushout",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

