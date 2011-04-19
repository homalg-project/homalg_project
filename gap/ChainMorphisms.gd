#############################################################################
##
##  ChainMorphisms.gd                                         homalg package
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations of homalg procedures for chain morphisms.
##
#############################################################################

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

