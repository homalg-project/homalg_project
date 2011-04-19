#############################################################################
##
##  HomalgChainMap.gd           Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for homalg chain morphisms.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "*",
        [ IsHomalgRing, IsHomalgChainMorphism ] );

DeclareOperation( "*",
        [ IsHomalgChainMorphism, IsHomalgRing ] );

# basic operations:

DeclareOperation( "Add",
        [ IsHomalgChainMorphism, IsHomalgMatrix ] );

