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

DeclareGlobalVariable( "functor_Cokernel" );

## ImageObject
DeclareGlobalFunction( "_Functor_ImageObject_OnModules" );

DeclareGlobalVariable( "functor_ImageObject" );

## Hom
DeclareGlobalFunction( "_Functor_Hom_OnModules" );

DeclareGlobalFunction( "_Functor_Hom_OnMaps" );

DeclareGlobalVariable( "Functor_Hom" );

## TensorProduct
DeclareGlobalFunction( "_Functor_TensorProduct_OnModules" );

DeclareGlobalFunction( "_Functor_TensorProduct_OnMaps" );

DeclareGlobalVariable( "Functor_TensorProduct" );

## BaseChange
DeclareGlobalFunction( "_functor_BaseChange_OnModules" );

DeclareGlobalVariable( "functor_BaseChange" );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "BaseChange",
        [ IsHomalgRing, IsHomalgModule ] );

