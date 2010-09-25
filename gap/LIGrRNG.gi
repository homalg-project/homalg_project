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
DeclareGlobalFunction( "InstallGradedRingPropertiesMethods" );
InstallGlobalFunction( InstallGradedRingPropertiesMethods, 
  function( prop );

  InstallImmediateMethod( prop,
          IsHomalgGradedRingRep, 0,
          
    function( phi )
    local U;
    
      U := UnderlyingNonGradedRing( phi );
      if Tester( prop )( U ) then
        return prop( U );
      else
        TryNextMethod();
      fi;
      
  end );
  
  InstallMethod( prop,
          "for homalg graded module maps",
          [ IsHomalgGradedRingRep ],
          
    function( phi )
      
      return prop( UnderlyingNonGradedRing( phi ) );
      
  end );

end );

for GRADEDRING_prop in [ 
     ContainsAField, IsRationalsForHomalg, IsFieldForHomalg, IsDivisionRingForHomalg, IsIntegersForHomalg, IsResidueClassRingOfTheIntegers, IsBezoutRing, IsIntegrallyClosedDomain, IsUniqueFactorizationDomain, IsKaplanskyHermite, IsDedekindDomain, IsDiscreteValuationRing, IsFreePolynomialRing, IsWeylRing, IsExteriorRing, IsGlobalDimensionFinite, IsLeftGlobalDimensionFinite, IsRightGlobalDimensionFinite, HasInvariantBasisProperty, HasLeftInvariantBasisProperty, HasRightInvariantBasisProperty, IsLocalRing, IsSemiLocalRing, IsIntegralDomain, IsHereditary, IsLeftHereditary, IsRightHereditary, IsHermite, IsLeftHermite, IsRightHermite, IsNoetherian, IsLeftNoetherian, IsRightNoetherian, IsArtinian, IsLeftArtinian, IsRightArtinian, IsOreDomain, IsLeftOreDomain, IsRightOreDomain, IsPrincipalIdealRing, IsLeftPrincipalIdealRing, IsRightPrincipalIdealRing, IsRegular, IsFiniteFreePresentationRing, IsLeftFiniteFreePresentationRing, IsRightFiniteFreePresentationRing, IsSimpleRing, IsSemiSimpleRing, BasisAlgorithmRespectsPrincipalIdeals
   ] do
  InstallGradedRingPropertiesMethods( GRADEDRING_prop );
od;
Unbind( GRADEDRING_prop );

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

