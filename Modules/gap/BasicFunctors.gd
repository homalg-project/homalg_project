#############################################################################
##
##  BasicFunctors.gd            Modules package              Mohamed Barakat
##
##  Copyright 2007-2010 Mohamed Barakat, RWTH Aachen
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
DeclareGlobalFunction( "_Functor_Cokernel_OnModules" );

DeclareGlobalVariable( "functor_Cokernel_for_fp_modules" );

## ImageObject
DeclareGlobalFunction( "_Functor_ImageObject_OnModules" );

DeclareGlobalVariable( "functor_ImageObject_for_fp_modules" );

## Hom
DeclareGlobalFunction( "_Functor_Hom_OnModules" );

DeclareGlobalFunction( "_Functor_Hom_OnMaps" );

DeclareGlobalVariable( "Functor_Hom_for_fp_modules" );

## TensorProduct
DeclareGlobalFunction( "_Functor_TensorProduct_OnModules" );

DeclareGlobalFunction( "_Functor_TensorProduct_OnMaps" );

DeclareGlobalVariable( "Functor_TensorProduct_for_fp_modules" );

## BaseChange
DeclareGlobalFunction( "_functor_BaseChange_OnModules" );

DeclareGlobalVariable( "functor_BaseChange_for_fp_modules" );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

