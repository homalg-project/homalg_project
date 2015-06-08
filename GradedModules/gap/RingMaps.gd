#############################################################################
##
##  RingMaps.gd                 Graded Modules package
##
##  Copyright 2009-2010, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Declarations of procedures for ring maps.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "SegreMap",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "PlueckerMap",
        [ IsInt, IsInt, IsHomalgRing, IsString ] );

DeclareOperation( "VeroneseMap",
        [ IsInt, IsInt, IsHomalgRing, IsString ] );

