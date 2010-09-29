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
                                      CoefficientsRing,
                                      BaseRing,
                                      KrullDimension
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
          "for homalg graded rings",
          [ IsHomalgGradedRingRep ],
          
    function( phi )
      
      return prop( UnderlyingNonGradedRing( phi ) );
      
  end );

end );

for GRADEDRING_prop in Concatenation( LIGrRNG.intrinsic_properties, LIGrRNG.intrinsic_attributes ) do
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

