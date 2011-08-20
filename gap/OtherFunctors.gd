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

DeclareGlobalVariable( "Functor_DirectSum_for_graded_modules" );

## LinearPart

DeclareOperation( "LinearPart",
        [ IsHomalgMorphism ] );

DeclareGlobalFunction( "_Functor_LinearPart_OnGradedModules" );

DeclareGlobalFunction( "_Functor_LinearPart_OnGradedMaps" );

DeclareGlobalVariable( "Functor_LinearPart_ForGradedModules" );

## ProjectionToDirectSummandOfGradedFreeModuleGeneratedByACertainDegree

DeclareOperation( "ProjectionToDirectSummandOfGradedFreeModuleGeneratedByACertainDegree",
        [ IsInt, IsHomalgGradedModule ] );

DeclareGlobalFunction( "_Functor_ProjectionToDirectSummandOfGradedFreeModuleGeneratedByACertainDegree_OnGradedModules" );

DeclareGlobalVariable( "Functor_ProjectionToDirectSummandOfGradedFreeModuleGeneratedByACertainDegree_ForGradedModules" );

## DirectSummandOfGradedFreeModuleGeneratedByACertainDegree

DeclareOperation( "DirectSummandOfGradedFreeModuleGeneratedByACertainDegree",
        [ IsInt, IsHomalgGradedModule ] );

DeclareOperation( "DirectSummandOfGradedFreeModuleGeneratedByACertainDegree",
        [ IsInt, IsInt, IsHomalgGradedMap ] );

## GeneralizedLinearStrand

DeclareOperation( "GeneralizedLinearStrand",
        [ IsList, IsHomalgMorphism ] );

DeclareGlobalFunction( "_Functor_GeneralizedLinearStrand_OnFreeCocomplexes" );

DeclareGlobalFunction( "_Functor_GeneralizedLinearStrand_OnCochainMaps" );

DeclareGlobalVariable( "Functor_GeneralizedLinearStrand_ForGradedModules" );

## LinearStrand

DeclareOperation( "LinearStrand",
        [ IsInt, IsHomalgMorphism ] );

DeclareGlobalFunction( "_Functor_LinearStrand_OnFreeCocomplexes" );

DeclareGlobalFunction( "_Functor_LinearStrand_OnCochainMaps" );

DeclareGlobalVariable( "Functor_LinearStrand_ForGradedModules" );

## ConstantStrand

DeclareOperation( "ConstantStrand",
        [ IsInt, IsHomalgMorphism ] );

DeclareGlobalFunction( "_Functor_ConstantStrand_OnFreeCocomplexes" );

DeclareGlobalFunction( "_Functor_ConstantStrand_OnCochainMaps" );

DeclareGlobalVariable( "Functor_ConstantStrand_ForGradedModules" );

## LinearFreeComplexOverExteriorAlgebraToModule

DeclareOperation( "LinearFreeComplexOverExteriorAlgebraToModule",
        [ IsHomalgComplex ] );

DeclareOperation( "SplitLinearMapAccordingToIndeterminates",
        [ IsHomalgGradedMap ] );

DeclareOperation( "ExtensionMapsFromExteriorComplex",
        [ IsHomalgGradedMap, IsHomalgGradedMap ] );

DeclareOperation( "CompareArgumentsForLinearFreeComplexOverExteriorAlgebraToModuleOnObjects",
        [ IsList, IsList ] );

DeclareGlobalFunction( "_Functor_LinearFreeComplexOverExteriorAlgebraToModule_OnGradedModules" );

DeclareOperation( "ConstructMorphismFromLayers",
        [ IsHomalgGradedModule, IsHomalgGradedModule, IsHomalgChainMorphism ] );

DeclareOperation( "HomogeneousPartOfCohomologicalDegreeOverCoefficientsRing",
        [ IsHomalgComplex, IsInt, IsInt ] );

DeclareOperation( "HomogeneousPartOfCohomologicalDegreeOverCoefficientsRing",
        [ IsHomalgChainMorphism, IsInt, IsInt ] );

