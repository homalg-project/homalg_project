# SPDX-License-Identifier: GPL-2.0-or-later
# LocalizeRingForHomalg: A Package for Localization of Polynomial Rings
#
# Declarations
#

##  Declaration stuff for LocalizeRingForHomalg.

# our info class:
DeclareInfoClass( "InfoLocalizeRingForHomalg" );
SetInfoLevel( InfoLocalizeRingForHomalg, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_LOCALIZE_RING" );

##
DeclareGlobalVariable( "CommonHomalgTableForLocalizedRings" );

##
DeclareGlobalVariable( "CommonHomalgTableForLocalizedRingsAtPrimeIdeals" );
