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

DeclareOperation( "RepresentationMapOfKoszulId",
        [ IsInt, IsHomalgModule, IsHomalgRing ] );

DeclareOperation( "RepresentationMapOfKoszulId",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "KoszulAdjoint",
        [ IsStructureObjectOrObject, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "KoszulAdjoint",
        [ IsStructureObjectOrObject, IsInt, IsInt ] );

DeclareSynonym( "KoszulLeftAdjoint", KoszulAdjoint );

DeclareOperation( "KoszulAdjointOnMorphisms",
        [ IsHomalgGradedMap, IsHomalgRing, IsInt, IsInt ] );

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