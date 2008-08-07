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

# a new GAP-category:

DeclareCategory( "IsHomalgRing",
        IsHomalgRingOrModule );

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

DeclareProperty( "ContainsAField",
        IsHomalgRing );

DeclareProperty( "IsRationalsForHomalg",
        IsHomalgRing );

DeclareProperty( "IsFieldForHomalg",
        IsHomalgRing );

DeclareProperty( "IsDivisionRingForHomalg",
        IsHomalgRing );

DeclareProperty( "IsIntegersForHomalg",
        IsHomalgRing );

DeclareProperty( "IsResidueClassRingOfTheIntegers",
        IsHomalgRing );

DeclareProperty( "IsBezoutRing",
        IsHomalgRing );

DeclareProperty( "IsIntegrallyClosedDomain",
        IsHomalgRing );

DeclareProperty( "IsUniqueFactorizationDomain",
        IsHomalgRing );

DeclareProperty( "IsKaplanskyHermite",
        IsHomalgRing );

DeclareProperty( "IsDedekindDomain",
        IsHomalgRing );

DeclareProperty( "IsDiscreteValuationRing",
        IsHomalgRing );

DeclareProperty( "IsFreePolynomialRing",
        IsHomalgRing );

DeclareProperty( "IsWeylRing",
        IsHomalgRing );

DeclareProperty( "IsGlobalDimensionFinite",
        IsHomalgRing );

DeclareProperty( "IsLeftGlobalDimensionFinite",
        IsHomalgRing );

DeclareProperty( "IsRightGlobalDimensionFinite",
        IsHomalgRing );

DeclareProperty( "HasLeftInvariantBasisProperty",
        IsHomalgRing );

DeclareProperty( "HasRightInvariantBasisProperty",
        IsHomalgRing );

DeclareProperty( "HasInvariantBasisProperty",
        IsHomalgRing );

DeclareProperty( "IsLocalRing",
        IsHomalgRing );

DeclareProperty( "IsSemiLocalRing",
        IsHomalgRing );

DeclareProperty( "IsIntegralDomain",
        IsHomalgRing );

DeclareProperty( "IsHereditary",
        IsHomalgRing );

DeclareProperty( "IsLeftHereditary",
        IsHomalgRing );

DeclareProperty( "IsRightHereditary",
        IsHomalgRing );

DeclareProperty( "IsHermite",
        IsHomalgRing );

DeclareProperty( "IsLeftHermite",
        IsHomalgRing );

DeclareProperty( "IsRightHermite",
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

DeclareProperty( "IsFiniteFreePresentationRing",
        IsHomalgRing );

DeclareProperty( "IsLeftFiniteFreePresentationRing",
        IsHomalgRing );

DeclareProperty( "IsRightFiniteFreePresentationRing",
        IsHomalgRing );

DeclareProperty( "IsSimpleRing",
        IsHomalgRing );

DeclareProperty( "IsSemiSimpleRing",
        IsHomalgRing );

DeclareProperty( "BasisAlgorithmRespectsPrincipalIdeals",
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

##
DeclareAttribute( "KrullDimension",
        IsHomalgRing );

##
DeclareAttribute( "LeftGlobalDimension",
        IsHomalgRing );

##
DeclareAttribute( "RightGlobalDimension",
        IsHomalgRing );

##
DeclareAttribute( "GlobalDimension",
        IsHomalgRing );

## [McCRob, 11.1.14]
DeclareAttribute( "GeneralLinearRank",
        IsHomalgRing );

## [McCRob, 11.3.10]
DeclareAttribute( "ElementaryRank",
        IsHomalgRing );

## [McCRob, 11.3.4]
DeclareAttribute( "StableRank",
        IsHomalgRing );

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgExternalRingElement ] );

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsRingElement ] );

DeclareOperation( "IsUnit",
        [ IsHomalgRing, IsRingElement ] );

DeclareOperation( "IsUnit",
        [ IsHomalgExternalRingElement ] );

DeclareOperation( "RingName",
        [ IsHomalgRing ] );

DeclareOperation( "DisplayRing",
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

DeclareOperation( "homalgRingStatistics",
        [ IsHomalgRing ] );

DeclareOperation( "IncreaseRingStatistics",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "AsLeftModule",
        [ IsHomalgRing ] );

DeclareOperation( "AsRightModule",
        [ IsHomalgRing ] );

DeclareOperation( "*",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "*",
        [ IsHomalgRing, IsInt ] );

DeclareOperation( "SetRingProperties",
        [ IsHomalgRing, IsInt ] );

DeclareOperation( "SetRingProperties",
        [ IsHomalgRing, IsHomalgRing, IsList ] );

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

DeclareGlobalFunction( "_CreateHomalgRingToTestProperties" );

