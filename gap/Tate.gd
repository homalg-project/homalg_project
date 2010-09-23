#############################################################################
##
##  Tate.gd                     Graded Modules package
##
##  Copyright 2008-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
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

