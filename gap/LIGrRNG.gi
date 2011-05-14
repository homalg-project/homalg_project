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

##
InstallImmediateMethod( IsZero,
        IsHomalgGradedRingElementRep and HasDegreeOfRingElement, 0,
        
  function( r )
    local zero;
    
    zero := Zero( r );
    
    if HasDegreeOfRingElement( zero ) and
       DegreeOfRingElement( r ) <> DegreeOfRingElement( zero ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsOne,
        IsHomalgGradedRingElementRep and HasDegreeOfRingElement, 0,
        
  function( r )
    local one;
    
    one := One( r );
    
    if HasDegreeOfRingElement( one ) and
       DegreeOfRingElement( r ) <> DegreeOfRingElement( one ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsMinusOne,
        IsHomalgGradedRingElementRep and HasDegreeOfRingElement, 0,
        
  function( r )
    local one;
    
    one := One( r );	## One( r ) is not a mistake
    
    if HasDegreeOfRingElement( one ) and
       DegreeOfRingElement( r ) <> DegreeOfRingElement( one ) then
        return false;
    fi;
    
    TryNextMethod( );
    
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
InstallMethod( DegreeOfRingElementFunction,
        "for homalg rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    return DegreeOfRingElementFunction(
                   UnderlyingNonGradedRing( S ),
                   WeightsOfIndeterminates( S )
                   );
    
end );

##
InstallMethod( DegreeOfRingElement,
        "for homalg rings elements",
        [ IsHomalgGradedRingElement ],
        
  function( r )
    
    return DegreeOfRingElementFunction( HomalgRing( r ) )( UnderlyingNonGradedRingElement( r ) );
    
end );

##
InstallMethod( DegreesOfEntriesFunction,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    return DegreesOfEntriesFunction(
                   UnderlyingNonGradedRing( S ),
                   WeightsOfIndeterminates( S )
                   );
    
end );

##
InstallMethod( NonTrivialDegreePerRowFunction,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    return NonTrivialDegreePerRowFunction(
                   UnderlyingNonGradedRing( S ),
                   WeightsOfIndeterminates( S ),
                   DegreeOfRingElement( Zero( S ) ),
                   DegreeOfRingElement( One( S ) )
                   );
    
end );

##
InstallMethod( NonTrivialDegreePerRowWithColDegreesFunction,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    return col_degrees ->
           NonTrivialDegreePerRowWithColDegreesFunction(
                   UnderlyingNonGradedRing( S ),
                   WeightsOfIndeterminates( S ),
                   DegreeOfRingElement( Zero( S ) ),
                   col_degrees
                   );
    
end );

##
InstallMethod( NonTrivialDegreePerColumnFunction,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    return NonTrivialDegreePerColumnFunction(
                   UnderlyingNonGradedRing( S ),
                   WeightsOfIndeterminates( S ),
                   DegreeOfRingElement( Zero( S ) ),
                   DegreeOfRingElement( One( S ) )
                   );
    
end );

##
InstallMethod( NonTrivialDegreePerColumnWithRowDegreesFunction,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    
    return row_degrees ->
           NonTrivialDegreePerColumnWithRowDegreesFunction(
                   UnderlyingNonGradedRing( S ),
                   WeightsOfIndeterminates( S ),
                   DegreeOfRingElement( Zero( S ) ),
                   row_degrees
                   );
    
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
