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

## LinearStrand

DeclareOperation( "LinearStrand",
        [ IsInt, IsHomalgMorphism ] );

DeclareGlobalFunction( "_Functor_LinearStrand_OnFreeCocomplexes" );

DeclareGlobalFunction( "_Functor_LinearStrand_OnCochainMaps" );

DeclareGlobalVariable( "Functor_LinearStrand_ForGradedModules" );

## HomogeneousExteriorComplexToModule

DeclareOperation( "HomogeneousExteriorComplexToModule",
        [ IsHomalgComplex ] );

DeclareOperation( "SplitLinearMapAccordingToIndeterminates",
        [ IsHomalgGradedMap ] );

DeclareOperation( "ExtensionMapsFromExteriorComplex",
        [ IsHomalgGradedMap, IsHomalgGradedMap ] );

DeclareOperation( "CompareArgumentsForHomogeneousExteriorComplexToModuleOnObjects",
        [ IsList, IsList ] );

DeclareGlobalFunction( "_Functor_HomogeneousExteriorComplexToModule_OnGradedModules" );

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

DeclareGlobalFunction( "_Functor_HomogeneousExteriorComplexToModule_OnGradedMaps" );

DeclareGlobalVariable( "Functor_HomogeneousExteriorComplexToModule_ForGradedModules" );

## ModuleOfGlobalSections

DeclareAttribute( "IsModuleOfGlobalSections",
        IsHomalgGradedModule );

DeclareAttribute( "MapFromHomogenousPartOverExteriorAlgebraToHomogeneousPartOverSymmetricAlgebra",
        IsHomalgGradedModule );

DeclareAttribute( "MapFromHomogenousPartOverSymmetricAlgebraToHomogeneousPartOverExteriorAlgebra",
        IsHomalgGradedModule );

DeclareOperation( "ModulefromExtensionMap",
        [ IsHomalgGradedMap ] );

DeclareOperation( "ModuleOfGlobalSections",
        [ IsHomalgGradedMap ] );

DeclareOperation( "ModuleOfGlobalSections",
        [ IsHomalgGradedModule ] );

DeclareGlobalFunction( "_Functor_ModuleOfGlobalSections_OnGradedModules" );

DeclareGlobalFunction( "_Functor_ModuleOfGlobalSections_OnGradedMaps" );

DeclareGlobalVariable( "Functor_ModuleOfGlobalSections_ForGradedModules" );

DeclareSynonym( "StandardModule", ModuleOfGlobalSections );

DeclareAttribute( "NaturalMapToModuleOfGlobalSections",
        IsHomalgGradedModule );

DeclareAttribute( "NaturalMapFromExteriorComplexToRightAdjoint",
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

