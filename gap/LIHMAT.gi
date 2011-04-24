#############################################################################
##
##  LIHMAT.gdi                 LIHMAT subpackage           Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##         LIHMAT = Logical Implications for homalg Homogeneous MATrices
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for the LIHMAT subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIHMAT,
        rec(
            color := "\033[4;30;46m",
            intrinsic_properties := LIMAT.intrinsic_properties,
            intrinsic_attributes := LIMAT.intrinsic_attributes,
            )
        );

Append( LIHMAT.intrinsic_properties,
        [ 
          ] );

Append( LIHMAT.intrinsic_attributes,
        [ 
          "DegreesOfEntries",
          ] );

####################################
#
# methods for properties:
#
####################################

##
InstallMethodToPullPropertiesOrAttributes(
        IsHomalgMatrixOverGradedRingRep and HasEval, IsHomalgMatrixOverGradedRingRep,
        LIMAT.intrinsic_properties,
        UnderlyingMatrixOverNonGradedRing );

##
InstallImmediateMethodToTwitterPropertiesOrAttributes(
        Twitter, IsHomalgMatrixOverGradedRingRep and HasEval, LIMAT.intrinsic_properties, UnderlyingMatrixOverNonGradedRing );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethodToPullPropertiesOrAttributes(
        IsHomalgMatrixOverGradedRingRep and HasEval, IsHomalgMatrixOverGradedRingRep,
        LIMAT.intrinsic_attributes,
        UnderlyingMatrixOverNonGradedRing );

##
InstallImmediateMethodToTwitterPropertiesOrAttributes(
        Twitter, IsHomalgMatrixOverGradedRingRep and HasEval, LIMAT.intrinsic_attributes, UnderlyingMatrixOverNonGradedRing );

##
InstallMethod( DegreesOfEntries,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( C )
    
    return DegreesOfEntries( UnderlyingMatrixOverNonGradedRing( C ), HomalgRing( C ) );
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( C )
    
    return NonTrivialDegreePerRow( UnderlyingMatrixOverNonGradedRing( C ), HomalgRing( C ) );
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing, IsList ],
        
  function( C, col_degrees )
    
    return NonTrivialDegreePerRow( UnderlyingMatrixOverNonGradedRing( C ), HomalgRing( C ), col_degrees );
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( C )
    
    return NonTrivialDegreePerColumn( UnderlyingMatrixOverNonGradedRing( C ), HomalgRing( C ) );
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing, IsList ],
        
  function( C, row_degrees )
    
    return NonTrivialDegreePerColumn( UnderlyingMatrixOverNonGradedRing( C ), HomalgRing( C ), row_degrees );
    
end );
