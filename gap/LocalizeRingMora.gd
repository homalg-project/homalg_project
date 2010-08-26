#############################################################################
##
##  LocalizeRingMora.gd     LocalizeRingForHomalg package    Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations for Mora basis related computations of local rings.
##
#############################################################################

DeclareOperation( "CreateHomalgTableForLocalizedRingsWithMora",
        [ IsHomalgRing ] );

DeclareOperation( "LocalizePolynomialRingAtZeroWithMora",
        [ IsHomalgRing ] );
