# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Declarations
#

##  Declarations for homalg chain morphisms.

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "Add",
        [ IsHomalgChainMorphism, IsHomalgMatrix ] );
