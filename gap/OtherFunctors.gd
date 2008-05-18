#############################################################################
##
## OtherFunctors.gd             homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for some other functors.
##
#############################################################################

####################################
#
# global variables:
#
####################################

## TorsionFreeFactor
DeclareGlobalFunction( "_Functor_TorsionFreeFactor_OnObjects" );

DeclareGlobalVariable( "Functor_TorsionFreeFactor" );

## TorsionSubmodule
DeclareGlobalFunction( "_Functor_TorsionSubmodule_OnObjects" );

DeclareGlobalVariable( "Functor_TorsionSubmodule" );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "TorsionFreeFactorEpi",
        IsHomalgMorphism );

DeclareAttribute( "TorsionSubmoduleEmb",
        IsHomalgMorphism );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "TorsionFreeFactor",
        [ IsHomalgMorphism ] );

DeclareOperation( "TorsionSubmodule",
        [ IsHomalgMorphism ] );

