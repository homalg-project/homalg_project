#############################################################################
##
##  SetsOfRelations.gd          homalg package               Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for sets of relations.
##
#############################################################################


####################################
#
# categories:
#
####################################

# A new category of objects:

DeclareCategory( "IsSetsOfRelations",
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
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "CreateSetsOfRelations" );

# basic operations:

DeclareOperation( "NumberOfLastStoredSet",
        [ IsSetsOfRelations ] );

