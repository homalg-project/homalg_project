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
          "NonTrivialDegreePerRow",
          "NonTrivialDegreePerColumn",
          ] );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethod( NrRows,
        IsMatrixOverGradedRing and HasNonTrivialDegreePerRow, 0,
        
  function( M )
    
    return Length( NonTrivialDegreePerRow( M ) );
    
end );

##
InstallImmediateMethod( NrColumns,
        IsMatrixOverGradedRing and HasNonTrivialDegreePerColumn, 0,
        
  function( M )
    
    return Length( NonTrivialDegreePerColumn( M ) );
    
end );

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
    local degs;
    
    degs := NonTrivialDegreePerRow( UnderlyingMatrixOverNonGradedRing( C ), HomalgRing( C ) );
    
    ## the properties below are now known for the underlying matrix
    NrRows( C );
    
    return degs;
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing, IsList ],
        
  function( C, col_degrees )
    local degs;
    
    degs := NonTrivialDegreePerRow( UnderlyingMatrixOverNonGradedRing( C ), HomalgRing( C ), col_degrees );
    
    ## the properties below are now known for the underlying matrix
    NrRows( C );
    
    return degs;
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( C )
    local degs;
    
    degs := NonTrivialDegreePerColumn( UnderlyingMatrixOverNonGradedRing( C ), HomalgRing( C ) );
    
    ## the properties below are now known for the underlying matrix
    NrColumns( C );
    
    return degs;
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing, IsList ],
        
  function( C, row_degrees )
    local degs;
    
    degs := NonTrivialDegreePerColumn( UnderlyingMatrixOverNonGradedRing( C ), HomalgRing( C ), row_degrees );
    
    ## the properties below are now known for the underlying matrix
    NrColumns( C );
    
    return degs;
    
end );
