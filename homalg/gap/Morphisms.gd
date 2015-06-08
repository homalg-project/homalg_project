#############################################################################
##
##  Morphisms.gd                homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations of homalg procedures for morphisms of abelian categories.
##
#############################################################################

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

