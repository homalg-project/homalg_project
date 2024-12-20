# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Declarations
#

##  Declarations of procedures for the pair of adjoint Tate functors.

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_Functor_TateResolution_OnGradedModules" );

DeclareGlobalFunction( "_Functor_TateResolution_OnGradedMaps" );

DeclareGlobalFunction( "_Functor_LinearStrandOfTateResolution_OnGradedModules" );

DeclareGlobalFunction( "_Functor_LinearStrandOfTateResolution_OnGradedMaps" );


# basic operations:


DeclareOperation( "MinimizeLowestDegreeMorphism",
        [ IsHomalgComplex ] );

DeclareOperation( "TateResolution",
        [ IsHomalgRing, IsObject, IsObject, IsHomalgRingOrModule ] );

DeclareOperation( "TateResolution",
        [ IsHomalgRingOrModule, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "TateResolution",
        [ IsHomalgRingOrModule, IsObject, IsObject ] );

DeclareOperation( "TateResolution",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "TateResolution",
        [ IsHomalgGradedMap, IsObject, IsObject ] );

DeclareOperation( "ResolveLinearly",
        [ IsInt, IsHomalgComplex, IsInt ] );

DeclareOperation( "ResolveLinearly",
        [ IsInt, IsHomalgComplex ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgRing, IsObject, IsObject, IsHomalgRingOrModule ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgRingOrModule, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgRingOrModule, IsObject, IsObject ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgGradedMap, IsHomalgRing, IsObject, IsObject ] );

DeclareOperation( "LinearStrandOfTateResolution",
        [ IsHomalgGradedMap, IsObject, IsObject ] );