DeclareOperation( "CompleteKernelSquareByDualization",
        [ IsHomalgGradedMap, IsHomalgGradedMap, IsHomalgGradedMap ] );

DeclareOperation( "SetNaturalMapFromExteriorComplexToRightAdjointForModulesOfGlobalSections",
        [ IsHomalgComplex, IsHomalgGradedModule ] );

DeclareGlobalFunction( "_Functor_LinearFreeComplexOverExteriorAlgebraToModule_OnGradedMaps" );

DeclareGlobalVariable( "Functor_LinearFreeComplexOverExteriorAlgebraToModule_ForGradedModules" );

#backwards compatibility
DeclareSynonym( "HomogeneousExteriorComplexToModule", LinearFreeComplexOverExteriorAlgebraToModule );

## ModuleOfGlobalSectionsTruncatedAtCertainDegree

DeclareAttribute( "EmbeddingOfSubmoduleGeneratedByHomogeneousPart",
        IsHomalgGradedModule );

DeclareAttribute( "IsModuleOfGlobalSectionsTruncatedAtCertainDegree",
        IsHomalgGradedModule, "mutable" ); #mutability, if we find a better bound by accident

DeclareAttribute( "MapFromHomogenousPartOverExteriorAlgebraToHomogeneousPartOverSymmetricAlgebra",
        IsHomalgGradedModule );

DeclareAttribute( "MapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra",
        IsHomalgGradedModule );

DeclareOperation( "ModuleFromExtensionMap",
        [ IsHomalgGradedMap ] );

DeclareOperation( "ModuleOfGlobalSectionsTruncatedAtCertainDegree",
        [ IsInt, IsHomalgGradedMap ] );

DeclareOperation( "ModuleOfGlobalSectionsTruncatedAtCertainDegree",
        [ IsInt, IsHomalgGradedModule ] );

DeclareGlobalFunction( "_Functor_ModuleOfGlobalSectionsTruncatedAtCertainDegree_OnGradedModules" );

DeclareGlobalFunction( "_Functor_ModuleOfGlobalSectionsTruncatedAtCertainDegree_OnGradedMaps" );

DeclareGlobalVariable( "Functor_ModuleOfGlobalSectionsTruncatedAtCertainDegree_ForGradedModules" );

DeclareAttribute( "NaturalMapFromExteriorComplexToRightAdjoint",
        IsHomalgComplex );

DeclareOperation( "NaturalMapToModuleOfGlobalSectionsTruncatedAtCertainDegree",
        [ IsInt, IsHomalgGradedModule ] );

## ModuleOfGlobalSections

DeclareGlobalFunction( "_Functor_ModuleOfGlobalSections_OnGradedModules" );

DeclareGlobalFunction( "_Functor_ModuleOfGlobalSections_OnGradedMaps" );

DeclareGlobalVariable( "Functor_ModuleOfGlobalSections_ForGradedModules" );

DeclareOperation( "ModuleOfGlobalSections",
        [ IsInt, IsHomalgGradedMap ] );

DeclareOperation( "ModuleOfGlobalSections",
        [ IsInt, IsHomalgGradedModule ] );

DeclareSynonym( "StandardModule", ModuleOfGlobalSections );

DeclareAttribute( "NaturalMapToModuleOfGlobalSections",
        IsHomalgGradedModule );

## GuessModuleOfGlobalSectionsFromATateMap

DeclareOperation( "GuessModuleOfGlobalSectionsFromATateMap",
        [ IsHomalgGradedMap ] );

DeclareOperation( "GuessModuleOfGlobalSectionsFromATateMap",
        [ IsInt, IsHomalgGradedMap ] );

DeclareGlobalFunction( "_Functor_GuessModuleOfGlobalSectionsFromATateMap_OnGradedMaps" );

DeclareGlobalVariable( "Functor_GuessModuleOfGlobalSectionsFromATateMap_ForGradedMaps" );


####################################
#
# temporary
#
####################################

# DeclareGlobalFunction( "_UCT_Homology" );	## FIXME: generalize
# 
# DeclareGlobalFunction( "_UCT_Cohomology" );	## FIXME: generalize

