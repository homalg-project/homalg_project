#############################################################################
##
##  HomalgChainMap.gd           Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for homalg chain maps.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "*",
        [ IsHomalgRing, IsHomalgChainMap ] );

DeclareOperation( "*",
        [ IsHomalgChainMap, IsHomalgRing ] );

# basic operations:

DeclareOperation( "Add",
        [ IsHomalgChainMap, IsHomalgMatrix ] );

