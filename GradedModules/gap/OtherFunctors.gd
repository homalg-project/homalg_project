# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Declarations
#

##  Declaration stuff for some other graded functors.

####################################
#
# global variables:
#
####################################

## LinearPart

DeclareOperation( "LinearPart",
        [ IsHomalgMorphism ] );

## ProjectionToDirectSummandOfGradedFreeModuleGeneratedByACertainDegree

DeclareOperation( "ProjectionToDirectSummandOfGradedFreeModuleGeneratedByACertainDegree",
        [ IsInt, IsHomalgGradedModule ] );

DeclareOperation( "ProjectionToDirectSummandOfGradedFreeModuleGeneratedByACertainDegree",
        [ IsHomalgElement, IsHomalgGradedModule ] );

## DirectSummandOfGradedFreeModuleGeneratedByACertainDegree

DeclareOperation( "DirectSummandOfGradedFreeModuleGeneratedByACertainDegree",
        [ IsInt, IsHomalgGradedModule ] );

DeclareOperation( "DirectSummandOfGradedFreeModuleGeneratedByACertainDegree",
        [ IsHomalgElement, IsHomalgGradedModule ] );

DeclareOperation( "DirectSummandOfGradedFreeModuleGeneratedByACertainDegree",
        [ IsObject, IsObject, IsHomalgGradedMap ] );

## GeneralizedLinearStrand

DeclareOperation( "GeneralizedLinearStrand",
        [ IsList, IsHomalgMorphism ] );

## LinearStrand

DeclareOperation( "LinearStrand",
        [ IsInt, IsHomalgMorphism ] );

DeclareOperation( "LinearStrand",
        [ IsHomalgElement, IsHomalgMorphism ] );

## ConstantStrand

DeclareOperation( "ConstantStrand",
        [ IsInt, IsHomalgMorphism ] );

DeclareOperation( "ConstantStrand",
        [ IsHomalgElement, IsHomalgMorphism ] );

## LinearFreeComplexOverExteriorAlgebraToModule

DeclareOperation( "LinearFreeComplexOverExteriorAlgebraToModule",
        [ IsHomalgComplex ] );

DeclareOperation( "SplitLinearMapAccordingToIndeterminates",
        [ IsHomalgGradedMap ] );

DeclareOperation( "ExtensionMapsFromExteriorComplex",
        [ IsHomalgGradedMap, IsHomalgGradedMap ] );

DeclareOperation( "CompareArgumentsForLinearFreeComplexOverExteriorAlgebraToModuleOnObjects",
        [ IsList, IsList ] );

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

DeclareOperation( "ModuleOfGlobalSectionsTruncatedAtCertainDegree",
        [ IsHomalgElement, IsHomalgGradedMap ] );

DeclareOperation( "ModuleOfGlobalSectionsTruncatedAtCertainDegree",
        [ IsHomalgElement, IsHomalgGradedModule ] );

DeclareAttribute( "NaturalMapFromExteriorComplexToRightAdjoint",
        IsHomalgComplex );

DeclareOperation( "NaturalMapToModuleOfGlobalSectionsTruncatedAtCertainDegree",
        [ IsInt, IsHomalgGradedModule ] );

DeclareOperation( "NaturalMapToModuleOfGlobalSectionsTruncatedAtCertainDegree",
        [ IsHomalgElement, IsHomalgGradedModule ] );

## ModuleOfGlobalSections

DeclareOperation( "ModuleOfGlobalSections",
        [ IsInt, IsHomalgGradedMap ] );

DeclareOperation( "ModuleOfGlobalSections",
        [ IsInt, IsHomalgGradedModule ] );

DeclareOperation( "ModuleOfGlobalSections",
        [ IsHomalgElement, IsHomalgGradedMap ] );

DeclareOperation( "ModuleOfGlobalSections",
        [ IsHomalgElement, IsHomalgGradedModule ] );

DeclareSynonym( "StandardModule", ModuleOfGlobalSections );

DeclareAttribute( "NaturalMapToModuleOfGlobalSections",
        IsHomalgGradedModule );

## GuessModuleOfGlobalSectionsFromATateMap

DeclareOperation( "GuessModuleOfGlobalSectionsFromATateMap",
        [ IsHomalgGradedMap ] );

DeclareOperation( "GuessModuleOfGlobalSectionsFromATateMap",
        [ IsInt, IsHomalgGradedMap ] );

DeclareOperation( "GuessModuleOfGlobalSectionsFromATateMap",
        [ IsHomalgElement, IsHomalgGradedMap ] );


####################################
#
# temporary
#
####################################

# DeclareGlobalFunction( "_UCT_Homology" ); ## FIXME: generalize
# 
# DeclareGlobalFunction( "_UCT_Cohomology" ); ## FIXME: generalize

