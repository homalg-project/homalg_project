#############################################################################
##
##  SetsOfRelations.gd         homalg package                Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for sets of relations.
##
#############################################################################


####################################
#
# Declarations for sets of matrices:
#
####################################

# A new category of objects:

DeclareCategory( "IsSetsOfRelations",
        IsAttributeStoringRep );

# Now the constructor method:

DeclareGlobalFunction( "CreateSetsOfRelations" );

# Basic operations:

DeclareOperation( "NumberOfLastStoredSet",
        [ IsSetsOfRelations ] );

###############################
# sets of relations properties:
###############################

###############################
# sets of relations attributes:
###############################

