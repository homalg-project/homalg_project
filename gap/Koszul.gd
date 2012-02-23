#############################################################################
##
##  Koszul.gd                                          GradedModules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declarations for functors L and R
##
#############################################################################

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

DeclareGlobalFunction( "_Functor_RepresentationObjectOfKoszulId_OnGradedModules" );

DeclareGlobalFunction( "_Functor_RepresentationObjectOfKoszulId_OnGradedMaps" );

DeclareGlobalVariable( "Functor_RepresentationObjectOfKoszulId_ForGradedModules" );

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
        [ IsStructureObjectOrObject, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "KoszulAdjoint",
        [ IsStructureObjectOrObject, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulAdjoint",
        [ IsStructureObjectOrObject, IsInt, IsInt ] );

DeclareOperation( "KoszulAdjoint",
        [ IsStructureObjectOrObject, IsObject, IsObject ] );

DeclareOperation( "KoszulRightAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "KoszulRightAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulLeftAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "KoszulLeftAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsHomalgRing, IsInt, IsInt, IsHomalgComplex, IsHomalgComplex ] );

DeclareOperation( "KoszulAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject, IsHomalgComplex, IsHomalgComplex ] );

DeclareOperation( "KoszulAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsInt, IsInt ] );

DeclareOperation( "KoszulAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsObject, IsObject ] );

####################################
#
# functors:
#
####################################

DeclareGlobalFunction( "_Functor_KoszulRightAdjoint_OnGradedModules" );

DeclareGlobalFunction( "_Functor_KoszulRightAdjoint_OnGradedMaps" );

DeclareGlobalVariable( "Functor_KoszulRightAdjoint_ForGradedModules" );

DeclareOperation( "KoszulRightAdjoint",
        [ IsStructureObjectOrObject, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "KoszulRightAdjoint",
        [ IsStructureObjectOrObject, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulRightAdjoint",
        [ IsStructureObjectOrObject, IsInt, IsInt ] );

DeclareOperation( "KoszulRightAdjoint",
        [ IsStructureObjectOrObject, IsObject, IsObject ] );

DeclareOperation( "KoszulRightAdjoint",
        [ IsHomalgGradedMap, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "KoszulRightAdjoint",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulRightAdjoint",
        [ IsHomalgGradedMap, IsInt, IsInt ] );

DeclareOperation( "KoszulRightAdjoint",
        [ IsHomalgGradedMap, IsObject, IsObject ] );

DeclareGlobalFunction( "_Functor_KoszulLeftAdjoint_OnGradedModules" );

DeclareGlobalFunction( "_Functor_KoszulLeftAdjoint_OnGradedMaps" );

DeclareGlobalVariable( "Functor_KoszulLeftAdjoint_ForGradedModules" );

DeclareOperation( "KoszulLeftAdjoint",
        [ IsStructureObjectOrObject, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "KoszulLeftAdjoint",
        [ IsStructureObjectOrObject, IsInt, IsInt ] );

DeclareOperation( "KoszulLeftAdjoint",
        [ IsHomalgGradedMap, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "KoszulLeftAdjoint",
        [ IsHomalgGradedMap, IsInt, IsInt ] );

DeclareOperation( "KoszulLeftAdjoint",
        [ IsStructureObjectOrObject, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulLeftAdjoint",
        [ IsStructureObjectOrObject, IsObject, IsObject ] );

DeclareOperation( "KoszulLeftAdjoint",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "KoszulLeftAdjoint",
        [ IsHomalgGradedMap, IsObject, IsObject ] );