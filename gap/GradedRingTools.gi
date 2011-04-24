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
            local c;
            c := UnderlyingNonGradedRingElement( a ) - UnderlyingNonGradedRingElement( b );
            if HasDegreeOfRingElement( a ) and not IsZero( c ) then
              GradedRingElement( c, DegreeOfRingElement( a ), HomalgRing( a ) );
            elif HasDegreeOfRingElement( b ) and not IsZero( c ) then
              GradedRingElement( c, DegreeOfRingElement( b ), HomalgRing( a ) );
            else
              return GradedRingElement( c, HomalgRing( a ) );
            fi;
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
            local c;
            c := UnderlyingNonGradedRingElement( a ) + UnderlyingNonGradedRingElement( b );
            if HasDegreeOfRingElement( a ) and not IsZero( c ) then
              GradedRingElement( c, DegreeOfRingElement( a ), HomalgRing( a ) );
            elif HasDegreeOfRingElement( b ) and not IsZero( c ) then
              GradedRingElement( c, DegreeOfRingElement( b ), HomalgRing( a ) );
            else
              return GradedRingElement( c, HomalgRing( a ) );
            fi;
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
            HomalgInitialMatrix( NrRows( C ), NrColumns( C ), UnderlyingNonGradedRing( C ) );
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
            return UnionOfRows( UnderlyingMatrixOverNonGradedRing( A ), UnderlyingMatrixOverNonGradedRing( B ) );
          end,
        
        UnionOfColumns :=
          function( A, B )
            return UnionOfColumns( UnderlyingMatrixOverNonGradedRing( A ), UnderlyingMatrixOverNonGradedRing( B ) );
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
        
        IsIdentityMatrix :=
          function( M )
            return IsOne( UnderlyingMatrixOverNonGradedRing( M ) );
          end,
        
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
            return GetCleanRowsPositions(  UnderlyingMatrixOverNonGradedRing( M ), clean_columns );
          end,
        
        Diff :=
          function( D, N )
            return Diff( UnderlyingMatrixOverNonGradedRing( D ), UnderlyingMatrixOverNonGradedRing( N ) );
          end,
          
        Eliminate :=
          function( rel, indets, S )
            local R, mat;
            
            R := UnderlyingNonGradedRing( S );
            mat := Eliminate( List( rel, UnderlyingNonGradedRingElement ), List( indets, UnderlyingNonGradedRingElement ) );
            return EntriesOfHomalgMatrix( mat );
            
          end,
        
     )
  );
