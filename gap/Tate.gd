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

# basic operations:

DeclareOperation( "TateResolution",
        [ IsHomalgRing, IsInt, IsInt, IsHomalgRingOrModule ] );

DeclareOperation( "TateResolution",
        [ IsHomalgRingOrModule, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "TateResolution",
        [ IsHomalgRingOrModule, IsInt, IsInt ] );

DeclareOperation( "TateResolution",
        [ IsHomalgGradedMap, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "TateResolution",
        [ IsHomalgGradedMap, IsInt, IsInt ] );

