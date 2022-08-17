# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Declarations
#

##  Declaration stuff for degrees of sets of generators.

####################################
#
# categories:
#
####################################

# A new GAP-category:

DeclareCategory( "IsSetOfDegreesOfGenerators",
        IsComponentObjectRep );

####################################
#
# function-operation-Attribute triples
#
####################################

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "CreateSetOfDegreesOfGenerators",
        [ IsList ] );

DeclareOperation( "CreateSetOfDegreesOfGenerators",
        [ IsList, IsInt ] );

# basic operations:

DeclareOperation( "AddDegreesOfGenerators",
        [ IsSetOfDegreesOfGenerators, IsInt, IsList ] );

DeclareOperation( "GetDegreesOfGenerators",
        [ IsSetOfDegreesOfGenerators, IsPosInt ] );

DeclareOperation( "ListOfPositionsOfKnownDegreesOfGenerators",
        [ IsSetOfDegreesOfGenerators ] );
