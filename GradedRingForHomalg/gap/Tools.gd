# SPDX-License-Identifier: GPL-2.0-or-later
# GradedRingForHomalg: Endow Commutative Rings with an Abelian Grading
#
# Declarations
#

####################################
#
# global functions and operations:
#
####################################

##
DeclareAttribute( "PolynomialsWithoutRelativeIndeterminates",
        IsHomalgMatrix );

# basic operations:

DeclareOperation( "DegreeOfRingElementFunction",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "DegreeOfRingElementFunction",
        [ IsHomalgRing, IsHomalgMatrix ] );

DeclareOperation( "DegreesOfEntriesFunction",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "DegreesOfEntriesFunction",
        [ IsHomalgRing, IsHomalgMatrix ] );

DeclareOperation( "NonTrivialDegreePerRowWithColPositionFunction",
        [ IsHomalgRing, IsList, IsObject, IsObject ] );

DeclareOperation( "NonTrivialDegreePerColumnWithRowPositionFunction",
        [ IsHomalgRing, IsList, IsObject, IsObject ] );

DeclareOperation( "LinearSyzygiesGeneratorsOfRows",
        [ IsHomalgMatrix ] );

DeclareOperation( "LinearSyzygiesGeneratorsOfColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "ExponentsOfGeneratorsOfToricIdeal",
        [ IsList ] );
