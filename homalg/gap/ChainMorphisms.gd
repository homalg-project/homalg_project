# SPDX-License-Identifier: GPL-2.0-or-later
# homalg: A homological algebra meta-package for computable Abelian categories
#
# Declarations
#

##  Declarations of homalg procedures for chain morphisms.

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "DefectOfExactness",
        [ IsHomalgChainMorphism, IsInt ] );

DeclareOperation( "Homology",
        [ IsHomalgChainMorphism, IsInt ] );

DeclareOperation( "Cohomology",
        [ IsHomalgChainMorphism, IsInt ] );

DeclareOperation( "DefectOfExactness",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "Homology",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "Cohomology",
        [ IsHomalgChainMorphism ] );

DeclareOperation( "CompleteChainMorphism",
        [ IsHomalgChainMorphism, IsInt ] );

DeclareOperation( "CompleteChainMorphism",
        [ IsHomalgChainMorphism ] );
