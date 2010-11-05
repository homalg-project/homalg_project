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

DeclareOperation( "KoszulRightAdjoint",
        [ IsStructureObjectOrObject, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "KoszulRightAdjoint",
        [ IsStructureObjectOrObject, IsInt, IsInt ] );