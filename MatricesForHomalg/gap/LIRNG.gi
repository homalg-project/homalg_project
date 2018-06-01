#############################################################################
##
##  LIRNG.gi                    LIRNG subpackage             Mohamed Barakat
##
##         LIRNG = Logical Implications for homalg RiNGs
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the LIRNG subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIRNG,
        rec(
            color := "\033[4;30;46m",
            
            intrinsic_properties := [
                                     "ContainsAField",
                                     "IsRationalsForHomalg",
                                     "IsFieldForHomalg",
                                     "IsDivisionRingForHomalg",
                                     "IsIntegersForHomalg",
                                     "IsResidueClassRingOfTheIntegers",
                                     "IsBezoutRing",
                                     "IsIntegrallyClosedDomain",
                                     "IsUniqueFactorizationDomain",
                                     "IsKaplanskyHermite",
                                     "IsDedekindDomain",
                                     "IsDiscreteValuationRing",
                                     "IsFreePolynomialRing",
                                     "IsWeylRing",
                                     "IsExteriorRing",
                                     "IsGlobalDimensionFinite",
                                     "IsLeftGlobalDimensionFinite",
                                     "IsRightGlobalDimensionFinite",
                                     "HasInvariantBasisProperty",
                                     "HasLeftInvariantBasisProperty",
                                     "HasRightInvariantBasisProperty",
                                     "IsLocal",
                                     "IsSemiLocalRing",
                                     "IsIntegralDomain",
                                     "IsHereditary",
                                     "IsLeftHereditary",
                                     "IsRightHereditary",
                                     "IsHermite",
                                     "IsLeftHermite",
                                     "IsRightHermite",
                                     "IsNoetherian",
                                     "IsLeftNoetherian",
                                     "IsRightNoetherian",
                                     "IsArtinian",
                                     "IsLeftArtinian",
                                     "IsRightArtinian",
                                     "IsOreDomain",
                                     "IsLeftOreDomain",
                                     "IsRightOreDomain",
                                     "IsPrincipalIdealRing",
                                     "IsLeftPrincipalIdealRing",
                                     "IsRightPrincipalIdealRing",
                                     "IsRegular",
                                     "IsFiniteFreePresentationRing",
                                     "IsLeftFiniteFreePresentationRing",
                                     "IsRightFiniteFreePresentationRing",
                                     "IsSimpleRing",
                                     "IsSemiSimpleRing",
                                     "BasisAlgorithmRespectsPrincipalIdeals",
                                     "AreUnitsCentral"
                                   ],
            
            intrinsic_attributes := [
                                     "RationalParameters",
                                     "IndeterminateCoordinatesOfRingOfDerivations",
                                     "IndeterminateDerivationsOfRingOfDerivations",
                                     "IndeterminateAntiCommutingVariablesOfExteriorRing",
                                     "IndeterminateAntiCommutingVariablesOfExteriorRing",
                                     "IndeterminatesOfExteriorRing",
                                     "Characteristic",
                                     "DegreeOverPrimeField",
                                     "CoefficientsRing",
                                     "BaseRing",
                                     "IndeterminatesOfPolynomialRing",
                                     "KrullDimension"
                                   ]
            )
        );

