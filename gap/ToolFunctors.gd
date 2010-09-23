#############################################################################
##
##  ToolFunctors.gd             Graded Modules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declaration stuff for some graded tool functors.
##
#############################################################################

####################################
#
# global variables:
#
####################################

## TheZeroMorphism
DeclareGlobalFunction( "_Functor_TheZeroMorphism_OnGradedModules" );

DeclareGlobalVariable( "functor_TheZeroMorphism_for_graded_modules" );

## MulMorphism
DeclareGlobalFunction( "_Functor_MulMorphism_OnGradedMaps" );

DeclareGlobalVariable( "functor_MulMorphism_for_maps_of_graded_modules" );

## AddMorphisms
DeclareGlobalFunction( "_Functor_AddMorphisms_OnGradedMaps" );

DeclareGlobalVariable( "functor_AddMorphisms_for_maps_of_graded_modules" );

## SubMorphisms
DeclareGlobalFunction( "_Functor_SubMorphisms_OnGradedMaps" );

DeclareGlobalVariable( "functor_SubMorphisms_for_maps_of_graded_modules" );

## Compose
DeclareGlobalFunction( "_Functor_PreCompose_OnGradedMaps" );

DeclareGlobalVariable( "functor_PreCompose_for_maps_of_graded_modules" );

## CoproductMorphism
DeclareGlobalFunction( "_Functor_CoproductMorphism_OnGradedMaps" );

DeclareGlobalVariable( "functor_CoproductMorphism_for_maps_of_graded_modules" );

## ProductMorphism
DeclareGlobalFunction( "_Functor_ProductMorphism_OnGradedMaps" );

DeclareGlobalVariable( "functor_ProductMorphism_for_maps_of_graded_modules" );

## PostDivide
DeclareGlobalFunction( "_Functor_PostDivide_OnGradedMaps" );

DeclareGlobalVariable( "functor_PostDivide_for_maps_of_graded_modules" );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

