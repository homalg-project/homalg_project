# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Declarations
#

##  Declaration stuff for sets of generators.

####################################
#
# categories:
#
####################################

# A new GAP-category:

DeclareCategory( "IsSetsOfGenerators",
        IsComponentObjectRep );

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

# constructors:

DeclareGlobalFunction( "CreateSetsOfGeneratorsForLeftModule" );

DeclareGlobalFunction( "CreateSetsOfGeneratorsForRightModule" );

# basic operations:

DeclareOperation( "PositionOfLastStoredSetOfGenerators",
        [ IsSetsOfGenerators ] );

