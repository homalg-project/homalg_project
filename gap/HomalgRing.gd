#############################################################################
##
##  HomalgRing.gd               homalg package               Mohamed Barakat
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

DeclareCategory( "IsHomalgRing",
        IsAttributeStoringRep );

DeclareCategory( "IsHomalgExternalRingElement",
        IsExtAElement
        and IsExtLElement
        and IsExtRElement
        and IsAdditiveElementWithInverse
        and IsMultiplicativeElementWithInverse
        and IsAssociativeElement
        and IsAdditivelyCommutativeElement
        and IshomalgExternalObject );

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

DeclareProperty( "IsIntegersForHomalg",
        IsHomalgRing );

DeclareProperty( "IsRationalsForHomalg",
        IsHomalgRing );

DeclareProperty( "IsFieldForHomalg",
        IsHomalgRing );

DeclareProperty( "IsGlobalDimensionFinite",
        IsHomalgRing );

DeclareProperty( "IsLeftGlobalDimensionFinite",
        IsHomalgRing );

DeclareProperty( "IsRightGlobalDimensionFinite",
        IsHomalgRing );

DeclareProperty( "IsIntegralDomain",
        IsHomalgRing );

DeclareProperty( "IsNoetherian", 
        IsHomalgRing );

DeclareProperty( "IsLeftNoetherian",
        IsHomalgRing );

DeclareProperty( "IsRightNoetherian",
        IsHomalgRing );

DeclareProperty( "IsOreDomain", 
        IsHomalgRing );

DeclareProperty( "IsLeftOreDomain",
        IsHomalgRing );

DeclareProperty( "IsRightOreDomain",
        IsHomalgRing );

DeclareProperty( "IsPrincipalIdealRing",
        IsHomalgRing );

DeclareProperty( "IsLeftPrincipalIdealRing",
        IsHomalgRing );

DeclareProperty( "IsRightPrincipalIdealRing",
        IsHomalgRing );

DeclareProperty( "IsRegular",
        IsHomalgRing );

DeclareProperty( "IsSimpleRing",
        IsHomalgRing );

####################################
#
# attributes:
#
####################################

## The homalg ring package conversion table:
DeclareAttribute( "homalgTable",
        IsHomalgRing, "mutable" );

## residue class rings for homalg:
DeclareAttribute( "RingRelations",
        IsHomalgRing );

## zero:
DeclareAttribute( "Zero",
        IsHomalgRing );

## one:
DeclareAttribute( "One",
        IsHomalgRing );

## minus one:
DeclareAttribute( "MinusOne",
        IsHomalgRing );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgExternalRingElement ] );

DeclareOperation( "RingName",
        [ IsHomalgRing ] );

DeclareOperation( "homalgPointer",
        [ IsHomalgRing ] );

DeclareOperation( "homalgExternalCASystem",
        [ IsHomalgRing ] );

DeclareOperation( "homalgExternalCASystemVersion",
        [ IsHomalgRing ] );

DeclareOperation( "homalgStream",
        [ IsHomalgRing ] );

DeclareOperation( "homalgExternalCASystemPID",
        [ IsHomalgRing ] );

DeclareOperation( "homalgLastWarning",
        [ IsHomalgRing ] );

DeclareOperation( "homalgNrOfWarnings",
        [ IsHomalgRing ] );

DeclareOperation( "AsLeftModule",
        [ IsHomalgRing ] );

DeclareOperation( "AsRightModule",
        [ IsHomalgRing ] );

DeclareOperation( "PolynomialRing",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "*",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "homalgSetName",
        [ IsHomalgExternalRingElement, IsString ] );

# constructor methods:

DeclareGlobalFunction( "CreateHomalgRing" );

DeclareGlobalFunction( "HomalgRingOfIntegers" );

DeclareGlobalFunction( "HomalgFieldOfRationals" );

DeclareGlobalFunction( "HomalgExternalRingElement" );

DeclareGlobalFunction( "StringToElementStringList" );

