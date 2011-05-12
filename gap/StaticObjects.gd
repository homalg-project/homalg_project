#############################################################################
##
##  Objects.gd                                                homalg package
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

DeclareOperation( "PresentationMorphism",
        [ IsHomalgStaticObject, IsInt ] );

DeclareOperation( "PresentationMorphism",
        [ IsHomalgStaticObject ] );

DeclareOperation( "BoundForResolution",
        [ IsHomalgStaticObject ] );

##  <#GAPDoc Label="CurrentResolution">
##  <ManSection>
##    <Attr Arg="M" Name="CurrentResolution"/>
##    <Returns>a &homalg; complex</Returns>
##    <Description>
##      The computed (part of a) resolution of the static object <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "CurrentResolution",
        [ IsHomalgStaticObject ] );

DeclareOperation( "CurrentResolution",
        [ IsInt, IsHomalgStaticObject ] );

DeclareOperation( "HasCurrentResolution",
        [ IsHomalgStaticObject ] );

DeclareOperation( "Resolution",
        [ IsInt, IsHomalgStaticObject ] );

DeclareOperation( "Resolution",
        [ IsHomalgStaticObject ] );

DeclareOperation( "FiniteFreeResolution",
        [ IsHomalgStaticObject ] );

DeclareOperation( "LengthOfResolution",
        [ IsHomalgStaticObject ] );

DeclareOperation( "FirstMorphismOfResolution",
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

DeclareOperation( "HullObjectInResolution",
        [ IsHomalgStaticObject ] );

DeclareOperation( "HullEpi",
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

DeclareOperation( "EmbeddingsInCoproductObject",
        [ IsHomalgStaticObject, IsList ] );

DeclareOperation( "ProjectionsFromProductObject",
        [ IsHomalgStaticObject, IsList ] );

DeclareOperation( "SubobjectQuotient",
        [ IsHomalgStaticObject, IsHomalgStaticObject ] );

DeclareOperation( "-",
        [ IsHomalgStaticObject, IsHomalgStaticObject ] );

DeclareOperation( "Saturate",
        [ IsHomalgStaticObject, IsHomalgStaticObject ] );

DeclareOperation( "Saturate",
        [ IsHomalgStaticObject ] );

DeclareOperation( "SetPropertiesIfKernelIsTorsionObject",
        [ IsHomalgStaticMorphism ] );

DeclareOperation( "SetAsOriginalPresentation",
        [ IsHomalgStaticObject ] );

DeclareOperation( "OnOriginalPresentation",
        [ IsHomalgStaticObject ] );

DeclareOperation( "SetAsPreferredPresentation",
        [ IsHomalgStaticObject ] );

DeclareOperation( "OnPreferredPresentation",
        [ IsHomalgStaticObject ] );

DeclareOperation( "OnLastStoredPresentation",
        [ IsHomalgStaticObject ] );

