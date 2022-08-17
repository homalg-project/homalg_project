# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Declarations
#

##  Declaration stuff for a filtration.

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgFiltration ] );

DeclareOperation( "MatrixOfFiltration",
        [ IsHomalgFiltration, IsInt ] );

DeclareOperation( "MatrixOfFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "BasisOfModule",
        [ IsHomalgFiltration ] );

DeclareOperation( "DecideZero",
        [ IsHomalgFiltration ] );

DeclareOperation( "OnLessGenerators",
        [ IsHomalgFiltration ] );

DeclareOperation( "ByASmallerPresentation",
        [ IsHomalgFiltration ] );

