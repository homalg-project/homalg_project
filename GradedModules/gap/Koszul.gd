# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Declarations
#

##  Declarations for functors L and R

####################################
#
# global functions and operations:
#
####################################

# basic operations

DeclareOperation( "RepresentationMatrixOfKoszulId",
        [ IsInt, IsHomalgModule, IsHomalgRing ] );

DeclareOperation( "RepresentationMatrixOfKoszulId",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "RepresentationMatrixOfKoszulId",
        [ IsHomalgElement, IsHomalgModule, IsHomalgRing ] );

DeclareOperation( "RepresentationMatrixOfKoszulId",
        [ IsHomalgElement, IsHomalgModule ] );

DeclareGlobalName( "Functor_RepresentationObjectOfKoszulId_ForGradedModules" );

DeclareOperation( "RepresentationObjectOfKoszulId",
        [ IsList, IsStructureObjectOrObject ] );

DeclareOperation( "RepresentationObjectOfKoszulId",
        [ IsHomalgElement, IsStructureObjectOrObject ] );

DeclareOperation( "MapFromHomogeneousPartofModuleToHomogeneousPartOfKoszulRightAdjoint",
        [ IsInt, IsHomalgGradedModule ] );

DeclareOperation( "MapFromHomogeneousPartofModuleToHomogeneousPartOfKoszulRightAdjoint",
        [ IsHomalgElement, IsHomalgGradedModule ] );

DeclareOperation( "RepresentationMapOfKoszulId",
        [ IsInt, IsHomalgModule, IsHomalgRing ] );

DeclareOperation( "RepresentationMapOfKoszulId",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "RepresentationMapOfKoszulId",
        [ IsHomalgElement, IsHomalgModule, IsHomalgRing ] );

DeclareOperation( "RepresentationMapOfKoszulId",
        [ IsHomalgElement, IsHomalgModule ] );

DeclareOperation( "KoszulAdjoint",
        [ IsStructureObjectOrObject, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulAdjoint",
        [ IsStructureObjectOrObject, IsObject, IsObject ] );

DeclareOperation( "KoszulRightAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulLeftAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject, IsHomalgComplex, IsHomalgComplex ] );

DeclareOperation( "KoszulAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsObject, IsObject ] );

####################################
#
# functors:
#
####################################

DeclareOperation( "KoszulRightAdjoint",
        [ IsStructureObjectOrObject, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulRightAdjoint",
        [ IsStructureObjectOrObject, IsObject, IsObject ] );

DeclareOperation( "KoszulRightAdjoint",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulRightAdjoint",
        [ IsHomalgGradedMap, IsObject, IsObject ] );

DeclareOperation( "KoszulLeftAdjoint",
        [ IsStructureObjectOrObject, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulLeftAdjoint",
        [ IsStructureObjectOrObject, IsObject, IsObject ] );

DeclareOperation( "KoszulLeftAdjoint",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulLeftAdjoint",
        [ IsHomalgGradedMap, IsObject, IsObject ] );
