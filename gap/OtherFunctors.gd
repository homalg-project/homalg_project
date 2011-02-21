#############################################################################
##
##  OtherFunctors.gd            Graded Modules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declaration stuff for some other graded functors.
##
#############################################################################

####################################
#
# global variables:
#
####################################

## DirectSum
DeclareGlobalFunction( "_Functor_DirectSum_OnGradedModules" );

DeclareGlobalFunction( "_Functor_DirectSum_OnGradedMaps" );

DeclareGlobalVariable( "Functor_DirectSum_for_graded_modules" );

## LinearPart

DeclareOperation( "LinearPart",
        [ IsHomalgMorphism ] );

DeclareGlobalFunction( "_Functor_LinearPart_OnGradedModules" );

DeclareGlobalFunction( "_Functor_LinearPart_OnGradedMaps" );

DeclareGlobalVariable( "Functor_LinearPart_ForGradedModules" );

## LinearStrand

DeclareOperation( "LinearStrand",
        [ IsInt, IsHomalgMorphism ] );

DeclareGlobalFunction( "_Functor_LinearStrand_OnGradedModules" );

DeclareGlobalFunction( "_Functor_LinearStrand_OnGradedMaps" );

DeclareGlobalVariable( "Functor_LinearStrand_ForGradedModules" );

## MinimallyGeneratedHomogeneousSummand

DeclareOperation( "MinimallyGeneratedHomogeneousSummand",
        [ IsHomalgMorphism ] );

DeclareGlobalFunction( "_Functor_MinimallyGeneratedHomogeneousSummand_OnGradedModules" );

DeclareGlobalVariable( "Functor_MinimallyGeneratedHomogeneousSummand_ForGradedModules" );

## MinimallyGeneratedHomogeneousSummand2

DeclareOperation( "MinimallyGeneratedHomogeneousSummand2",
        [ IsHomalgMorphism ] );

DeclareGlobalFunction( "_Functor_MinimallyGeneratedHomogeneousSummand2_OnGradedModules" );

DeclareGlobalFunction( "_Functor_MinimallyGeneratedHomogeneousSummand2_OnGradedMaps" );

DeclareGlobalVariable( "Functor_MinimallyGeneratedHomogeneousSummand2_ForGradedModules" );

## HomogeneousExteriorComplexToModule

DeclareOperation( "HomogeneousExteriorComplexToModule",
        [ IsHomalgComplex ] );

DeclareOperation( "ExtensionMapsFromExteriorComplex",
        [ IsHomalgGradedMap, IsHomalgGradedMap ] );

DeclareGlobalFunction( "_Functor_HomogeneousExteriorComplexToModule_OnGradedModules" );

DeclareGlobalFunction( "_Functor_HomogeneousExteriorComplexToModule_OnGradedMaps" );

DeclareGlobalVariable( "Functor_HomogeneousExteriorComplexToModule_ForGradedModules" );

## StandardModule

DeclareOperation( "StandardModule",
        [ IsHomalgGradedMap ] );

DeclareOperation( "StandardModule",
        [ IsHomalgGradedModule ] );

DeclareGlobalFunction( "_Functor_StandardModule_OnGradedModules" );

DeclareGlobalFunction( "_Functor_StandardModule_OnGradedMaps" );

DeclareGlobalVariable( "Functor_StandardModule_ForGradedModules" );

## HomogeneousPartOverCoefficientsRing

DeclareOperation( "RepresentationOfMorphismOnHomogeneousParts",
        [ IsHomalgGradedMap, IsInt, IsInt ] );

DeclareOperation( "HomogeneousPartOverCoefficientsRing",
        [ IsInt, IsHomalgGradedMap ] );

DeclareOperation( "HomogeneousPartOverCoefficientsRing",
        [ IsInt, IsHomalgGradedModule ] );

DeclareGlobalFunction( "_Functor_HomogeneousPartOverCoefficientsRing_OnGradedModules" );

DeclareGlobalFunction( "_Functor_HomogeneousPartOverCoefficientsRing_OnGradedMaps" );

DeclareGlobalVariable( "Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules" );

## HomogeneousPartOfDegreeZeroOverCoefficientsRing

DeclareOperation( "HomogeneousPartOfDegreeZeroOverCoefficientsRing",
        [ IsHomalgGradedMap ] );

DeclareOperation( "HomogeneousPartOfDegreeZeroOverCoefficientsRing",
        [ IsHomalgGradedModule ] );

DeclareGlobalFunction( "_Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_OnGradedModules" );

DeclareGlobalFunction( "_Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_OnGradedMaps" );

DeclareGlobalVariable( "Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_ForGradedModules" );

####################################
#
# temporary
#
####################################

# DeclareGlobalFunction( "_UCT_Homology" );	## FIXME: generalize
# 
# DeclareGlobalFunction( "_UCT_Cohomology" );	## FIXME: generalize

