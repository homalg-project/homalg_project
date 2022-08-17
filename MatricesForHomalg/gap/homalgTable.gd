# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Declarations
#

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

