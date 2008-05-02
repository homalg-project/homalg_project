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

# A new category of objects:

DeclareCategory( "IsHomalgGenerators",
        IsAttributeStoringRep );

## CAUTION: in the code we use the the following the following two categories
##          are the only ones for sets of generators!!!!

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

# constructor methods:

DeclareGlobalFunction( "HomalgGeneratorsForLeftModule" );
DeclareGlobalFunction( "HomalgGeneratorsForRightModule" );

# basic operations:

DeclareOperation( "MatrixOfGenerators",
        [ IsHomalgGenerators ] );

DeclareOperation( "HomalgRing",
        [ IsHomalgGenerators ] );

DeclareOperation( "RelationsOfHullModule",
        [ IsHomalgGenerators ] );

DeclareOperation( "MatrixOfRelations",
        [ IsHomalgGenerators ] );

DeclareOperation( "NrGenerators",
        [ IsHomalgGenerators ] );

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

DeclareOperation( "GetRidOfObsoleteGenerators",
        [ IsHomalgGenerators ] );

DeclareOperation( "*",
        [ IsHomalgMatrix, IsHomalgGenerators ] );

DeclareOperation( "*",
        [ IsHomalgGenerators, IsHomalgGenerators ] );
