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

## TorsionSubmodule
DeclareGlobalFunction( "_Functor_TorsionSubmodule_OnObjects" );

DeclareGlobalVariable( "Functor_TorsionSubmodule" );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "TorsionSubmoduleEmb",
        IsHomalgMorphism );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "TorsionSubmodule",
        [ IsHomalgMorphism ] );