##
InstallValue( LogicalImplicationsForHomalgRings,
        [ ## from special to general, at least try it:
          
          [ IsRationalsForHomalg,
            "implies", IsFieldForHomalg ],
          
##------------------------------------
## IsFieldForHomalg (a field) implies:
##
          
          ## by definition:
          [ IsFieldForHomalg,
            "implies", IsCommutative ],
          
          [ IsFieldForHomalg,
            "implies", IsDivisionRingForHomalg ],
          
##---------------------------------------------------
## IsDivisionRingForHomalg (a division ring) implies:
##
          
          [ IsDivisionRingForHomalg,
            "implies", IsIntegralDomain ],
          
          [ IsDivisionRingForHomalg,
            "implies", IsLeftArtinian ],
          
          [ IsDivisionRingForHomalg,
            "implies", IsRightArtinian ],
          
          [ IsDivisionRingForHomalg,
            "implies", IsLocal ],
          
          [ IsDivisionRingForHomalg,
            "implies", IsSimpleRing ],
          
          ## as its center:
          [ IsDivisionRingForHomalg,
            "implies", ContainsAField ],
          
          [ IsDivisionRingForHomalg, "and", IsCommutative,
            "implies", IsFieldForHomalg ],
          
##----------------------------------------------------
## IsIntegersForHomalg (the ring of integers) implies:
##
          
          [ IsIntegersForHomalg,
            "implies", IsCommutative ],
          
          [ IsIntegersForHomalg,
            "implies", IsResidueClassRingOfTheIntegers ],
          
          ## Euclid: even true for euclidean rings:
          [ IsIntegersForHomalg,
            "implies", IsPrincipalIdealRing ],
          
          [ IsIntegersForHomalg,
            "implies", IsIntegralDomain ],
          
##-----------------------------------------
## IsResidueClassRingOfTheIntegers implies:
##
          
          [ IsResidueClassRingOfTheIntegers,
            "implies", IsCommutative ],
          
          ## quotients of PIR are PIR:
          [ IsResidueClassRingOfTheIntegers,
            "implies", IsPrincipalIdealRing ],
          
##----------------------------
## IsKaplanskyHermite implies:
## (Def: a commutative ring for which each GL(2,R)-orbit of 1x2-rows
##  has an element of the form (d,0), cf. [Lam06, Appendix of I.4, Prop. 4.24])
##
          
          ## by definition
          [ IsKaplanskyHermite,
            "implies", IsCommutative ],
          
          ## [Lam06, Theorem I.4.26,(A)]:
          [ IsKaplanskyHermite,
            "implies", IsHermite ],
          
          ## [Lam06, Theorem I.4.26,(A)]:
          [ IsKaplanskyHermite,
            "implies", IsBezoutRing ],
          
##----------------------
## IsBezoutRing implies:
## (a commutative ring in which every f.g. ideal is principal
## (e.g. the ring of entire functions on \C), cf. [Lam06, Example I.4.7,(5)])
          
          ## by definition
          [ IsBezoutRing,
            "implies", IsCommutative ],
          
          ## trivial
          [ IsBezoutRing, "and", IsNoetherian,
            "imply", IsPrincipalIdealRing ],
          
          ## [Lam06, Example I.4.7,(5) and Corollary I.4.28]:
          [ IsBezoutRing, "and", IsIntegralDomain,
            "imply", IsKaplanskyHermite ],
          
          ## [Lam06, Corollary I.4.28]:
          [ IsBezoutRing, "and", IsLocal,
            "imply", IsKaplanskyHermite ],
          
##--------------------------
## IsDedekindDomain implies:
## (integrally closed noetherian with Krull dimension at most 1)
          
          ## by definition:
          [ IsDedekindDomain,
            "implies", IsIntegrallyClosedDomain ],
          
          ## by definition:
          [ IsDedekindDomain,
            "implies", IsNoetherian ],
          
          ## by definition (should follow from the above):
          [ IsDedekindDomain,
            "implies", IsCommutative ],
          
          ## by definition (should follow from the above):
          [ IsDedekindDomain,
            "implies", IsIntegralDomain ],
          
          ## [Lam06, Example I.4.7,(4)]:
          [ IsDedekindDomain,
            "implies", IsHermite ],
          
          ## [Lam06, footnote on p. 72]:
          [ IsDedekindDomain,
            "implies", IsHereditary ],
          
          ## ................
          [ IsDedekindDomain, "and", IsUniqueFactorizationDomain,
            "imply", IsPrincipalIdealRing ],
          
          ## [Weibel, Kbook.I.pdf Examples on p. 18]:
          [ IsDedekindDomain, "and", IsLocal,
            "imply", IsDiscreteValuationRing ],
          
          ## the Steinitz theory
          [ IsDedekindDomain, "and", IsFiniteFreePresentationRing,
            "imply", IsPrincipalIdealRing ],
          
##---------------------------------
## IsDiscreteValuationRing implies:
## (a valuation ring with valuation group = Z,
##  cf. [Hart, Definition and Theorem I.6.2A]):
          
          ## by definition
          [ IsDiscreteValuationRing,
            "implies", IsCommutative ],
          
          ## by definition
          [ IsDiscreteValuationRing,
            "implies", IsIntegralDomain ],
          
          ## [Weibel, Kbook.I.pdf Lemma 2.2]
          [ IsDiscreteValuationRing,
            "implies", IsPrincipalIdealRing ],
          
          ## Is/Left/Right/Hereditary (every left/right ideal is projective, cf. [Lam06, Definition II.2.1])
          [ IsHereditary, "and", IsCommutative, "and", IsIntegralDomain,
            "imply", IsDedekindDomain ],		## [Lam06, footnote on p. 72]
          
          ## IsIntegrallyClosedDomain (closed in its field of fractions)
          [ IsIntegrallyClosedDomain,
            "implies", IsIntegralDomain ],		## by definition
          
          ## IsUniqueFactorizationDomain (unique factorization domain)
          [ IsUniqueFactorizationDomain,
            "implies", IsCommutative ],			## by definition
          
          [ IsUniqueFactorizationDomain,
            "implies", IsIntegrallyClosedDomain ],	## easy, wikipedia
          
          ## IsCommutative
          [ IsCommutative,
            "implies", HasInvariantBasisProperty ],	## [Lam06, p. 26]
          
          [ IsCommutative,
            "implies", AreUnitsCentral ],	## by definition
          
          ## IsLocal (a single maximal left/right/ideal)
          [ IsLocal,
            "implies", IsSemiLocalRing ],		## trivial
          
          [ IsLocal,
            "implies", HasInvariantBasisProperty ],	## [Lam06, bottom of p. 26]
          
          ## IsSemiLocalRing				## commutative def.: finitely many maximal ideals [Lam06, bottom of p. 20], general def. R/rad R is left or eq. right artinian [Lam06, top of p. 28]
          [ IsSemiLocalRing,
            "implies", IsHermite ],			## [Lam06, Example I.4.7,(3)], with the correct notion of semilocal, commutativity is not essential, as Lam noted.
          
          ## IsSimpleRing: CAUTION: IsSimple does not imply IsSemiSimple; the Weyl algebra is a counter example
          
          ## IsSemiSimpleRing
          [ IsSemiSimpleRing,
            "implies", IsHermite ],			## [Lam06, Example I.4.7(1)]
          
          ## Is/Left/Right/PrincipalIdealRing
          [ IsLeftPrincipalIdealRing,
            "implies", IsLeftNoetherian ],		## trivial
          
          [ IsRightPrincipalIdealRing,
            "implies", IsRightNoetherian ],		## trivial
          
          [ IsLeftPrincipalIdealRing, "and", IsIntegralDomain,
            "imply", IsLeftFiniteFreePresentationRing ],## trivial
          
          [ IsRightPrincipalIdealRing, "and", IsIntegralDomain,
            "imply", IsRightFiniteFreePresentationRing ],## trivial
          
          [ IsPrincipalIdealRing, "and", IsCommutative,
            "imply", IsKaplanskyHermite ],		## [Lam06, Theorem I.4.31]
          
          [ IsPrincipalIdealRing, "and", IsCommutative,
            "imply", IsBezoutRing ],			## trivial
          
          [ IsPrincipalIdealRing, "and", IsCommutative, "and", IsIntegralDomain,
            "imply", IsUniqueFactorizationDomain ],	## trivial
          
          [ IsPrincipalIdealRing, "and", IsCommutative, "and", IsIntegralDomain,
            "imply", IsDedekindDomain ],		## trivial
          
          ## Is/Left/Right/Noetherian
          [ IsLeftNoetherian,
            "implies", HasLeftInvariantBasisProperty ],	## [Lam06, bottom of p. 26]
          
          [ IsRightNoetherian,
            "implies", HasRightInvariantBasisProperty ],## [Lam06, bottom of p. 26]
          
          [ IsLeftNoetherian, "and", IsIntegralDomain,
            "implies", IsLeftOreDomain ],		## easy ...
          
          [ IsRightNoetherian, "and", IsIntegralDomain,
            "implies", IsRightOreDomain ],		## easy ...
          
          ## Is/Left/Right/OreDomain
          [ IsLeftOreDomain,
            "implies", IsIntegralDomain ],		## by definition
          
          [ IsRightOreDomain,
            "implies", IsIntegralDomain ],		## by definition
          
          ## Serre's theorem: IsRegular <=> IsGlobalDimensionFinite:
          [ IsRegular,
            "implies", IsGlobalDimensionFinite ],
          
          [ IsGlobalDimensionFinite,
            "implies", IsRegular ],
          
          ## IsFreePolynomialRing
          [ IsFreePolynomialRing,
            "implies", IsNoetherian ],
          
          [ IsFreePolynomialRing,
            "implies", IsFiniteFreePresentationRing ],	## Hilbert Syzygies Theorem
          
          [ IsFreePolynomialRing,
            "implies", IsUniqueFactorizationDomain ],
          
          [ IsFreePolynomialRing,
            "implies", IsHermite ],			## Quillen-Suslin theorem: IsFreePolynomialRing => IsHermite
          
##--------------------------------------
## IsFiniteFreePresentationRing implies:
## (synonym IsFiniteFreeResolutionRing)
          
          ## [ Kaplansky, Commutative Rings, Thm. 184 ],
          ## [ Rotman, Thm. 8.66 ]
          [ IsFiniteFreePresentationRing, "and", IsNoetherian, "and", IsIntegralDomain,
            "imply", IsUniqueFactorizationDomain ],
          
          ] );


