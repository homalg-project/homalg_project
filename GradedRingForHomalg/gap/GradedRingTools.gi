#############################################################################
##
##  GradedRingTools.gi      GradedRingForHomalg package
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##                  Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for graded rings.
##
#############################################################################

####################################
#
# global variables:
#
####################################

##
InstallValue( CommonHomalgTableForGradedRingsTools,
    
    rec(
        
        IsZero := a -> IsZero( UnderlyingNonGradedRingElement( a ) ),
        
        IsOne := a -> IsZero( UnderlyingNonGradedRingElement( a ) ),
        
        Minus :=
          function( a, b )
            ## there is really nothing we can/want say about the degree of the difference
            return GradedRingElement( UnderlyingNonGradedRingElement( a ) - UnderlyingNonGradedRingElement( b ), HomalgRing( a ) );
          end,
        
        DivideByUnit :=
          function( a, b )
            if HasDegreeOfRingElement( a ) and HasDegreeOfRingElement( b ) then
              return GradedRingElement( UnderlyingNonGradedRingElement( a ) / UnderlyingNonGradedRingElement( b ), DegreeOfRingElement( a ) - DegreeOfRingElement( b ), HomalgRing( a ) );
            else
              return GradedRingElement( UnderlyingNonGradedRingElement( a ) / UnderlyingNonGradedRingElement( b ), HomalgRing( a ) );
            fi;
          end,
        
        IsUnit :=
          function( R, a )
            return IsUnit( UnderlyingNonGradedRing( R ), UnderlyingNonGradedRingElement( a ) );
          end,
        
        Sum :=
          function( a, b )
            ## there is really nothing we can/want say about the degree of the sum
            return GradedRingElement( UnderlyingNonGradedRingElement( a ) + UnderlyingNonGradedRingElement( b ), HomalgRing( a ) );
          end,
        
        Product :=
          function( a, b )
            if HasDegreeOfRingElement( a ) and HasDegreeOfRingElement( b ) then
              return GradedRingElement( UnderlyingNonGradedRingElement( a ) * UnderlyingNonGradedRingElement( b ), DegreeOfRingElement( a ) + DegreeOfRingElement( b ), HomalgRing( a ) );
            else
              return GradedRingElement( UnderlyingNonGradedRingElement( a ) * UnderlyingNonGradedRingElement( b ), HomalgRing( a ) );
            fi;
          end,
        
        ShallowCopy := C -> ShallowCopy( Eval( C ) ),
        
        InitialMatrix :=
          function( C )
            return HomalgInitialMatrix( NrRows( C ), NrColumns( C ), UnderlyingNonGradedRing( C ) );
          end,
        
        InitialIdentityMatrix :=
          function( C )
            return HomalgInitialIdentityMatrix( NrRows( C ), UnderlyingNonGradedRing( HomalgRing( C ) ) );
          end,
        
        ZeroMatrix :=
          function( C )
            return HomalgZeroMatrix( NrRows( C ), NrColumns( C ), UnderlyingNonGradedRing( HomalgRing( C ) ) );
          end,
        
        IdentityMatrix :=
          function( C )
            return HomalgIdentityMatrix( NrRows( C ), UnderlyingNonGradedRing( HomalgRing( C ) ) );
          end,
        
        AreEqualMatrices :=
          function( A, B )
            return UnderlyingMatrixOverNonGradedRing( A ) = UnderlyingMatrixOverNonGradedRing( B );
          end,
        
        Involution :=
          function( M )
            return Involution( UnderlyingMatrixOverNonGradedRing( M ) );
          end,
        
        CertainRows :=
          function( M, plist )
            return CertainRows( UnderlyingMatrixOverNonGradedRing( M ), plist );
          end,
        
        CertainColumns :=
          function( M, plist )
            return CertainColumns( UnderlyingMatrixOverNonGradedRing( M ), plist );
          end,
        
        UnionOfRows :=
          function( A, B )
            return UnionOfRowsOp( UnderlyingMatrixOverNonGradedRing( A ), UnderlyingMatrixOverNonGradedRing( B ) );
          end,
        
        UnionOfColumns :=
          function( A, B )
            return UnionOfColumnsOp( UnderlyingMatrixOverNonGradedRing( A ), UnderlyingMatrixOverNonGradedRing( B ) );
          end,
        
        DiagMat :=
          function( e )
            return DiagMat( List( e, UnderlyingMatrixOverNonGradedRing ) );
          end,
        
        KroneckerMat :=
          function( A, B )
            return KroneckerMat( UnderlyingMatrixOverNonGradedRing( A ), UnderlyingMatrixOverNonGradedRing( B ) );
          end,
        
        MulMat :=
          function( a, A )
            return UnderlyingNonGradedRingElement( a ) * UnderlyingMatrixOverNonGradedRing( A );
          end,
        
        MulMatRight :=
          function( A, a )
            return UnderlyingMatrixOverNonGradedRing( A ) * UnderlyingNonGradedRingElement( a );
          end,
        
        AddMat :=
          function( A, B )
            return UnderlyingMatrixOverNonGradedRing( A ) + UnderlyingMatrixOverNonGradedRing( B );
          end,
        
        SubMat :=
          function( A, B )
            return UnderlyingMatrixOverNonGradedRing( A ) - UnderlyingMatrixOverNonGradedRing( B );
          end,
        
        Compose :=
          function( A, B )
            return UnderlyingMatrixOverNonGradedRing( A ) * UnderlyingMatrixOverNonGradedRing( B );
          end,
        
        NrRows := C -> NrRows( UnderlyingMatrixOverNonGradedRing( C ) ),
        
        NrColumns := C -> NrColumns( UnderlyingMatrixOverNonGradedRing( C ) ),
        
        IsZeroMatrix := M -> IsZero( UnderlyingMatrixOverNonGradedRing( M ) ),
        
        IsIdentityMatrix := M -> IsOne( UnderlyingMatrixOverNonGradedRing( M ) ),
        
        IsDiagonalMatrix := M -> IsDiagonalMatrix( UnderlyingMatrixOverNonGradedRing( M ) ),
        
        ZeroRows := C -> ZeroRows( UnderlyingMatrixOverNonGradedRing( C ) ),
        
        ZeroColumns := C -> ZeroColumns( UnderlyingMatrixOverNonGradedRing( C ) ),
        
        GetColumnIndependentUnitPositions :=
          function( M, pos_list )
            local pos;
            pos := GetColumnIndependentUnitPositions( UnderlyingMatrixOverNonGradedRing( M ), pos_list );
            if pos <> [ ] then
                SetIsZero( M, false );
            fi;
            return pos;
          end,
        
        GetRowIndependentUnitPositions :=
          function( M, pos_list )
            local pos;
            pos := GetRowIndependentUnitPositions( UnderlyingMatrixOverNonGradedRing( M ), pos_list );
            if pos <> [ ] then
                SetIsZero( M, false );
            fi;
            return pos;
          end,
        
        PositionOfFirstNonZeroEntryPerRow :=
          function( M )
            return PositionOfFirstNonZeroEntryPerRow( UnderlyingMatrixOverNonGradedRing( M ) );
          end,
        
        PositionOfFirstNonZeroEntryPerColumn :=
          function( M )
            return PositionOfFirstNonZeroEntryPerColumn( UnderlyingMatrixOverNonGradedRing( M ) );
          end,
        
        GetUnitPosition :=
          function( M, pos_list )
            return GetUnitPosition( UnderlyingMatrixOverNonGradedRing( M ), pos_list );
          end,
        
        DivideEntryByUnit :=
          function( M, i, j, u )
            DivideEntryByUnit( UnderlyingMatrixOverNonGradedRing( M ), i, j, UnderlyingNonGradedRingElement( u ) );
          end,
        
        CopyRowToIdentityMatrix :=
          function( M, i, L, j )
            local l;
            l := List( L, function( a ) if IsHomalgMatrixOverGradedRingRep( a ) then return UnderlyingMatrixOverNonGradedRing( a ); else return a; fi; end );
            CopyRowToIdentityMatrix( UnderlyingMatrixOverNonGradedRing( M ), i, l, j );
          end,
        
        CopyColumnToIdentityMatrix :=
          function( M, j, L, i )
            return CopyColumnToIdentityMatrix( UnderlyingMatrixOverNonGradedRing( M ), j, UnderlyingMatrixOverNonGradedRing( L ), i );
          end,
        
        SetColumnToZero :=
          function( M, i, j )
            return SetColumnToZero( UnderlyingMatrixOverNonGradedRing( M ), i, j );
          end,
        
        GetCleanRowsPositions :=
          function( M, clean_columns )
            return GetCleanRowsPositions( UnderlyingMatrixOverNonGradedRing( M ), clean_columns );
          end,
        
        Diff :=
          function( D, N )
            return MatrixOverGradedRing(
                           Diff( UnderlyingMatrixOverNonGradedRing( D ),
                                 UnderlyingMatrixOverNonGradedRing( N ) ),
                           HomalgRing( D ) );
          end,
        
        Eliminate :=
          function( rel, indets, S )
            local R, mat;
            
            R := UnderlyingNonGradedRing( S );
            if IsHomalgMatrix( rel ) then
                mat := Eliminate( UnderlyingMatrixOverNonGradedRing( rel ), List( indets, UnderlyingNonGradedRingElement ) );
            else
                mat := Eliminate( List( rel, UnderlyingNonGradedRingElement ), List( indets, UnderlyingNonGradedRingElement ) );
            fi;
            return EntriesOfHomalgMatrix( mat );
            
          end,
        
        Determinant :=
          function( M )
            local det;
            
            det := Determinant( UnderlyingMatrixOverNonGradedRing( M ) );
            
            return det / HomalgRing( M );
            
          end,
        
        Pullback :=
          function( phi, M )
            local S, T;
            
            if not IsBound( phi!.UnderlyingRingMap ) then
                S := UnderlyingNonGradedRing( Source( phi ) );
                T := UnderlyingNonGradedRing( Range( phi ) );
                phi!.UnderlyingRingMap := RingMap( ImagesOfRingMap( phi ), S, T );
            fi;
            
            M := UnderlyingMatrixOverNonGradedRing( M );
            
            return Pullback( phi!.UnderlyingRingMap, M );
            
          end,
        
     )
  );
