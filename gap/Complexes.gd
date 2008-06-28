#############################################################################
##
##  Complexes.gd                homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations of homalg procedures for complexes.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "Homology",
        [ IsHomalgComplex ] );

DeclareOperation( "Cohomology",
        [ IsHomalgComplex ] );

DeclareOperation( "Resolution",
        [ IsInt, IsHomalgComplex ] );

DeclareOperation( "Resolution",
        [ IsHomalgComplex ] );

DeclareOperation( "ConnectingHomomorphism",
        [ IsHomalgModule, IsHomalgMap, IsHomalgMap, IsHomalgMap, IsHomalgModule ] );

