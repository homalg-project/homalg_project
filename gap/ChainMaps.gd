#############################################################################
##
##  ChainMaps.gd                homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations of homalg procedures for chain maps.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "DefectOfExactness",
        [ IsHomalgChainMap, IsInt ] );

DeclareOperation( "Homology",
        [ IsHomalgChainMap, IsInt ] );

DeclareOperation( "Cohomology",
        [ IsHomalgChainMap, IsInt ] );

DeclareOperation( "DefectOfExactness",
        [ IsHomalgChainMap ] );

DeclareOperation( "Homology",
        [ IsHomalgChainMap ] );

DeclareOperation( "Cohomology",
        [ IsHomalgChainMap ] );

