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

DeclareCategory( "IsHomalgRingOrHomalgModule",	## we need this category to define things like Hom(M,R) as easy as Hom(M,N) without distinguishing between rings and modules
        IsAttributeStoringRep );

DeclareCategory( "IsHomalgRing",
        IsHomalgRingOrHomalgModule
        and IsAttributeStoringRep );

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

##
DeclareAttribute( "IndeterminateCoordinatesOfRingOfDerivations",
        IsHomalgRing );

##
DeclareAttribute( "IndeterminateDerivationsOfRingOfDerivations",
        IsHomalgRing );

## minus one:
DeclareAttribute( "LeftGlobalDimension",
        IsHomalgRing );

## minus one:
DeclareAttribute( "RightGlobalDimension",
        IsHomalgRing );

## minus one:
DeclareAttribute( "GlobalDimension",
        IsHomalgRing );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgExternalRingElement ] );

DeclareOperation( "IsUnit",
        [ IsHomalgRing, IsRingElement ] );

DeclareOperation( "IsUnit",
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

DeclareOperation( "*",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "*",
        [ IsHomalgRing, IsInt ] );

DeclareOperation( "PolynomialRing",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "RingOfDerivations",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "*",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "homalgSetName",
        [ IsHomalgExternalRingElement, IsString ] );

DeclareOperation( "homalgSetName",
        [ IsHomalgExternalRingElement, IsString, IsHomalgRing ] );

# constructor methods:

DeclareGlobalFunction( "CreateHomalgRing" );

DeclareGlobalFunction( "HomalgRingOfIntegers" );

DeclareGlobalFunction( "HomalgFieldOfRationals" );

DeclareGlobalFunction( "HomalgExternalRingElement" );

DeclareGlobalFunction( "StringToElementStringList" );

