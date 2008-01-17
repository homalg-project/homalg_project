#############################################################################
##
##  SetsOfGenerators.gd         homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for sets of generators.
##
#############################################################################


####################################
#
# categories:
#
####################################

# A new category of objects:

DeclareCategory( "IsSetsOfGenerators",
        IsAttributeStoringRep );

####################################
#
# properties:
#
####################################

####################################
#
# attributes:
#
####################################

####################################
#
# function-operation-Attribute triples
#
####################################

KeyDependentOperation( "TransitionMap", IsSetsOfGenerators, IsList, ReturnTrue );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "CreateSetsOfGeneratorsForLeftModule" );

DeclareGlobalFunction( "CreateSetsOfGeneratorsForRightModule" );

# basic operations:

DeclareOperation( "PositionOfLastStoredSet",
        [ IsSetsOfGenerators ] );

