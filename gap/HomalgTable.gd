#############################################################################
##
##  HomalgTable.gd             homalg package                Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for rings.
##
#############################################################################


####################################
#
# categories:
#
####################################

# a new category of objects:
DeclareCategory( "IsHomalgTable",
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

DeclareOperation( "CreateHomalgTable",
        [ IsSemiringWithOneAndZero ] );

# basic operations:

DeclareOperation( "CertainRows",
        [ IsMatrixForHomalg, IsList ] );

