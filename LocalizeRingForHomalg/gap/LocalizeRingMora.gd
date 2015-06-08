#############################################################################
##
##  LocalizeRingMora.gd                        LocalizeRingForHomalg package
##
##  Copyright 2009-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations for Mora basis related computations of local rings.
##
#############################################################################

DeclareOperation( "CreateHomalgTableForLocalizedRingsWithMora",
        [ IsHomalgRing ] );

DeclareOperation( "_LocalizePolynomialRingAtZeroWithMora",
        [ IsHomalgRing ] );

DeclareOperation( "LocalizePolynomialRingAtZeroWithMora",
        [ IsHomalgRing ] );
