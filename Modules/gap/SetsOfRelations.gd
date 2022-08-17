# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Declarations
#

##  Declaration stuff for sets of relations.

####################################
#
# categories:
#
####################################

# A new GAP-category:

DeclareCategory( "IsSetsOfRelations",
        IsComponentObjectRep );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "CreateSetsOfRelationsForLeftModule" );

DeclareGlobalFunction( "CreateSetsOfRelationsForRightModule" );

# basic operations:

DeclareOperation( "PositionOfLastStoredSetOfRelations",
        [ IsSetsOfRelations ] );

