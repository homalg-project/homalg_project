# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Declarations
#

##  Declaration stuff for some other graded functors.

DeclareOperation( "GeneratorsOfHomogeneousPart",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "GeneratorsOfHomogeneousPart",
        [ IsHomalgElement, IsHomalgModule ] );

## RepresentationMapOfRingElement

DeclareOperation( "RepresentationMapOfRingElement",
        [ IsRingElement, IsHomalgModule, IsInt ] );

DeclareOperation( "RepresentationMapOfRingElement",
        [ IsRingElement, IsHomalgModule, IsHomalgElement ] );

## SubmoduleGeneratedByHomogeneousPart

DeclareOperation( "SubmoduleGeneratedByHomogeneousPart",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "SubmoduleGeneratedByHomogeneousPart",
        [ IsHomalgElement, IsHomalgModule ] );

DeclareOperation( "SubmoduleGeneratedByHomogeneousPartEmbed",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "SubmoduleGeneratedByHomogeneousPartEmbed",
        [ IsHomalgElement, IsHomalgModule ] );

DeclareAttribute( "EmbeddingOfTruncatedModuleInSuperModule",
        IsHomalgGradedModule );

## TruncatedSubmoduleEmbed

DeclareOperation( "TruncatedSubmoduleEmbed",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "TruncatedSubmoduleEmbed",
        [ IsHomalgElement, IsHomalgModule ] );

DeclareOperation( "TruncatedSubmodule",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "TruncatedSubmodule",
        [ IsHomalgElement, IsHomalgModule ] );

DeclareOperation( "TruncatedModule",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "TruncatedModule",
        [ IsHomalgElement, IsHomalgModule ] );

DeclareGlobalName( "Functor_TruncatedSubmodule_ForGradedModules" );

## TruncatedSubmoduleRecursiveEmbed

DeclareOperation( "TruncatedSubmoduleRecursiveEmbed",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "TruncatedSubmoduleRecursiveEmbed",
        [ IsHomalgElement, IsHomalgModule ] );

## HomogeneousPartOverCoefficientsRing

DeclareOperation( "RepresentationOfMorphismOnHomogeneousParts",
        [ IsHomalgGradedMap, IsObject, IsObject ] );

DeclareOperation( "EmbeddingOfSubmoduleGeneratedByHomogeneousPart",
        [ IsInt, IsHomalgGradedModule ] );

DeclareOperation( "EmbeddingOfSubmoduleGeneratedByHomogeneousPart",
        [ IsHomalgElement, IsHomalgGradedModule ] );

DeclareOperation( "HomogeneousPartOverCoefficientsRing",
        [ IsInt, IsHomalgGradedMap ] );

DeclareOperation( "HomogeneousPartOverCoefficientsRing",
        [ IsHomalgElement, IsHomalgGradedMap ] );

DeclareOperation( "HomogeneousPartOverCoefficientsRing",
        [ IsInt, IsHomalgGradedModule ] );

DeclareOperation( "HomogeneousPartOverCoefficientsRing",
        [ IsHomalgElement, IsHomalgGradedModule ] );

DeclareGlobalName( "Functor_HomogeneousPartOverCoefficientsRing_ForGradedModules" );

## HomogeneousPartOfDegreeZeroOverCoefficientsRing

DeclareOperation( "HomogeneousPartOfDegreeZeroOverCoefficientsRing",
        [ IsHomalgGradedMap ] );

DeclareOperation( "HomogeneousPartOfDegreeZeroOverCoefficientsRing",
        [ IsHomalgGradedModule ] );

DeclareGlobalName( "Functor_HomogeneousPartOfDegreeZeroOverCoefficientsRing_ForGradedModules" );
