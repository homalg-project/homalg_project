# SPDX-License-Identifier: GPL-2.0-or-later
# LocalizeRingForHomalg: A Package for Localization of Polynomial Rings
#
# Declarations
#

##  Declarations for Mora basis related computations of local rings.

DeclareOperation( "CreateHomalgTableForLocalizedRingsWithMora",
        [ IsHomalgRing ] );

DeclareOperation( "_LocalizePolynomialRingAtZeroWithMora",
        [ IsHomalgRing ] );

DeclareOperation( "LocalizePolynomialRingAtZeroWithMora",
        [ IsHomalgRing ] );
