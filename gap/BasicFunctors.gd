#############################################################################
##
##  BasicFunctors.gd            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for basic functors.
##
#############################################################################

####################################
#
# global variables:
#
####################################

## Cokernel
DeclareGlobalFunction( "_Functor_Cokernel_OnObjects" );

DeclareGlobalVariable( "Functor_Cokernel" );

## Kernel
DeclareGlobalFunction( "_Functor_Kernel_OnObjects" );

DeclareGlobalVariable( "Functor_Kernel" );

## Hom
DeclareGlobalFunction( "_Functor_Hom_OnObjects" );

DeclareGlobalFunction( "_Functor_Hom_OnMorphisms" );

DeclareGlobalVariable( "Functor_Hom" );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "Cokernel",
        [ IsHomalgMorphism ] );

## Kernel is already declared in the GAP library via DeclareOperation("Kernel",[IsObject]); (why so general?)

DeclareOperation( "Hom",
        [ IsHomalgModule, IsHomalgModule ] );

DeclareOperation( "Hom",
        [ IsHomalgModule, IsHomalgRing ] );

DeclareOperation( "Hom",
        [ IsHomalgRing, IsHomalgModule ] );

DeclareOperation( "Hom",
        [ IsHomalgRing, IsHomalgRing ] );

DeclareOperation( "Hom",
        [ IsHomalgMorphism, IsHomalgModule ] );

DeclareOperation( "Hom",
        [ IsHomalgMorphism, IsHomalgRing ] );

DeclareOperation( "Hom",
        [ IsHomalgModule, IsHomalgMorphism ] );

DeclareOperation( "Hom",
        [ IsHomalgRing, IsHomalgMorphism ] );

