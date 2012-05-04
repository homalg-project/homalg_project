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

##
Append( LIGrRNG.intrinsic_properties,
        [ 
          ] );

##
Append( LIGrRNG.intrinsic_attributes,
        [ 
          ] );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethodToPullPropertiesOrAttributes(
        IsHomalgGradedRingRep,
        IsHomalgGradedRingRep,
        LIGrRNG.intrinsic_properties,
        Concatenation( LIGrRNG.intrinsic_properties, LIGrRNG.intrinsic_attributes ),
        UnderlyingNonGradedRing );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethodToPullPropertiesOrAttributes(
        IsHomalgGradedRingRep,
        IsHomalgGradedRingRep,
        LIGrRNG.intrinsic_attributes,
        Concatenation( LIGrRNG.intrinsic_properties, LIGrRNG.intrinsic_attributes ),
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
InstallGlobalFunction( HelperToInstallMethodsForGradedRingElementsAttributes,
  function( L )
    local GRADEDRING_prop;
    
    for GRADEDRING_prop in L do
        
        InstallMethod( GRADEDRING_prop,
                "for homalg graded rings",
                [ IsHomalgGradedRingRep ],
                
          function( S )
            local indets;
            
            indets := GRADEDRING_prop( UnderlyingNonGradedRing( S ) );
            
            return List( indets, x -> GradedRingElement( x, S ) );
            
        end );
        
    od;
    
end );

## invoke it
HelperToInstallMethodsForGradedRingElementsAttributes( LIGrRNG.ringelement_attributes );

##
InstallMethod( Zero,
        "for homalg graded rings",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return GradedRingElement( Zero( UnderlyingNonGradedRing( S ) ), S );
    
end );

##
InstallMethod( DegreeOfRingElementFunction,
        "for homalg rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    local weights, degree_group, ring, zero;
    
    weights := WeightsOfIndeterminates( S );
    
    degree_group := DegreeGroup( S );
    
    ring := UnderlyingNonGradedRing( S );
    
    if NrGenerators( degree_group ) > 1 then
        
        return function( elm )
            local degreeofelem, degreehelpfunction;
            
            if IsBound( S!.DegreeOfRingElement_degreehelpfunction )
              and S!.DegreeOfRingElement_pos_of_presentation = PositionOfTheDefaultSetOfGenerators( degree_group ) then
                
                degreehelpfunction := S!.DegreeOfRingElement_degreehelpfunction;
                
            else
                
                degreehelpfunction := DegreeOfRingElementFunction(
                                            ring,
                                            MatrixOfWeightsOfIndeterminates( S )
                                            );
                
                S!.DegreeOfRingElement_degreehelpfunction := degreehelpfunction;
                
                S!.DegreeOfRingElement_pos_of_presentation := PositionOfTheDefaultSetOfGenerators( degree_group );
                
            fi;
            
            degreeofelem := degreehelpfunction( elm );
            degreeofelem := HomalgModuleElement( degreeofelem, degree_group );
            return degreeofelem;
        end;
        
    fi;
    
    zero := TheZeroElement( degree_group );
    
    return function( elm )
        local degrees, degreeofelem, degreehelpfunction;
        
        if IsBound( S!.DegreeOfRingElement_degreehelpfunction )
              and S!.DegreeOfRingElement_pos_of_presentation = PositionOfTheDefaultSetOfGenerators( degree_group ) then
                
                degreehelpfunction := S!.DegreeOfRingElement_degreehelpfunction;
                
                degrees := S!.DegreeOfRingElement_degrees;
                
            else
                
                degrees := List( weights, UnderlyingListOfRingElements );
                
                if Length( degrees ) > 0 then
                    
                    if Length( degrees[1] ) = 1 then
                        
                        degrees := Flat( degrees );
                        
                    fi;
                    
                fi;
                
                S!.DegreeOfRingElement_degrees := degrees;
                
                degreehelpfunction := DegreeOfRingElementFunction(
                        ring,
                        degrees
                        );
                
                S!.DegreeOfRingElement_degreehelpfunction := degreehelpfunction;
                
                S!.DegreeOfRingElement_pos_of_presentation := PositionOfTheDefaultSetOfGenerators( degree_group );
                
            fi;
        
        degreeofelem := degreehelpfunction( elm );
        
        if NrGenerators( degree_group ) > 0 then
            return HomalgModuleElement( [ degreeofelem ], degree_group );
        else
            return zero;
        fi;
        
    end;
    
end );

##
InstallMethod( DegreeOfRingElementFunction,
               "for ambient rings",
               [ IsHomalgGradedRing and HasAmbientRing ],
               
  function( ring )
    
    return DegreeOfRingElementFunction( AmbientRing( ring ) );
    
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
    local A, ring, i, j, zero, weights;
    
    A := DegreeGroup( S );
    
    ring := UnderlyingNonGradedRing( S );
    
    if NrGenerators( A ) > 1 then
        
        return function( mat )
          local degree_help_function;
            
            if IsBound( S!.DegreesOfEntries_degreehelpfunction )
              and S!.DegreesOfEntries_pos_of_presentation = PositionOfTheDefaultSetOfGenerators( A ) then
                
                degree_help_function := S!.DegreesOfEntries_degreehelpfunction;
                
            else
                
                degree_help_function := DegreesOfEntriesFunction(
                                            ring,
                                            MatrixOfWeightsOfIndeterminates( S )
                                            );
                
                S!.DegreesOfEntries_degreehelpfunction := degree_help_function;
                
                S!.DegreesOfEntries_pos_of_presentation := PositionOfTheDefaultSetOfGenerators( A );
                
            fi;
            
            return
              List(
                degree_help_function( mat ),
                  j -> List( j, i -> HomalgModuleElement( [ i ], A ) ) );
              
          end;
          
    fi;
    
    zero := TheZeroElement( A );
    
    weights := WeightsOfIndeterminates( S );
    
    return function( mat )
      local degrees, degree_help_function;
        
        if IsBound( S!.DegreesOfEntries_degreehelpfunction )
          and S!.DegreesOfEntries_pos_of_presentation = PositionOfTheDefaultSetOfGenerators( A ) then
            
            degree_help_function := S!.DegreesOfEntries_degreehelpfunction;
            
            degrees := S!.DegreesOfEntries_degrees;
            
        else
            
            degrees := List( weights, UnderlyingListOfRingElements );
            
            if Length( degrees ) > 0 and Length( degrees[1] ) = 1 then
                
                degrees := Flat( degrees );
                
            fi;
            
            S!.DegreesOfEntries_degrees := degrees;
          
            degree_help_function := DegreesOfEntriesFunction(
                                        ring,
                                        degrees
                                        );
            
            S!.DegreesOfEntries_degreehelpfunction := degree_help_function;
            
            S!.DegreesOfEntries_pos_of_presentation := PositionOfTheDefaultSetOfGenerators( A );
            
        fi;
        
        if NrGenerators( A ) > 0 then
            return List( degree_help_function( mat ), j -> List( j, i -> HomalgModuleElement( [ i ], A ) ) );
        else
            return ListWithIdenticalEntries( NrColumns( mat ), ListWithIdenticalEntries( NrRows( mat ), zero ) );
        fi;
        
      end;
    
end );

##
InstallMethod( NonTrivialDegreePerRowWithColPositionFunction,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    local degree_of_one, degree_of_zero, degree_group, ring, zero, weights;
    
    degree_of_one := DegreeOfRingElement( One( S ) );
    
    degree_of_zero := DegreeOfRingElement( Zero( S ) );
    
    degree_group := DegreeGroup( S );
    
    ring := UnderlyingNonGradedRing( S );
    
    zero := TheZeroElement( degree_group );
    
    weights := WeightsOfIndeterminates( S );
    
    return function( mat )
      local degrees, degree_help_function;
        
        if IsBound( S!.NonTrivialDegreePerRowWithColPositionFunction_degreehelpfunction )
          and S!.NonTrivialDegreePerRowWithColPositionFunction_pos_of_presentation = PositionOfTheDefaultSetOfGenerators( degree_group ) then
            
            degree_help_function := S!.NonTrivialDegreePerRowWithColPositionFunction_degreehelpfunction;
            
            degrees := S!.NonTrivialDegreePerRowWithColPositionFunction_degrees;
            
        else
            
            degrees := List( weights, UnderlyingListOfRingElements );
            
            if Length( degrees ) > 0 and Length( degrees[1] ) = 1 then
                
                degrees := Flat( degrees );
                
            fi;
            
            S!.NonTrivialDegreePerRowWithColPositionFunction_degrees := degrees;
            
            degree_help_function :=
              NonTrivialDegreePerRowWithColPositionFunction(
                        ring,
                        degrees,
                        UnderlyingListOfRingElements( degree_of_zero ),
                        UnderlyingListOfRingElements( degree_of_one )
                        );
            
            S!.NonTrivialDegreePerRowWithColPositionFunction_degreehelpfunction := degree_help_function;
            
            S!.NonTrivialDegreePerRowWithColPositionFunction_pos_of_presentation := PositionOfTheDefaultSetOfGenerators( degree_group );
            
        fi;
        
        if NrGenerators( degree_group ) > 0 then
            return
              List(
                degree_help_function( mat ),
                  j -> HomalgModuleElement( [ j ], degree_group ) );
        else
            return ListWithIdenticalEntries( NrRows( mat ), zero );
        fi;
        
    end;
    
end );

##
InstallMethod( NonTrivialDegreePerColumnWithRowPositionFunction,
        "for homalg graded rings",
        [ IsHomalgGradedRing ],
        
  function( S )
    local degree_of_one, degree_of_zero, degree_group, ring, zero, weights;
    
    degree_of_one := DegreeOfRingElement( One( S ) );
    
    degree_of_zero := DegreeOfRingElement( Zero( S ) );
    
    degree_group := DegreeGroup( S );
    
    ring := UnderlyingNonGradedRing( S );
    
    zero := TheZeroElement( degree_group );
    
    weights := WeightsOfIndeterminates( S );
    
    return function( mat )
      local degrees, generators_of_degree_group, degree_help_function;
        
        if IsBound( S!.NonTrivialDegreePerColumnWithRowPositionFunction_degreehelpfunction )
          and S!.NonTrivialDegreePerColumnWithRowPositionFunction_pos_of_presentation = PositionOfTheDefaultSetOfGenerators( degree_group ) then
            
            degree_help_function := S!.NonTrivialDegreePerColumnWithRowPositionFunction_degreehelpfunction;
            
            degrees := S!.NonTrivialDegreePerColumnWithRowPositionFunction_degrees;
            
        else
            
            degrees := List( weights, UnderlyingListOfRingElements );
            
            if Length( degrees ) > 0 and Length( degrees[1] ) = 1 then
                
                degrees := Flat( degrees );
                
            fi;
            
            S!.NonTrivialDegreePerColumnWithRowPositionFunction_degrees := degrees;
            
            degree_help_function :=
              NonTrivialDegreePerColumnWithRowPositionFunction(
                        ring,
                        degrees,
                        UnderlyingListOfRingElements( degree_of_zero ),
                        UnderlyingListOfRingElements( degree_of_one )
                        );
            
            S!.NonTrivialDegreePerColumnWithRowPositionFunction_degreehelpfunction := degree_help_function;
            
            S!.NonTrivialDegreePerColumnWithRowPositionFunction_pos_of_presentation := PositionOfTheDefaultSetOfGenerators( degree_group );
            
        fi;
        
        if NrGenerators( degree_group ) > 0 then
            return
              List(
                degree_help_function( mat ),
                  j -> HomalgModuleElement( [ j ], degree_group ) );
        else
            return ListWithIdenticalEntries( NrColumns( mat ), zero );
        fi;
        
    end;
    
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
