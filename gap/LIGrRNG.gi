#############################################################################
##
##  LIGrRNG.gi                  LIGrRNG subpackage           Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##         LIGrRNG = Logical Implications for homalg GRaded RiNGs
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for the LIGrRNG subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIGrRNG,
        rec(
            color := "\033[4;30;46m",
#            intrinsic_properties := LIRNG.intrinsic_properties,
#            intrinsic_attributes := LIRNG.intrinsic_attributes,
            )
        );

#Append( LIGrRNG.intrinsic_properties,
#        [ 
#          ] );

#Append( LIGrRNG.intrinsic_attributes,
#        [ 
#          ] );

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( ContainsAField,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return ContainsAField( UnderlyingNonGradedRing( S ) );
    
end );
        
##
InstallMethod( IsRationalsForHomalg,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsRationalsForHomalg( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsFieldForHomalg,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsFieldForHomalg( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsDivisionRingForHomalg,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsDivisionRingForHomalg( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsIntegersForHomalg,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsIntegersForHomalg( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsResidueClassRingOfTheIntegers,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsResidueClassRingOfTheIntegers( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsBezoutRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsBezoutRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsIntegrallyClosedDomain,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsIntegrallyClosedDomain( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsUniqueFactorizationDomain,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsUniqueFactorizationDomain( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsKaplanskyHermite,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsKaplanskyHermite( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsDedekindDomain,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsDedekindDomain( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsDiscreteValuationRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsDiscreteValuationRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsFreePolynomialRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsFreePolynomialRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsWeylRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsWeylRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsExteriorRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsExteriorRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsGlobalDimensionFinite,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsGlobalDimensionFinite( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsLeftGlobalDimensionFinite,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsLeftGlobalDimensionFinite( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsRightGlobalDimensionFinite,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsRightGlobalDimensionFinite( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( HasInvariantBasisProperty,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return HasInvariantBasisProperty( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( HasLeftInvariantBasisProperty,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return HasLeftInvariantBasisProperty( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( HasRightInvariantBasisProperty,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return HasRightInvariantBasisProperty( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsLocalRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsLocalRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsSemiLocalRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsSemiLocalRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsIntegralDomain,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsIntegralDomain( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsHereditary,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsHereditary( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsLeftHereditary,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsLeftHereditary( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsRightHereditary,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsRightHereditary( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsHermite,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsHermite( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsLeftHermite,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsLeftHermite( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsRightHermite,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsRightHermite( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsNoetherian,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsNoetherian( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsLeftNoetherian,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsLeftNoetherian( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsRightNoetherian,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsRightNoetherian( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsArtinian,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsArtinian( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsLeftArtinian,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsLeftArtinian( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsRightArtinian,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsRightArtinian( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsOreDomain,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsOreDomain( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsLeftOreDomain,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsLeftOreDomain( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsRightOreDomain,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsRightOreDomain( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsPrincipalIdealRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsPrincipalIdealRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsLeftPrincipalIdealRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsLeftPrincipalIdealRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsRightPrincipalIdealRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsRightPrincipalIdealRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsRegular,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsRegular( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsFiniteFreePresentationRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsFiniteFreePresentationRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsLeftFiniteFreePresentationRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsLeftFiniteFreePresentationRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsRightFiniteFreePresentationRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsRightFiniteFreePresentationRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsSimpleRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsSimpleRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( IsSemiSimpleRing,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return IsSemiSimpleRing( UnderlyingNonGradedRing( S ) );
    
end );

##
InstallMethod( BasisAlgorithmRespectsPrincipalIdeals,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return BasisAlgorithmRespectsPrincipalIdeals( UnderlyingNonGradedRing( S ) );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( Zero,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return GradedRingElement( Zero( UnderlyingNonGradedRing( S ) ), S );
    
end );

##
InstallMethod( Indeterminates,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    local indets;
    
    indets := Indeterminates( UnderlyingNonGradedRing( S ) );
    
    return List( indets, x -> GradedRingElement( x, S ) );
    
end );

