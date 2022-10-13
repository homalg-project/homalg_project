# SPDX-License-Identifier: GPL-2.0-or-later
# GradedRingForHomalg: Endow Commutative Rings with an Abelian Grading
#
# Declarations
#
# LIGrRNG = Logical Implications for homalg GRaded RiNGs

# our info class:
DeclareInfoClass( "InfoLIGRNG" );
SetInfoLevel( InfoLIGRNG, 1 );

# a central place for configurations:
DeclareGlobalVariable( "LIGrRNG" );

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

DeclareAttribute( "MaximalIdealAsColumnMatrix",
        IsHomalgGradedRing );

DeclareAttribute( "MaximalIdealAsRowMatrix",
        IsHomalgGradedRing );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "HelperToInstallMethodsForGradedRingElementsAttributes" );


DeclareOperation( "RandomHomogeneousElement", [ IsHomalgGradedRing, IsHomalgModuleElement, IsInt ] );
