#############################################################################
##
##  Tate.gd                     Graded Modules package
##
##  Copyright 2008-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declarations of procedures for the pair of adjoint Tate functors.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_Functor_TateResolution_OnGradedModules" );

DeclareGlobalFunction( "_Functor_TateResolution_OnGradedMaps" );

DeclareGlobalVariable( "Functor_TateResolution_ForGradedModules" );

DeclareGlobalFunction( "_Functor_LinearStrandOfTateResolution_OnGradedModules" );

DeclareGlobalFunction( "_Functor_LinearStrandOfTateResolution_OnGradedMaps" );

DeclareGlobalVariable( "Functor_LinearStrandOfTateResolution_ForGradedModules" );


# basic operations:


DeclareOperation( "MinimizeLowestDegreeMorphism",
        [ IsHomalgComplex ] );

DeclareOperation( "TateResolution",
        [ IsHomalgRing, IsInt, IsInt, IsHomalgRingOrModule ] );

DeclareOperation( "TateResolution",
        [ IsHomalgRing, IsObject, IsObject, IsHomalgRingOrModule ] );

DeclareOperation( "TateResolution",
        [ IsHomalgRingOrModule, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "TateResolution",
        [ IsHomalgRingOrModule, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "TateResolution",
        [ IsHomalgRingOrModule, IsInt, IsInt ] );

DeclareOperation( "TateResolution",
        [ IsHomalgRingOrModule, IsObject, IsObject ] );

DeclareOperation( "TateResolution",
        [ IsHomalgGradedMap, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "TateResolution",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "TateResolution",
        [ IsHomalgGradedMap, IsInt, IsInt ] );

DeclareOperation( "TateResolution",
        [ IsHomalgGradedMap, IsObject, IsObject ] );

DeclareOperation( "ResolveLinearly",
        [ IsInt, IsHomalgComplex, IsInt ] );

DeclareOperation( "ResolveLinearly",
        [ IsInt, IsHomalgComplex ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgRing, IsInt, IsInt, IsHomalgRingOrModule ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgRing, IsObject, IsObject, IsHomalgRingOrModule ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgRingOrModule, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgRingOrModule, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgRingOrModule, IsInt, IsInt ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgRingOrModule, IsObject, IsObject ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgGradedMap, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgGradedMap, IsInt, IsInt ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgGradedMap, IsObject, IsObject ] );
