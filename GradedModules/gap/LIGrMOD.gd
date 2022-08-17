# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Declarations
#

##         LIGrMOD = Logical Implications for Graded MODules

# our info class:
DeclareInfoClass( "InfoLIGrMOD" );
SetInfoLevel( InfoLIGrMOD, 1 );

####################################
#
# global variables:
#
####################################

# a central place for configurations:
DeclareGlobalVariable( "LIGrMOD" );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "HilbertPoincareSeries",
        [ IsBettiTable, IsInt, IsRingElement ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsBettiTable, IsHomalgElement, IsRingElement ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsBettiTable, IsInt ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsBettiTable, IsHomalgElement ] );

DeclareOperation( "HilbertPolynomial",
        [ IsBettiTable, IsInt, IsRingElement ] );

DeclareOperation( "HilbertPolynomial",
        [ IsBettiTable, IsHomalgElement, IsRingElement ] );

DeclareOperation( "HilbertPolynomial",
        [ IsBettiTable, IsInt ] );

DeclareOperation( "HilbertPolynomial",
        [ IsBettiTable, IsHomalgElement ] );
