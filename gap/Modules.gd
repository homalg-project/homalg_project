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
        [ IsInt, IsHomalgRelations ] );

DeclareOperation( "Resolution",
        [ IsHomalgRelations ] );

DeclareOperation( "Resolution",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "Resolution",
        [ IsHomalgModule ] );

DeclareOperation( "LengthOfResolution",
        [ IsHomalgModule ] );

DeclareOperation( "SyzygiesModuleEmb",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "SyzygiesModuleEmb",
        [ IsHomalgModule ] );

DeclareOperation( "SyzygiesModule",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "SyzygiesModule",
        [ IsHomalgModule ] );

DeclareOperation( "SyzygiesModuleEpi",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "SyzygiesModuleEpi",
        [ IsHomalgModule ] );

DeclareOperation( "FreeHullModule",
        [ IsHomalgModule ] );

DeclareOperation( "FreeHullEpi",
        [ IsHomalgModule ] );

DeclareOperation( "SubResolution",
        [ IsInt, IsHomalgModule ] );

