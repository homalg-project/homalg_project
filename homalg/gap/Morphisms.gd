# SPDX-License-Identifier: GPL-2.0-or-later
# homalg: A homological algebra meta-package for computable Abelian categories
#
# Declarations
#

##  Declarations of homalg procedures for morphisms of abelian categories.

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "Resolution",
        [ IsInt, IsHomalgStaticMorphism ] );

DeclareOperation( "Resolution",
        [ IsHomalgStaticMorphism ] );

DeclareOperation( "CokernelSequence",
        [ IsHomalgStaticMorphism ] );

DeclareOperation( "CokernelCosequence",
        [ IsHomalgStaticMorphism ] );

DeclareOperation( "KernelSequence",
        [ IsHomalgStaticMorphism ] );

DeclareOperation( "KernelCosequence",
        [ IsHomalgStaticMorphism ] );

