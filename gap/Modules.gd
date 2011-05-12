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

# basic operations:

DeclareOperation( "/",
        [ IsHomalgGenerators, IsHomalgGenerators ] );

DeclareOperation( "/",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "/",
        [ IsHomalgRelations, IsHomalgModule ] );

DeclareOperation( "/",
        [ IsHomalgRing, IsHomalgModule ] );

DeclareOperation( "AnyParametrization",
        [ IsHomalgRelations ] );

DeclareOperation( "AnyParametrization",
        [ IsHomalgModule ] );

DeclareOperation( "MinimalParametrization",
        [ IsHomalgModule ] );

DeclareOperation( "SeveralMinimalParametrizations",
        [ IsHomalgModule ] );

DeclareOperation( "Parametrization",
        [ IsHomalgModule ] );

DeclareOperation( "Intersect2",
        [ IsHomalgRelations, IsHomalgRelations ] );

DeclareOperation( "Annihilator",
        [ IsHomalgMatrix, IsHomalgRelations ] );

DeclareOperation( "AnnihilatorsOfGenerators",
        [ IsHomalgModule ] );
