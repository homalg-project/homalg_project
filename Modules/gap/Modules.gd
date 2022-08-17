# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Declarations
#

##  Declarations of homalg procedures for modules.

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

DeclareOperation( "FittingIdeal",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "NumberOfFirstNonZeroFittingIdeal",
        [ IsHomalgModule ] );
        
DeclareOperation( "MapHavingCertainGeneratorsAsItsImage",
        [ IsHomalgModule, IsList ] );

DeclareOperation( "AMaximalIdealContaining",
        [ IsHomalgModule ] );

DeclareOperation( "IdealOfRationalPoints",
        [ IsHomalgModule, IsHomalgRing ] );
