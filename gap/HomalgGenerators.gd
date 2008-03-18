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

DeclareOperation( "BasisOfModule",
        [ IsHomalgGenerators ] );

DeclareOperation( "DecideZero",
        [ IsHomalgGenerators ] );

DeclareOperation( "DecideZero",
        [ IsHomalgGenerators, IsHomalgRelations ] );

