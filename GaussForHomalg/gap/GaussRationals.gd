# SPDX-License-Identifier: GPL-2.0-or-later
# GaussForHomalg: Gauss functionality for the homalg project
#
# Declarations
#

##  Declarations for the homalg field of rationals

DeclareGlobalFunction( "HomalgFieldOfRationals" );

DeclareOperation( "HomalgFieldOfRationalsInUnderlyingCAS",
        [ IsHomalgRing ] );
