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

Add( HOMALG_MATRICES.matrix_logic_infolevels, InfoLIHMAT );

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
InstallImmediateMethodToPullPropertiesOrAttributes(
        IsHomalgMatrixOverGradedRingRep and HasEval,
        IsHomalgMatrixOverGradedRingRep,
        LIMAT.intrinsic_properties,
        Concatenation( LIHMAT.intrinsic_properties, LIHMAT.intrinsic_attributes ),
        UnderlyingMatrixOverNonGradedRing );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsHomalgMatrixOverGradedRingRep and HasEval,
        LIMAT.intrinsic_properties,
        UnderlyingMatrixOverNonGradedRing );

####################################
#
# methods for attributes:
#
####################################

##
InstallImmediateMethodToPullPropertiesOrAttributes(
        IsHomalgMatrixOverGradedRingRep and HasEval,
        IsHomalgMatrixOverGradedRingRep,
        LIMAT.intrinsic_attributes,
        Concatenation( LIHMAT.intrinsic_properties, LIHMAT.intrinsic_attributes ),
        UnderlyingMatrixOverNonGradedRing );

##
InstallImmediateMethodToPushPropertiesOrAttributes( Twitter,
        IsHomalgMatrixOverGradedRingRep and HasEval,
        LIMAT.intrinsic_attributes,
        UnderlyingMatrixOverNonGradedRing );

##
InstallMethod( DegreesOfEntries,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( C )
    
    return DegreesOfEntries( UnderlyingMatrixOverNonGradedRing( C ), HomalgRing( C ) );
    
end );

##
InstallMethod( NonZeroEntries,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( C )
    
    return NonZeroEntries( UnderlyingMatrixOverNonGradedRing( C )  );
    
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

####################################
#
# methods for operations:
#
####################################

#-----------------------------------
# SyzygiesGeneratorsOfRows
#-----------------------------------

##
InstallMethod( LinearSyzygiesGeneratorsOfRows,
        "LIHMAT: for homalg matrices (IsLeftRegular)",
        [ IsMatrixOverGradedRing and IsLeftRegular ],
        
  function( M )
    
    Info( InfoLIHMAT, 2, LIHMAT.color, "\033[01mLIHMAT\033[0m ", LIHMAT.color, "LinearSyzygiesGeneratorsOfRows( IsLeftRegular )", "\033[0m" );
    
    return HomalgZeroMatrix( 0, NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( LinearSyzygiesGeneratorsOfRows,
        "LIHMAT: for homalg matrices (IsZero)",
        [ IsMatrixOverGradedRing and IsZero ],
        
  function( M )
    
    Info( InfoLIHMAT, 2, LIHMAT.color, "\033[01mLIHMAT\033[0m ", LIHMAT.color, "LinearSyzygiesGeneratorsOfRows( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NrRows( M ), HomalgRing( M ) );
    
end );

#-----------------------------------
# SyzygiesGeneratorsOfColumns
#-----------------------------------

##
InstallMethod( LinearSyzygiesGeneratorsOfColumns,
        "LIHMAT: for homalg matrices (IsRightRegular)",
        [ IsMatrixOverGradedRing and IsRightRegular ],
        
  function( M )
    
    Info( InfoLIHMAT, 2, LIHMAT.color, "\033[01mLIHMAT\033[0m ", LIHMAT.color, "LinearSyzygiesGeneratorsOfColumns( IsRightRegular )", "\033[0m" );
    
    return HomalgZeroMatrix( NrColumns( M ), 0, HomalgRing( M ) );
    
end );

##
InstallMethod( LinearSyzygiesGeneratorsOfColumns,
        "LIHMAT: for homalg matrices (IsZero)",
        [ IsMatrixOverGradedRing and IsZero ],
        
  function( M )
    
    Info( InfoLIHMAT, 2, LIHMAT.color, "\033[01mLIHMAT\033[0m ", LIHMAT.color, "LinearSyzygiesGeneratorsOfColumns( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NrColumns( M ), HomalgRing( M ) );
    
end );
