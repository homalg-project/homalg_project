#############################################################################
##
##  BasicFunctors.gd            Graded Modules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declaration stuff for basic functors of graded modules and maps.
##
#############################################################################

####################################
#
# global variables:
#
####################################

## Cokernel
DeclareGlobalFunction( "_Functor_Cokernel_OnGradedModules" );

DeclareGlobalVariable( "functor_Cokernel_ForGradedModules" );

## ImageObject
DeclareGlobalFunction( "_Functor_ImageObject_OnGradedModules" );

DeclareGlobalVariable( "functor_ImageObject_ForGradedModules" );

## GradedHom
DeclareGlobalFunction( "_Functor_GradedHom_OnGradedModules" );

DeclareGlobalFunction( "_Functor_GradedHom_OnGradedMaps" );

DeclareGlobalVariable( "Functor_GradedHom_ForGradedModules" );

## TensorProduct
DeclareGlobalFunction( "_Functor_TensorProduct_OnGradedModules" );

DeclareGlobalFunction( "_Functor_TensorProduct_OnGradedMaps" );

DeclareGlobalVariable( "Functor_TensorProduct_ForGradedModules" );

## BaseChange
DeclareGlobalFunction( "_functor_BaseChange_OnGradedModules" );

DeclareGlobalVariable( "functor_BaseChange_ForGradedModules" );

####################################
#
# global functions and operations:
#
####################################

# basic operations:
 
DeclareOperation( "BaseChange_OnGradedModules" ,
                 [ IsHomalgRing, IsHomalgMap ] );

DeclareOperation( "GradedHom",
        [ IsHomalgObject, IsHomalgObject ] );

DeclareOperation( "GradedExt",
        [ IsInt, IsHomalgObject, IsHomalgObject ] );
