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

## DefectOfHoms
DeclareGlobalFunction( "_Functor_DefectOfHoms_OnObjects" );

DeclareGlobalVariable( "Functor_DefectOfHoms" );

## Hom
DeclareGlobalFunction( "_Functor_Hom_OnObjects" );

DeclareGlobalFunction( "_Functor_Hom_OnMorphisms" );

DeclareGlobalVariable( "Functor_Hom" );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "CokernelEpi",
        IsHomalgMorphism );

DeclareAttribute( "KernelEmb",
        IsHomalgMorphism );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "Cokernel",
        [ IsHomalgMorphism ] );

## Kernel is already declared in the GAP library via DeclareOperation("Kernel",[IsObject]); (why so general?)

DeclareOperation( "DefectOfHoms",
        [ IsHomogeneousList ] );

DeclareOperation( "Hom",
        [ IsHomalgModule, IsHomalgModule ] );

