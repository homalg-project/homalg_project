#############################################################################
##
##  Tate.gd                     Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Declarations of procedures for the pair of adjoint Tate functors.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "TateResolution",
        [ IsHomalgRingOrModule, IsHomalgRing, IsInt, IsInt ] );

DeclareOperation( "TateResolution",
        [ IsHomalgRingOrModule, IsInt, IsInt ] );

