#############################################################################
##
##  GradedStructureFunctors.gd            Graded Modules package
##
##  Copyright 2007-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declaration stuff for some other graded functors.
##
#############################################################################

DeclareOperation( "BasisOfHomogeneousPart",
        [ IsInt, IsHomalgModule ] );

## RepresentationMapOfRingElement

DeclareOperation( "RepresentationMapOfRingElement",
        [ IsRingElement, IsHomalgModule, IsInt ] );

DeclareGlobalFunction( "_Functor_RepresentationMapOfRingElement_OnGradedModules" );

DeclareGlobalFunction( "_Functor_RepresentationMapOfRingElement_OnGradedMaps" );

DeclareGlobalVariable( "Functor_RepresentationMapOfRingElement_ForGradedModules" );

## SubmoduleGeneratedByHomogeneousPart

DeclareOperation( "SubmoduleGeneratedByHomogeneousPart",
        [ IsInt, IsHomalgModule ] );

DeclareGlobalFunction( "_Functor_SubmoduleGeneratedByHomogeneousPart_OnGradedModules" );

DeclareGlobalFunction( "_Functor_SubmoduleGeneratedByHomogeneousPart_OnGradedMaps" );

DeclareGlobalVariable( "Functor_SubmoduleGeneratedByHomogeneousPart_ForGradedModules" );

DeclareOperation( "SubmoduleGeneratedByHomogeneousPartEmbed",
        [ IsInt, IsHomalgModule ] );

## TruncatedSubmoduleEmbed

DeclareOperation( "TruncatedSubmoduleEmbed",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "TruncatedSubmodule",
        [ IsInt, IsHomalgModule ] );

# DeclareGlobalFunction( "_Functor_TruncatedSubmoduleEmbed_OnGradedModules" );
# 
# DeclareGlobalFunction( "_Functor_TruncatedSubmoduleEmbed_OnGradedMaps" );
# 
# DeclareGlobalVariable( "Functor_TruncatedSubmoduleEmbed_ForGradedModules" );

DeclareGlobalFunction( "_Functor_TruncatedSubmodule_OnGradedModules" );

DeclareGlobalFunction( "_Functor_TruncatedSubmodule_OnGradedMaps" );

DeclareGlobalVariable( "Functor_TruncatedSubmodule_ForGradedModules" );

## TruncatedSubmoduleRecursiveEmbed

DeclareOperation( "TruncatedSubmoduleRecursiveEmbed",
        [ IsInt, IsHomalgModule ] );

DeclareGlobalFunction( "_Functor_TruncatedSubmoduleRecursiveEmbed_OnGradedModules" );

DeclareGlobalFunction( "_Functor_TruncatedSubmoduleRecursiveEmbed_OnGradedMaps" );

DeclareGlobalVariable( "Functor_TruncatedSubmoduleRecursiveEmbed_ForGradedModules" );

## HomogeneousPartOverCoefficientsRing

DeclareOperation( "RepresentationOfMorphismOnHomogeneousParts",
        [ IsHomalgGradedMap, IsInt, IsInt ] );

DeclareAttribute( "EmbeddingOfSubmoduleGeneratedByHomogeneousPart",
        IsHomalgGradedModule );


DeclareOperation( "EmbeddingOfSubmoduleGeneratedByHomogeneousPart",
        [ IsInt, IsHomalgGradedModule ] );

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