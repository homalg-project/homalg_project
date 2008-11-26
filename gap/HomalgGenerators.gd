#############################################################################
##
##  HomalgGenerators.gd         homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for a set of generators.
##
#############################################################################

####################################
#
# categories:
#
####################################

# three new GAP-categories:

DeclareCategory( "IsHomalgGenerators",
        IsAttributeStoringRep );

## CAUTION: in the code the following two categories are the only ones for sets of generators,
##          i.e. IsHomalgGenerators and not IsHomalgGeneratorsOfLeftModule => IsHomalgGeneratorsOfRightModule

DeclareCategory( "IsHomalgGeneratorsOfLeftModule",
        IsHomalgGenerators );

DeclareCategory( "IsHomalgGeneratorsOfRightModule",
        IsHomalgGenerators );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsReduced",
        IsHomalgGenerators );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "ProcedureToNormalizeGenerators",
        IsHomalgGenerators );

DeclareAttribute( "ProcedureToReadjustGenerators",
        IsHomalgGenerators );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "HomalgGeneratorsForLeftModule" );
DeclareGlobalFunction( "HomalgGeneratorsForRightModule" );

# basic operations:

DeclareOperation( "MatrixOfGenerators",
        [ IsHomalgGenerators ] );

DeclareOperation( "HomalgRing",
        [ IsHomalgGenerators ] );

DeclareOperation( "RelationsOfHullModule",
        [ IsHomalgGenerators ] );

DeclareOperation( "HasNrRelations",
        [ IsHomalgGenerators ] );

DeclareOperation( "NrRelations",
        [ IsHomalgGenerators ] );

DeclareOperation( "MatrixOfRelations",
        [ IsHomalgGenerators ] );

DeclareOperation( "HasNrGenerators",
        [ IsHomalgGenerators ] );

DeclareOperation( "NrGenerators",
        [ IsHomalgGenerators ] );

DeclareOperation( "CertainGenerators",
        [ IsHomalgGenerators, IsList ] );

DeclareOperation( "CertainGenerator",
        [ IsHomalgGenerators, IsPosInt ] );

DeclareOperation( "NewHomalgGenerators",
        [ IsHomalgMatrix, IsHomalgGenerators ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgGenerators, IsHomalgRelations ] );

DeclareOperation( "BasisOfModule",
        [ IsHomalgGenerators ] );

DeclareOperation( "DecideZero",
        [ IsHomalgGenerators ] );

DeclareOperation( "DecideZero",
        [ IsHomalgGenerators, IsHomalgRelations ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgGenerators, IsHomalgRelations ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsHomalgGenerators, IsHomalgRelations ] );

DeclareOperation( "GetRidOfObsoleteGenerators",
        [ IsHomalgGenerators ] );

DeclareOperation( "*",
        [ IsHomalgMatrix, IsHomalgGenerators ] );

DeclareOperation( "*",
        [ IsHomalgGenerators, IsHomalgGenerators ] );

