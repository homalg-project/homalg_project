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
            color := "\033[4;30;46m" )
        );

##
InstallValue( LogicalImplicationsForHomalgRings,
        [ ## from special to general, at least try it:
          
          ## IsFieldForHomalg (a field)
          [ IsFieldForHomalg,
            "implies", IsCommutative ],			## by definition
          
          [ IsFieldForHomalg,
            "implies", IsDivisionRingForHomalg ],
          
          ## IsDivisionRingForHomalg (a division ring)
          [ IsDivisionRingForHomalg,
            "implies", IsIntegralDomain ],
          
          [ IsDivisionRingForHomalg,
            "implies", IsLocalRing ],
          
          [ IsDivisionRingForHomalg,
            "implies", IsSimpleRing ],
          
          [ IsDivisionRingForHomalg,
            "implies", ContainsAField ],		## as its center
          
          [ IsDivisionRingForHomalg, "and", IsCommutative,
            "implies", IsFieldForHomalg ],
          
          ## IsIntegersForHomalg (the ring of integers)
          [ IsIntegersForHomalg,
            "implies", IsCommutative ],
          
          [ IsIntegersForHomalg,
            "implies", IsPrincipalIdealRing ],		## Euclid: even a euclidean ring
          
          [ IsIntegersForHomalg,
            "implies", IsIntegralDomain ],
          
          ## IsResidueClassRingOfTheIntegers
          [ IsResidueClassRingOfTheIntegers,
            "implies", IsCommutative ],
          
          [ IsResidueClassRingOfTheIntegers,
            "implies", IsPrincipalIdealRing ],		## quotients of PIR are PIR
          
          ## IsKaplanskyHermite (each GL(2,R)-orbit of 1x2-rows has an element of the form (d,0), cf. [Lam06, Appendix of I.4, Prop. 4.24])
          [ IsKaplanskyHermite,
            "implies", IsCommutative ],			## by definition
          
          [ IsKaplanskyHermite,
            "implies", IsHermite ],			## [Lam06, Theorem I.4.26,(A)]
          
          [ IsKaplanskyHermite,
            "implies", IsBezoutRing ],			## [Lam06, Theorem I.4.26,(A)]
          
          ## IsBezoutRing (a commutative ring in which every f.g. ideal is principal (e.g. the ring of entire functions on \C), cf. [Lam06, Example I.4.7,(5)])
          [ IsBezoutRing,
            "implies", IsCommutative ],			## by definition
          
          [ IsBezoutRing, "and", IsNoetherian,
            "imply", IsPrincipalIdealRing ],		## trivial
          
          [ IsBezoutRing, "and", IsIntegralDomain,
            "imply", IsKaplanskyHermite ],		## [Lam06, Example I.4.7,(5) and Corollary I.4.28]
          
          [ IsBezoutRing, "and", IsLocalRing,
            "imply", IsKaplanskyHermite ],		## [Lam06, Corollary I.4.28]
          
          ## IsDedekindDomain (integrally closed noetherian with Krull dimension at most 1)
          [ IsDedekindDomain,
            "implies", IsCommutative ],			## by definition
          
          [ IsDedekindDomain,
            "implies", IsNoetherian ],			## by definition
          
          [ IsDedekindDomain,
            "implies", IsIntegralDomain ],		## by definition
          
          [ IsDedekindDomain,
            "implies", IsIntegrallyClosedDomain ],	## by definition
          
          [ IsDedekindDomain,
            "implies", IsHermite ],			## [Lam06, Example I.4.7,(4)]
          
          [ IsDedekindDomain,
            "implies", IsHereditary ],			## [Lam06, footnote on p. 72]
          
          [ IsDedekindDomain, "and", IsUniqueFactorizationDomain,
            "imply", IsPrincipalIdealRing ],		## ................
          
          [ IsDedekindDomain, "and", IsLocalRing,
            "imply", IsDiscreteValuationRing ],		## [Weibel, Kbook.I.pdf Examples on p. 18]
          
          [ IsDedekindDomain, "and", IsFiniteFreePresentationRing,
            "imply", IsPrincipalIdealRing ],		## the Steinitz theory
          
          ## IsDiscreteValuationRing (a valuation ring with valuation group = Z, cf. [Hart, Definition and Theorem I.6.2A])
          [ IsDiscreteValuationRing,
            "implies", IsCommutative ],			## by definition
          
          [ IsDiscreteValuationRing,
            "implies", IsIntegralDomain ],		## by definition
          
          [ IsDiscreteValuationRing,
            "implies", IsPrincipalIdealRing ],		## [Weibel, Kbook.I.pdf Lemma 2.2]
          
          ## Is/Left/Right/Hereditary (every left/right ideal is projective, cf. [Lam06, Definition II.2.1])
          [ IsHereditary, "and", IsCommutative, "and", IsIntegralDomain,
            "imply", IsDedekindDomain ],		## [Lam06, footnote on p. 72]
          
          ## IsIntegrallyClosedDomain (closed in its field of fractions)
          [ IsIntegrallyClosedDomain,
            "implies", IsIntegralDomain ],		## trivial
          
          ## IsUniqueFactorizationDomain (unique factorization domain)
          [ IsUniqueFactorizationDomain,
            "implies", IsCommutative ],			## by definition
          
          [ IsUniqueFactorizationDomain,
            "implies", IsIntegrallyClosedDomain ],	## easy, wikipedia
          
          ## IsCommutative
          [ IsCommutative,
            "implies", HasInvariantBasisProperty ],	## [Lam06, p. 26]
          
          ## IsLocalRing (a single maximal left/right/ideal)
          [ IsLocalRing,
            "implies", IsSemiLocalRing ],		## trivial
          
          [ IsLocalRing,
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
            "implies", IsUniqueFactorizationDomain ],
          
          [ IsFreePolynomialRing,
            "implies", IsFiniteFreePresentationRing ],	## Hilbert Syzygies Theorem
          
          [ IsFreePolynomialRing,
            "implies", IsHermite ],			## Quillen-Suslin theorem: IsFreePolynomialRing => IsHermite
          
          ] );