AddLeftRightLogicalImplicationsForHomalg( LogicalImplicationsForHomalgRings,
        [
         [ "Has", "InvariantBasisProperty" ],
         [ "Is", "Hermite" ],
         [ "Is", "Hereditary" ],
         [ "Is", "OreDomain" ],
         [ "Is", "GlobalDimensionFinite" ],
         [ "Is", "FiniteFreePresentationRing" ],
         [ "Is", "Noetherian", "<>" ],
         [ "Is", "Artinian", "<>" ],
         [ "Is", "PrincipalIdealRing", "<>" ],
         ] );

##
InstallValue( LogicalImplicationsForHomalgRingElements,
        [
          
          [ IsMonic,
            "implies", IsMonicUptoUnit ],
          
          [ IsOne,
            "implies", IsRegular ],
          
          [ IsMinusOne,
            "implies", IsRegular ],
          
         ] );

AddLeftRightLogicalImplicationsForHomalg( LogicalImplicationsForHomalgRingElements,
        [
         [ "Is", "Regular", HomalgRing ],
         ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgBasicObjects( LogicalImplicationsForHomalgRings, IsHomalgRing );

InstallLogicalImplicationsForHomalgBasicObjects( LogicalImplicationsForHomalgRingElements, IsHomalgRingElement );

##
InstallTrueMethod( IsLeftPrincipalIdealRing, IsHomalgRing and IsEuclideanRing );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsZero,
        IsHomalgRing and HasContainsAField, 0,
        
  function( R )
    
    if ContainsAField( R ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFinite,
        IsFieldForHomalg and HasCharacteristic, 0,
        
  function( R )
    
    if Characteristic( R ) = 0 then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFinite,
        IsFieldForHomalg and HasCharacteristic and HasDegreeOverPrimeField, 0,
        
  function( R )
    
    if Characteristic( R ) > 0 then
        return IsInt( DegreeOverPrimeField( R ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsFinite,
        IsFieldForHomalg and HasRationalParameters, 0,
        
  function( R )
    
    ## FIXME: get rid of IsBound( R!.MinimalPolynomialOfPrimitiveElement )
    if Length( RationalParameters( R ) ) > 0 and
       not IsBound( R!.MinimalPolynomialOfPrimitiveElement ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgRing and HasCharacteristic, 0,
        
  function( R )
    
    return Characteristic( R ) = 1;
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgRingElement and IsOne, 0,
        
  function( r )
    local R;
    
    if IsBound( r!.ring ) then
        R := HomalgRing( r );
        if HasIsZero( R ) then
            return IsZero( R );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgRingElement and IsMinusOne, 0,
        
  function( r )
    local R;
    
    if IsBound( r!.ring ) then
        R := HomalgRing( r );
        if HasIsZero( R ) then
            return IsZero( R );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftRegular,
        IsHomalgRingElement and HasIsZero, 0,
        
  function( r )
    local R;
    
    if IsZero( r ) then
        return false;
    fi;
    
    if IsBound( r!.ring ) then
        R := HomalgRing( r );
        if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
            return not IsZero( r );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftRegular,
        IsHomalgRingElement and HasIsRightRegular, 0,
        
  function( r )
    local R;
    
    if IsBound( r!.ring ) then
        R := HomalgRing( r );
        if HasIsCommutative( R ) and IsCommutative( R ) then
            return IsRightRegular( r );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightRegular,
        IsHomalgRingElement and HasIsZero, 0,
        
  function( r )
    local R;
    
    if IsZero( r ) then
        return false;
    fi;
    
    if IsBound( r!.ring ) then
        R := HomalgRing( r );
        if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
            return not IsZero( r );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightRegular,
        IsHomalgRingElement and HasIsLeftRegular, 0,
        
  function( r )
    local R;
    
    if IsBound( r!.ring ) then
        R := HomalgRing( r );
        if HasIsCommutative( R ) and IsCommutative( R ) then
            return IsLeftRegular( r );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftGlobalDimensionFinite,
        IsHomalgRing and HasLeftGlobalDimension, 0,
        
  function( R )
    
    return LeftGlobalDimension( R ) < infinity;
    
end );

##
InstallImmediateMethod( IsRightGlobalDimensionFinite,
        IsHomalgRing and HasRightGlobalDimension, 0,
        
  function( R )
    
    return RightGlobalDimension( R ) < infinity;
    
end );

##
InstallImmediateMethod( IsResidueClassRingOfTheIntegers,
        IsHomalgRing and HasAmbientRing, 0,
        
  function( R )
    
    if HasIsResidueClassRingOfTheIntegers( AmbientRing( R ) ) and IsResidueClassRingOfTheIntegers( AmbientRing( R ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsCommutative,
        IsHomalgRing and HasAmbientRing, 0,
        
  function( R )
    
    if HasIsCommutative( AmbientRing( R ) ) and IsCommutative( AmbientRing( R ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftPrincipalIdealRing,
        IsHomalgRing and HasAmbientRing, 0,
        
  function( R )
    
    if HasIsLeftPrincipalIdealRing( AmbientRing( R ) ) and IsLeftPrincipalIdealRing( AmbientRing( R ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightPrincipalIdealRing,
        IsHomalgRing and HasAmbientRing, 0,
        
  function( R )
    
    if HasIsRightPrincipalIdealRing( AmbientRing( R ) ) and IsRightPrincipalIdealRing( AmbientRing( R ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftNoetherian,
        IsHomalgRing and HasAmbientRing, 0,
        
  function( R )
    
    if HasIsLeftNoetherian( AmbientRing( R ) ) and IsLeftNoetherian( AmbientRing( R ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightNoetherian,
        IsHomalgRing and HasAmbientRing, 0,
        
  function( R )
    
    if HasIsRightNoetherian( AmbientRing( R ) ) and IsRightNoetherian( AmbientRing( R ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallLeftRightAttributesForHomalg(
        [
         "GlobalDimension",
         ], IsHomalgRing );

##
InstallImmediateMethod( LeftGlobalDimension,
        IsHomalgRing and IsLeftPrincipalIdealRing and IsIntegralDomain and HasIsDivisionRingForHomalg, 0,
        
  function( R )
    
    if IsDivisionRingForHomalg( R ) then
        return 0;
    else
        return 1;
    fi;
    
end );

##
InstallImmediateMethod( RightGlobalDimension,
        IsHomalgRing and IsRightPrincipalIdealRing and IsIntegralDomain and HasIsDivisionRingForHomalg, 0,
        
  function( R )
    
    if IsDivisionRingForHomalg( R ) then
        return 0;
    else
        return 1;
    fi;
    
end );

##
InstallImmediateMethod( LeftGlobalDimension,
        IsHomalgRing and HasIsLeftGlobalDimensionFinite, 0,
        
  function( R )
    
    if IsLeftGlobalDimensionFinite( R ) then
        TryNextMethod( );
    fi;
    
    return infinity;
    
end );

##
InstallImmediateMethod( RightGlobalDimension,
        IsHomalgRing and HasIsRightGlobalDimensionFinite, 0,
        
  function( R )
    
    if IsRightGlobalDimensionFinite( R ) then
        TryNextMethod( );
    fi;
    
    return infinity;
    
end );

##
InstallImmediateMethod( GlobalDimension,
        IsHomalgRing and IsDedekindDomain and HasIsFieldForHomalg, 0,		## hence by Serre's theorem: IsDedekindDomain implies GlobalDimension <= 1 < infinity implies IsRegular
        
  function( R )
    
    if IsFieldForHomalg( R ) then
        return 0;
    else
        return 1;
    fi;
    
end );

##
InstallImmediateMethod( GlobalDimension,
        IsHomalgRing and IsFieldForHomalg, 1001,
        
  function( R )
    
    return 0;
    
end );

##
InstallImmediateMethod( GlobalDimension,
        IsHomalgRing and IsDivisionRingForHomalg, 1001,
        
  function( R )
    
    return 0;
    
end );

## FIXME: this should be obsolete by the next method
InstallImmediateMethod( KrullDimension,
        IsHomalgRing and IsPrincipalIdealRing and IsIntegralDomain and IsCommutative and HasIsFieldForHomalg, 0,
        
  function( R )
    
    if not IsFieldForHomalg( R ) then
        return 1;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( KrullDimension,
        IsHomalgRing and IsDedekindDomain and HasIsFieldForHomalg, 0,
        
  function( R )
    
    if not IsFieldForHomalg( R ) then
        return 1;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( KrullDimension,
        IsHomalgRing and IsFieldForHomalg, 1001,
        
  function( R )
    
    return 0;
    
end );

##
InstallImmediateMethod( Center,
        IsHomalgRing and IsCommutative, 0,
        
  function( R )
    
    return R;
    
end );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsZero,
        "LIRNG: for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    
    return IsZero( One( R ) );
    
end );

##
InstallMethod( IsMonic,
        "LIRNG: for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( r )
    
    if IsZero( r ) then
        return false;
    fi;
    
    return IsOne( LeadingCoefficient( r ) );
    
end );

##
InstallMethod( IsMonicUptoUnit,
        "for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( r )
    
    if IsZero( r ) then
        return false;
    fi;
    
    return IsUnit( LeadingCoefficient( r ) );
    
end );

##
InstallMethod( IsLeftRegular,
        "LIRNG: for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return IsLeftRegular( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );
    
end );

##
InstallMethod( IsLeftRegular,
        "LIRNG: for homalg ring elements",
        [ IsHomalgRingElement ], 10001,
        
  function( r )
    local R;
    
    if IsZero( r ) then
        return false;
    fi;
    
    R := HomalgRing( r );
    
    if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
        return not IsZero( r );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsRightRegular,
        "LIRNG: for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return IsRightRegular( HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) ) );
    
end );

##
InstallMethod( IsRightRegular,
        "LIRNG: for homalg ring elements",
        [ IsHomalgRingElement ], 10001,
        
  function( r )
    local R;
    
    if IsZero( r ) then
        return false;
    fi;
    
    R := HomalgRing( r );
    
    if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
        return not IsZero( r );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsRegular,
        "LIRNG: for homalg ring elements",
        [ IsHomalgRingElement ],
        
  function( r )
    local r_mat;
    
    r_mat := HomalgMatrix( [ r ], 1, 1, HomalgRing( r ) );
    
    return ( ( HasIsLeftRegular( r ) and IsLeftRegular( r ) ) or
             IsLeftRegular( r_mat ) ) and
           ( ( HasIsRightRegular( r ) and IsRightRegular( r ) ) or
             IsRightRegular( r_mat ) );
    
end );

##
InstallMethod( IsIrreducibleHomalgRingElement,
        "for a homalg ring",
        [ IsHomalgRingElement ],
        
  function( r )
    local R, RP;
    
    R := HomalgRing( r );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.IsIrreducible) then
        return RP!.IsIrreducible( r );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsIrreducible,
        "for a homalg ring",
        [ IsHomalgRingElement ],
        
  function( r )
    
    return IsIrreducibleHomalgRingElement( r );
    
end );

##
InstallMethod( IsIntegralDomain,
        "for a homalg ring",
        [ IsHomalgRing and HasAmbientRing ],
        
  function( R )
    
    return IsPrime( DefiningIdeal( R ) );
    
end );

####################################
#
# methods for attributes:
#
####################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( \*,	## check if both elements reside in the same ring
        "LIRNG: for two homalg ring element",
        [ IsHomalgRingElement, IsHomalgRingElement ], 10001,
        
  function( r, s )
    
    if not IsIdenticalObj( HomalgRing( r ), HomalgRing( s ) ) then
        Error( "the two ring elements are not defined over identically the same ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "of homalg matrices with ring elements",
        [ IsHomalgRingElement and IsZero, IsHomalgRingElement ], 1001,
        
  function( z, r )
    
    return z;
    
end );

##
InstallMethod( \*,
        "of homalg matrices",
        [ IsHomalgRingElement, IsHomalgRingElement and IsZero ], 1001,
        
  function( r, z )
    
    return z;
    
end );

##
InstallMethod( \*,
        "of homalg matrices with ring elements",
        [ IsHomalgRingElement and IsOne, IsHomalgRingElement ], 1001,
        
  function( o, r )
    
    return r;
    
end );

##
InstallMethod( \*,
        "of homalg matrices",
        [ IsHomalgRingElement, IsHomalgRingElement and IsOne ], 1001,
        
  function( r, o )
    
    return r;
    
end );

##
InstallMethod( \+,	## check if both elements reside in the same ring
        "LIRNG: for two homalg ring element",
        [ IsHomalgRingElement, IsHomalgRingElement ], 10001,
        
  function( r, s )
    
    if not IsIdenticalObj( HomalgRing( r ), HomalgRing( s ) ) then
        Error( "the two ring elements are not defined over identically the same ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \+,
        "LIRNG: for two homalg ring element",
        [ IsHomalgRingElement and IsOne, IsHomalgRingElement and IsMinusOne ], 1001,
        
  function( r, s )
    
    return Zero( r );
    
end );

##
InstallMethod( \+,
        "LIRNG: for two homalg ring element",
        [ IsHomalgRingElement and IsMinusOne, IsHomalgRingElement and IsOne ], 1001,
        
  function( r, s )
    
    return Zero( r );
    
end );

##
InstallMethod( \+,
        "LIRNG: for two homalg ring element",
        [ IsHomalgRingElement, IsHomalgRingElement and IsZero ], 1001,
        
  function( r, z )
    
    return r;
    
end );

##
InstallMethod( \+,
        "LIRNG: for two homalg ring element",
        [ IsHomalgRingElement and IsZero, IsHomalgRingElement ], 1001,
        
  function( z, r )
    
    return r;
    
end );

##
InstallMethod( \-,	## check if both elements reside in the same ring
        "LIRNG: for two homalg ring element",
        [ IsHomalgRingElement, IsHomalgRingElement ], 10001,
        
  function( r, s )
    
    if not IsIdenticalObj( HomalgRing( r ), HomalgRing( s ) ) then
        Error( "the two ring elements are not defined over identically the same ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \-,
        "LIRNG: for two homalg ring element",
        [ IsHomalgRingElement, IsHomalgRingElement ], 1001,
        
  function( r, s )
    
    if IsIdenticalObj( r, s ) then
        return Zero( r );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \-,
        "LIRNG: for two homalg ring element",
        [ IsHomalgRingElement, IsHomalgRingElement and IsZero ], 1001,
        
  function( r, z )
    
    return r;
    
end );

##
InstallMethod( \-,
        "LIRNG: for two homalg ring element",
        [ IsHomalgRingElement and IsZero, IsHomalgRingElement ], 1001,
        
  function( z, r )
    
    return -r;
    
end );

## a method for -Zero( R ) -> Zero( R ) is somehow installed

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "LIRNG: for homalg ring elements",
        [ IsHomalgRingElement and IsOne ],
        
  function( r )
    
    return MinusOneMutable( r );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "LIRNG: for homalg ring elements",
        [ IsHomalgRingElement and IsMinusOne ],
        
  function( r )
    
    return One( r );
    
end );
