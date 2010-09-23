#############################################################################
##
##  SetOfDegreesOfGenerators.gd         Graded Modules package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declaration stuff for degrees of sets of generators.
##
#############################################################################

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
