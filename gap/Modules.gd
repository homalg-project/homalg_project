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
        [ IsHomalgModule, IsHomalgModule ] );

DeclareOperation( "/",
        [ IsHomalgRing, IsHomalgModule ] );

DeclareOperation( "BoundForResolution",
        [ IsHomalgRelations ] );

DeclareOperation( "Resolution",
        [ IsInt, IsHomalgRelations ] );

DeclareOperation( "Resolution",
        [ IsHomalgRelations ] );

DeclareOperation( "BoundForResolution",
        [ IsHomalgModule ] );

DeclareOperation( "Resolution",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "Resolution",
        [ IsHomalgModule ] );

DeclareOperation( "LengthOfResolution",
        [ IsHomalgModule ] );

DeclareOperation( "PresentationMap",
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

DeclareOperation( "ShortenResolution",
        [ IsInt, IsHomalgComplex ] );

DeclareOperation( "ShortenResolution",
        [ IsHomalgComplex ] );

DeclareOperation( "ShortenResolution",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "ShortenResolution",
        [ IsHomalgModule ] );

DeclareOperation( "FiniteFreeResolution",
        [ IsHomalgModule ] );

DeclareOperation( "AsEpimorphicImage",
        [ IsHomalgMap ] );

DeclareOperation( "Intersect2",
        [ IsHomalgRelations, IsHomalgRelations ] );

DeclareOperation( "Intersect2",
        [ IsHomalgModule, IsHomalgModule ] );

DeclareGlobalFunction( "Intersect" );

DeclareOperation( "IntersectWithMultiplicity",
        [ IsList, IsList ] );

DeclareOperation( "Annihilator",
        [ IsHomalgMatrix, IsHomalgRelations ] );

DeclareOperation( "Annihilator",
        [ IsHomalgModule ] );

DeclareOperation( "EmbeddingsInCoproductObject",
        [ IsHomalgModule, IsList ] );

DeclareOperation( "ProjectionsFromProductObject",
        [ IsHomalgModule, IsList ] );

DeclareOperation( "SubmoduleQuotient",
        [ IsHomalgModule, IsHomalgModule ] );

DeclareOperation( "-",
        [ IsHomalgModule, IsHomalgModule ] );

DeclareOperation( "Saturate",
        [ IsHomalgModule, IsHomalgModule ] );

DeclareOperation( "Saturate",
        [ IsHomalgModule ] );

