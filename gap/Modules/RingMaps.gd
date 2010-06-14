#############################################################################
##
##  RingMaps.gd                 Sheaves package              Mohamed Barakat
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
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