AddLeftRightLogicalImplicationsForHomalg( LogicalImplicationsForHomalgRings,
        [
         [ "Has", "InvariantBasisProperty" ],
         [ "Is", "Hermite" ],
         [ "Is", "Hereditary" ],
         [ "Is", "Noetherian" ],
         [ "Is", "OreDomain" ],
         [ "Is", "GlobalDimensionFinite" ],
         [ "Is", "FiniteFreePresentationRing" ],
         [ "Is", "PrincipalIdealRing", "<>" ],
         ] );

####################################
#
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalg( LogicalImplicationsForHomalgRings, IsHomalgRing );

##
InstallTrueMethod( IsLeftPrincipalIdealRing, IsHomalgRing and IsEuclideanRing );

####################################
#
# immediate methods for properties:
#
####################################

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

##
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


####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( WeightsOfIndeterminates,
        "for homalg rings",
        [ IsHomalgRing and IsFreePolynomialRing ],
        
  function( S )
    
    return ListWithIdenticalEntries( Length( IndeterminatesOfPolynomialRing( S ) ), 1 );
    
end );

##
InstallMethod( WeightsOfIndeterminates,
        "for homalg rings",
        [ IsHomalgRing and IsExteriorRing ],
        
  function( E )
    
    return ListWithIdenticalEntries( Length( IndeterminatesOfExteriorRing( E ) ), 1 );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( \+,
        "of two homalg ring element",
        [ IsHomalgRingElement and IsOne, IsHomalgRingElement and IsMinusOne ], 1001,
        
  function( r, s )
    
    if not IsIdenticalObj( HomalgRing( r ), HomalgRing( s ) ) then
        Error( "the two ring are not defined over identically the same ring\n" );
    fi;
    
    return Zero( r );
    
end );

##
InstallMethod( \+,
        "of two homalg ring element",
        [ IsHomalgRingElement and IsMinusOne, IsHomalgRingElement and IsOne ], 1001,
        
  function( r, s )
    
    if not IsIdenticalObj( HomalgRing( r ), HomalgRing( s ) ) then
        Error( "the two ring are not defined over identically the same ring\n" );
    fi;
    
    return Zero( r );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "for homalg rings elements",
        [ IsHomalgRingElement and IsOne ],
        
  function( r )
    
    return MinusOneMutable( r );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "for homalg rings elements",
        [ IsHomalgRingElement and IsMinusOne ],
        
  function( r )
    
    return One( r );
    
end );

