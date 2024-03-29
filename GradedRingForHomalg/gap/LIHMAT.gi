# SPDX-License-Identifier: GPL-2.0-or-later
# GradedRingForHomalg: Endow Commutative Rings with an Abelian Grading
#
# Implementations
#
# LIHMAT = Logical Implications for homalg Homogeneous MATrices

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
InstallImmediateMethod( NumberRows,
        IsMatrixOverGradedRing and HasNonTrivialDegreePerRow, 0,
        
  function( M )
    
    return Length( NonTrivialDegreePerRow( M ) );
    
end );

##
InstallImmediateMethod( NumberColumns,
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
InstallMethod( IndicatorMatrixOfNonZeroEntries,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( C )
    
    return IndicatorMatrixOfNonZeroEntries( UnderlyingMatrixOverNonGradedRing( C )  );
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( C )
    local degs;
    
    degs := NonTrivialDegreePerRow( UnderlyingMatrixOverNonGradedRing( C ), HomalgRing( C ) );
    
    ## the attributes below are now known for the underlying matrix
    PositionOfFirstNonZeroEntryPerRow( C );
    
    return degs;
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing, IsList ],
        
  function( C, col_degrees )
    local S, degs, col_pos, f;
    
    if Length( col_degrees ) <> NumberColumns( C ) then
        Error( "the number of entries in the list of column degrees does not match the number of columns of the matrix\n" );
    fi;
    
    if IsOne( C ) then
        return col_degrees;
    elif IsEmptyMatrix( C ) then
        S := HomalgRing( C );
        return ListWithIdenticalEntries( NumberRows( C ), DegreeOfRingElement( One( S ) ) ); ## One( S ) is not a mistake
    elif IsZero( C ) then
        return ListWithIdenticalEntries( NumberRows( C ), col_degrees[1] ); ## this is not a mistake
    fi;
    
    degs := NonTrivialDegreePerRow( C );
    
    col_pos := PositionOfFirstNonZeroEntryPerRow( C );
    
    f := function( i )
           local c;
           
           c := col_pos[i];
           if c = 0 then
               return col_degrees[1];
           else
               return degs[i] + col_degrees[c];
           fi;
       end;
    
    return List( [ 1 .. NumberRows( C ) ], f );
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( C )
    local degs;
    
    degs := NonTrivialDegreePerColumn( UnderlyingMatrixOverNonGradedRing( C ), HomalgRing( C ) );
    
    ## the attributes below are now known for the underlying matrix
    PositionOfFirstNonZeroEntryPerColumn( C );
    
    return degs;
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing, IsList ],
        
  function( C, row_degrees )
    local S, degs, row_pos, f;
    
    if Length( row_degrees ) <> NumberRows( C ) then
        Error( "the number of entries in the list of row degrees does not match the number of rows of the matrix\n" );
    fi;
    
    if IsOne( C ) then
        return row_degrees;
    elif IsEmptyMatrix( C ) then
        S := HomalgRing( C );
        return ListWithIdenticalEntries( NumberColumns( C ), DegreeOfRingElement( One( S ) ) ); ## One( S ) is not a mistake
    elif IsZero( C ) then
        return ListWithIdenticalEntries( NumberColumns( C ), row_degrees[1] ); ## this is not a mistake
    fi;
    
    degs := NonTrivialDegreePerColumn( C );
    
    row_pos := PositionOfFirstNonZeroEntryPerColumn( C );
    
    f := function( j )
           local r;
           
           r := row_pos[j];
           if r = 0 then
               return row_degrees[1];
           else
               return degs[j] + row_degrees[r];
           fi;
       end;
    
    return List( [ 1 .. NumberColumns( C ) ], f );
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfRows, IsHomalgGradedRing, IsList ],
        
  function( C, S, row_degrees )
    local eval;
    
    Info( InfoLIHMAT, 2, LIHMAT.color, "\033[01mLIHMAT\033[0m ", LIHMAT.color, "NonTrivialDegreePerRow(HasEvalUnionOfRows)", "\033[0m" );
    
    eval := EvalUnionOfRows( C );
    
    return Concatenation( List( eval, e -> NonTrivialDegreePerRow( e, S, row_degrees ) ) );
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfColumns, IsHomalgGradedRing, IsList ],
        
  function( C, S, col_degrees )
    local eval;
    
    Info( InfoLIHMAT, 2, LIHMAT.color, "\033[01mLIHMAT\033[0m ", LIHMAT.color, "NonTrivialDegreePerColumn(HasEvalUnionOfColumns)", "\033[0m" );
    
    eval := EvalUnionOfColumns( C );
    
    return Concatenation( List( eval, e -> NonTrivialDegreePerColumn( e, S, col_degrees ) ) );
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices",
        [ IsHomalgMatrix and HasIsEmpty, IsHomalgGradedRing, IsList ],100,
        
  function( C, S, col_degrees )
    
    return [];
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for homalg matrices",
        [ IsHomalgMatrix and HasIsEmpty, IsHomalgGradedRing, IsList ],100,
        
  function( C, S, col_degrees )
    
    return [];
    
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
    
    return HomalgZeroMatrix( 0, NumberRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( LinearSyzygiesGeneratorsOfRows,
        "LIHMAT: for homalg matrices (IsZero)",
        [ IsMatrixOverGradedRing and IsZero ],
        
  function( M )
    
    Info( InfoLIHMAT, 2, LIHMAT.color, "\033[01mLIHMAT\033[0m ", LIHMAT.color, "LinearSyzygiesGeneratorsOfRows( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NumberRows( M ), HomalgRing( M ) );
    
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
    
    return HomalgZeroMatrix( NumberColumns( M ), 0, HomalgRing( M ) );
    
end );

##
InstallMethod( LinearSyzygiesGeneratorsOfColumns,
        "LIHMAT: for homalg matrices (IsZero)",
        [ IsMatrixOverGradedRing and IsZero ],
        
  function( M )
    
    Info( InfoLIHMAT, 2, LIHMAT.color, "\033[01mLIHMAT\033[0m ", LIHMAT.color, "LinearSyzygiesGeneratorsOfColumns( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NumberColumns( M ), HomalgRing( M ) );
    
end );
