# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Declarations
#

##  Declarations for homalg bicomplexes.

####################################
#
# global functions and operations:
#
####################################

# constructors:

#DeclareOperation( "*",
#        [ IsHomalgRing, IsHomalgBicomplex ] );

DeclareOperation( "*",
        [ IsHomalgBicomplex, IsHomalgRing ] );

# basic operations:

