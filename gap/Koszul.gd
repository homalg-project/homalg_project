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

DeclareGlobalFunction( "_Functor_RepresentationObjectOfKoszulId_OnGradedModules" );

DeclareGlobalFunction( "_Functor_RepresentationObjectOfKoszulId_OnGradedMaps" );

DeclareGlobalVariable( "Functor_RepresentationObjectOfKoszulId_ForGradedModules" );

DeclareOperation( "RepresentationObjectOfKoszulId",
        [ IsList, IsStructureObjectOrObject ] );

DeclareOperation( "RepresentationMapOfKoszulId",
        [ IsInt, IsHomalgModule, IsHomalgRing ] );

DeclareOperation( "RepresentationMapOfKoszulId",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "KoszulAdjoint",
        [ IsStructureObjectOrObject, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "KoszulAdjoint",
        [ IsStructureObjectOrObject, IsInt, IsInt ] );

DeclareOperation( "KoszulRightAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "KoszulLeftAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "KoszulAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsHomalgRing, IsInt, IsInt, IsHomalgComplex, IsHomalgComplex ] );

DeclareOperation( "KoszulAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsInt, IsInt ] );

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
        [ IsStructureObjectOrObject, IsInt, IsInt ] );

DeclareOperation( "KoszulRightAdjoint",
        [ IsHomalgGradedMap, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "KoszulRightAdjoint",
        [ IsHomalgGradedMap, IsInt, IsInt ] );

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