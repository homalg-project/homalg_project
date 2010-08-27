#############################################################################
##
##  GradedRingTools.gi      GradedRingForHomalg package      Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##           Markus Lange-Hegermann, RWTH-Aachen University
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
            return GradedRingElement( UnderlyingNonGradedRingElement( a ) - UnderlyingNonGradedRingElement( b ), HomalgRing( a ) );
          end,
        
        DivideByUnit :=
          function( a, b )
            return GradedRingElement( UnderlyingNonGradedRingElement( a ) / UnderlyingNonGradedRingElement( b ), HomalgRing( a ) );
          end,
        
        IsUnit :=
          function( R, a )
            return IsUnit( UnderlyingNonGradedRing( R ), UnderlyingNonGradedRingElement( a ) );
          end,
        
        Sum :=
          function( a, b )
            return GradedRingElement( UnderlyingNonGradedRingElement( a ) + UnderlyingNonGradedRingElement( b ), HomalgRing( a ) );
          end,
        
        Product :=
          function( a, b )
            return GradedRingElement( UnderlyingNonGradedRingElement( a ) * UnderlyingNonGradedRingElement( b ), HomalgRing( a ) );
          end,
        
        ShallowCopy := C -> ShallowCopy( Eval( C ) ),
        
        InitialMatrix :=
          function( C )
            HomalgInitialMatrix( NrRows( C ), NrColumns( C ), UnderlyingNonGradedRing( C ) );
          end,
        
        InitialIdentityMatrix :=
          function( C )
            return HomalgInitialIdentityMatrix( NrRows( C ), UnderlyingNonGradedRing( HomalgRing( C ) ) );
          end,
        
        ZeroMatrix :=
          function( C )
            return HomalgZeroMatrix( NrRows( C ), UnderlyingNonGradedRing( HomalgRing( C ) ) );
          end,
        
        IdentityMatrix :=
          function( C )
            return HomalgIdentityMatrix( NrRows( C ), UnderlyingNonGradedRing( HomalgRing( C ) ) );
          end,
        
        AreEqualMatrices :=
          function( A, B )
            return UnderlyingNonGradedMatrix( A ) = UnderlyingNonGradedMatrix( B );
          end,
        
        Involution :=
          function( M )
            return GradedMatrix( Involution( UnderlyingNonGradedMatrix( M ) ), HomalgRing( M ) );
          end,
        
        CertainRows :=
          function( M, plist )
            return CertainRows( UnderlyingNonGradedMatrix( M ), plist );
          end,
        
        CertainColumns :=
          function( M, plist )
            return CertainColumns( UnderlyingNonGradedMatrix( M ), plist );
          end,
        
        UnionOfRows :=
          function( A, B )
            return UnionOfRows( UnderlyingNonGradedMatrix( A ), UnderlyingNonGradedMatrix( B ) );
          end,
        
        UnionOfColumns :=
          function( A, B )
            return UnionOfColumns( UnderlyingNonGradedMatrix( A ), UnderlyingNonGradedMatrix( B ) );
          end,
        
        DiagMat :=
          function( e )
            return DiagMat( List( e, UnderlyingNonGradedMatrix ) );
          end,
        
        KroneckerMat :=
          function( A, B )
            return KroneckerMat( UnderlyingNonGradedMatrix( A ), UnderlyingNonGradedMatrix( B ) );
          end,
        
        MulMat :=
          function( a, A )
            return UnderlyingNonGradedRingElement( a ) * UnderlyingNonGradedMatrix( A );
          end,
        
        AddMat :=
          function( A, B )
            return UnderlyingNonGradedMatrix( A ) + UnderlyingNonGradedMatrix( B );
          end,
        
        SubMat :=
          function( A, B )
            return UnderlyingNonGradedMatrix( A ) - UnderlyingNonGradedMatrix( B );
          end,
        
        Compose :=
          function( A, B )
            return UnderlyingNonGradedMatrix( A ) * UnderlyingNonGradedMatrix( B );
          end,
        
        NrRows := C -> NrRows( UnderlyingNonGradedMatrix( C ) ),
        
        NrColumns := C -> NrColumns( UnderlyingNonGradedMatrix( C ) ),
        
        IsZeroMatrix := M -> IsZero( UnderlyingNonGradedMatrix( M ) ),
        
        IsIdentityMatrix :=
          function( M )
            return IsOne( UnderlyingNonGradedMatrix( M ) );
          end,
        
        IsDiagonalMatrix := M -> IsDiagonalMatrix( UnderlyingNonGradedMatrix( M ) ),
        
        ZeroRows := C -> ZeroRows( UnderlyingNonGradedMatrix( C ) ),
        
        ZeroColumns := C -> ZeroColumns( UnderlyingNonGradedMatrix( C ) ),

        GetColumnIndependentUnitPositions :=
          function( M, pos_list )
            local pos;
            pos := GetColumnIndependentUnitPositions( UnderlyingNonGradedMatrix( M ), pos_list );
            if pos <> [ ] then
                SetIsZero( M, false );
            fi;
            return pos;
          end,
        
        GetRowIndependentUnitPositions :=
          function( M, pos_list )
            local pos;
            pos := GetRowIndependentUnitPositions( UnderlyingNonGradedMatrix( M ), pos_list );
            if pos <> [ ] then
                SetIsZero( M, false );
            fi;
            return pos;
          end,
        
        GetUnitPosition :=
          function( M, pos_list )
            return GetUnitPosition( UnderlyingNonGradedMatrix( M ), pos_list );
          end,
        
        DivideEntryByUnit :=
          function( M, i, j, u )
            return DivideEntryByUnit( UnderlyingNonGradedMatrix( M ), i, j, UnderlyingNonGradedRingElement( u ) );                   
          end,
        
  
        CopyRowToIdentityMatrix :=
          function( M, i, L, j )
            return CopyRowToIdentityMatrix( UnderlyingNonGradedMatrix( M ), i, UnderlyingNonGradedMatrix( L ), j );
            
          end,
        
        CopyColumnToIdentityMatrix :=
          function( M, j, L, i )
            return CopyColumnToIdentityMatrix( UnderlyingNonGradedMatrix( M ), j, UnderlyingNonGradedMatrix( L ), i );
          end,
        
        SetColumnToZero :=
          function( M, i, j )
            return SetColumnToZero( UnderlyingNonGradedMatrix( M ), i, j );
          end,
        
        GetCleanRowsPositions :=
          function( M, clean_columns )
            GetCleanRowsPositions(  UnderlyingNonGradedMatrix( M ), clean_columns );
          end,
        
     )
  );
