#############################################################################
##
##  Modules.gd                  Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations of homalg procedures for modules.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "ReducedBasisOfModule" );

DeclareGlobalFunction( "ParametrizeModule" );

# basic operations:

DeclareOperation( "/",
        [ IsHomalgGenerators, IsHomalgGenerators ] );

DeclareOperation( "/",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "/",
        [ IsHomalgRelations, IsHomalgModule ] );

DeclareOperation( "/",
        [ IsHomalgRing, IsHomalgModule ] );

DeclareOperation( "BoundForResolution",
        [ IsHomalgRelations ] );

DeclareOperation( "Resolution",
        [ IsInt, IsHomalgRelations ] );

DeclareOperation( "Resolution",
        [ IsHomalgRelations ] );

DeclareOperation( "FiniteFreeResolution",
        [ IsHomalgModule ] );

DeclareOperation( "Intersect2",
        [ IsHomalgRelations, IsHomalgRelations ] );

DeclareOperation( "Annihilator",
        [ IsHomalgMatrix, IsHomalgRelations ] );

