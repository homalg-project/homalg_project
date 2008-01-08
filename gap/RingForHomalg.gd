#############################################################################
##
##  RingForHomalg.gd            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg rings.
##
#############################################################################


####################################
#
# categories:
#
####################################

# a new category of objects:

DeclareCategory( "IsRingForHomalg",
        IsAttributeStoringRep );

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "SimpleLogicalImplicationsForHomalgRings" );

####################################
#
# properties:
#
####################################

## properties listed alphabetically (ignoring left/right):

DeclareProperty( "IsGlobalDimensionFinite",
        IsRingForHomalg );

DeclareProperty( "IsLeftGlobalDimensionFinite",
        IsRingForHomalg );

DeclareProperty( "IsRightGlobalDimensionFinite",
        IsRingForHomalg );

DeclareProperty( "IsIntegralDomain",
        IsRingForHomalg );

DeclareProperty( "IsNoetherian", 
        IsRingForHomalg );

DeclareProperty( "IsLeftNoetherian",
        IsRingForHomalg );

DeclareProperty( "IsRightNoetherian",
        IsRingForHomalg );

DeclareProperty( "IsOreDomain", 
        IsRingForHomalg );

DeclareProperty( "IsLeftOreDomain",
        IsRingForHomalg );

DeclareProperty( "IsRightOreDomain",
        IsRingForHomalg );

DeclareProperty( "IsPrincipalIdealRing",
        IsRingForHomalg );

DeclareProperty( "IsLeftPrincipalIdealRing",
        IsRingForHomalg );

DeclareProperty( "IsRightPrincipalIdealRing",
        IsRingForHomalg );

DeclareProperty( "IsRegular",
        IsRingForHomalg );

DeclareProperty( "IsSimpleRing",
        IsRingForHomalg );

####################################
#
# attributes:
#
####################################

## The homalg ring package conversion table:
DeclareAttribute( "HomalgTable",
        IsRingForHomalg, "mutable" );

## residue class rings for homalg:
DeclareAttribute( "RingRelations",
        IsRingForHomalg );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "CreateRingForHomalg" );

