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
            intrinsic_properties := LIRNG.intrinsic_properties,
            intrinsic_attributes := [
                                     "BaseRing",
                                     "KrullDimension",
                                     "Characteristic"
                                     ],
            ringelement_attributes := [
                                       RationalParameters,
                                       IndeterminateCoordinatesOfRingOfDerivations,
                                       IndeterminateDerivationsOfRingOfDerivations,
                                       IndeterminateAntiCommutingVariablesOfExteriorRing,
                                       IndeterminateAntiCommutingVariablesOfExteriorRing,
                                       IndeterminatesOfExteriorRing,
                                       IndeterminatesOfPolynomialRing
                                       ]
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
# immediate methods for properties:
#
####################################

##
InstallMethodToPullPropertiesOrAttributes(
        IsHomalgGradedRingRep, IsHomalgGradedRingRep,
        LIGrRNG.intrinsic_properties,
        UnderlyingNonGradedRing );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallMethodToPullPropertiesOrAttributes(
        IsHomalgGradedRingRep, IsHomalgGradedRingRep,
        LIGrRNG.intrinsic_attributes,
        UnderlyingNonGradedRing );

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
for GRADEDRING_prop in LIGrRNG.ringelement_attributes do

  InstallMethod( GRADEDRING_prop,
          "for homalg graded rings",
          [ IsHomalgGradedRingRep ],
          
    function( S )
      local indets;
      
      indets := GRADEDRING_prop( UnderlyingNonGradedRing( S ) );
      
      return List( indets, x -> GradedRingElement( x, S ) );
      
  end );
  
od;
Unbind( GRADEDRING_prop );

##
InstallMethod( Indeterminates,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    local indets;
    
    indets := Indeterminates( UnderlyingNonGradedRing( S ) );
    
    return List( indets, x -> GradedRingElement( x, S ) );
    
end );

##
InstallMethod( MaximalIdealAsColumnMatrix,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    local var;
    
    var := Indeterminates( S );
    
    return HomalgMatrix( var, Length( var ), 1, S );
    
end );

##
InstallMethod( MaximalIdealAsRowMatrix,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    local var;
    
    var := Indeterminates( S );
    
    return HomalgMatrix( var, 1, Length( var ), S );
    
end );