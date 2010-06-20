#############################################################################
##
##  Objects.gd                  homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations of homalg procedures for homalg static objects.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "/",
        [ IsHomalgStaticObject, IsHomalgStaticObject ] );

DeclareOperation( "BoundForResolution",
        [ IsHomalgStaticObject ] );

DeclareOperation( "Resolution",
        [ IsInt, IsHomalgStaticObject ] );

DeclareOperation( "Resolution",
        [ IsHomalgStaticObject ] );

DeclareOperation( "LengthOfResolution",
        [ IsHomalgStaticObject ] );

DeclareOperation( "PresentationMap",
        [ IsHomalgStaticObject ] );

DeclareOperation( "SyzygiesObjectEmb",
        [ IsInt, IsHomalgStaticObject ] );

DeclareOperation( "SyzygiesObjectEmb",
        [ IsHomalgStaticObject ] );

DeclareOperation( "SyzygiesObject",
        [ IsInt, IsHomalgStaticObject ] );

DeclareOperation( "SyzygiesObject",
        [ IsHomalgStaticObject ] );

DeclareOperation( "SyzygiesObjectEpi",
        [ IsInt, IsHomalgStaticObject ] );

DeclareOperation( "SyzygiesObjectEpi",
        [ IsHomalgStaticObject ] );

DeclareOperation( "FreeHullModule",
        [ IsHomalgStaticObject ] );

DeclareOperation( "FreeHullEpi",
        [ IsHomalgStaticObject ] );

DeclareOperation( "SubResolution",
        [ IsInt, IsHomalgStaticObject ] );

DeclareOperation( "ShortenResolution",
        [ IsInt, IsHomalgComplex ] );

DeclareOperation( "ShortenResolution",
        [ IsHomalgComplex ] );

DeclareOperation( "ShortenResolution",
        [ IsInt, IsHomalgStaticObject ] );

DeclareOperation( "ShortenResolution",
        [ IsHomalgStaticObject ] );

DeclareOperation( "PushPresentationByIsomorphism",
        [ IsHomalgStaticMorphism ] );

DeclareOperation( "AsEpimorphicImage",
        [ IsHomalgStaticMorphism ] );

DeclareOperation( "Intersect2",
        [ IsHomalgStaticObject, IsHomalgStaticObject ] );

DeclareGlobalFunction( "Intersect" );

DeclareOperation( "IntersectWithMultiplicity",
        [ IsList, IsList ] );

DeclareOperation( "Annihilator",
        [ IsHomalgStaticObject ] );

DeclareOperation( "EmbeddingsInCoproductObject",
        [ IsHomalgStaticObject, IsList ] );

DeclareOperation( "ProjectionsFromProductObject",
        [ IsHomalgStaticObject, IsList ] );

DeclareOperation( "SubmoduleQuotient",
        [ IsHomalgStaticObject, IsHomalgStaticObject ] );

DeclareOperation( "-",
        [ IsHomalgStaticObject, IsHomalgStaticObject ] );

DeclareOperation( "Saturate",
        [ IsHomalgStaticObject, IsHomalgStaticObject ] );

DeclareOperation( "Saturate",
        [ IsHomalgStaticObject ] );

