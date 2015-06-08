#############################################################################
##
##  homalgTable.gd              MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for rings.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:
DeclareCategory( "IshomalgTable",
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

# constructors:

DeclareOperation( "CreateHomalgTable",
        [ IsObject ] );

# basic operations:

