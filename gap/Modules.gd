#############################################################################
##
##  Modules.gd                  homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations of homalg procedures for modules.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "ParametrizeModule" );

# basic operations:

DeclareOperation( "/",
        [ IsHomalgGenerators, IsHomalgGenerators ] );

DeclareOperation( "/",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "/",
        [ IsHomalgRelations, IsHomalgModule ] );

DeclareOperation( "Resolution",
        [ IsHomalgRelations, IsInt ] );

DeclareOperation( "Resolution",
        [ IsHomalgRelations ] );

DeclareOperation( "Resolution",
        [ IsHomalgModule, IsInt ] );

DeclareOperation( "Resolution",
        [ IsHomalgModule ] );

DeclareOperation( "SyzygiesModuleEmb",
        [ IsHomalgModule, IsInt ] );

DeclareOperation( "SyzygiesModule",
        [ IsHomalgModule, IsInt ] );

DeclareOperation( "SyzygiesModuleEpi",
        [ IsHomalgModule, IsInt ] );

DeclareOperation( "FreeHullModule",
        [ IsHomalgModule ] );

DeclareOperation( "FreeHullEpi",
        [ IsHomalgModule ] );

