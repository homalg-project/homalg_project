#############################################################################
##
##  HomalgResidueClassRing.gd   homalg package               Mohamed Barakat
##
##  Copyright 2007-2009 Mohamed Barakat, Universität des Saarlandes
##
##  Declaration stuff for homalg residue class rings.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "/",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "/",
        [ IsHomalgRing, IsRingElement ] );

DeclareOperation( "/",
        [ IsHomalgRing, IsHomalgRelations ] );

