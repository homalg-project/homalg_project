# SPDX-License-Identifier: GPL-2.0-or-later
# homalg: A homological algebra meta-package for computable Abelian categories
#
# Declarations
#

##         LIMOR = Logical Implications for homalg MORphisms

# our info class:
DeclareInfoClass( "InfoLIMOR" );
SetInfoLevel( InfoLIMOR, 1 );

# a central place for configurations:
DeclareGlobalVariable( "LIMOR" );

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "LogicalImplicationsForHomalgMorphisms" );

DeclareGlobalVariable( "LogicalImplicationsForHomalgEndomorphisms" );

####################################
#
# operations:
#
####################################

DeclareOperation( "SetPropertiesOfAdditiveInverse",
        [ IsHomalgMorphism, IsHomalgMorphism ] );
