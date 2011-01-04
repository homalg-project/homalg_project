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
            local c;
            c := UnderlyingNonGradedRingElement( a ) - UnderlyingNonGradedRingElement( b );
            if HasDegreeMultivariatePolynomial( a ) and not IsZero( c ) then
              GradedRingElement( c, DegreeMultivariatePolynomial( a ), HomalgRing( a ) );
            elif HasDegreeMultivariatePolynomial( b ) and not IsZero( c ) then
              GradedRingElement( c, DegreeMultivariatePolynomial( b ), HomalgRing( a ) );
            else
              return GradedRingElement( c, HomalgRing( a ) );
            fi;
          end,
        
        DivideByUnit :=
          function( a, b )
            if HasDegreeMultivariatePolynomial( a ) and HasDegreeMultivariatePolynomial( b ) then
              return GradedRingElement( UnderlyingNonGradedRingElement( a ) / UnderlyingNonGradedRingElement( b ), DegreeMultivariatePolynomial( a ) - DegreeMultivariatePolynomial( b ), HomalgRing( a ) );
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
            if HasDegreeMultivariatePolynomial( a ) and not IsZero( c ) then
              GradedRingElement( c, DegreeMultivariatePolynomial( a ), HomalgRing( a ) );
            elif HasDegreeMultivariatePolynomial( b ) and not IsZero( c ) then
              GradedRingElement( c, DegreeMultivariatePolynomial( b ), HomalgRing( a ) );
            else
              return GradedRingElement( c, HomalgRing( a ) );
            fi;
          end,
        
        Product :=
          function( a, b )
            if HasDegreeMultivariatePolynomial( a ) and HasDegreeMultivariatePolynomial( b ) then
              return GradedRingElement( UnderlyingNonGradedRingElement( a ) * UnderlyingNonGradedRingElement( b ), DegreeMultivariatePolynomial( a ) + DegreeMultivariatePolynomial( b ), HomalgRing( a ) );
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
            return UnderlyingNonHomogeneousMatrix( A ) = UnderlyingNonHomogeneousMatrix( B );
          end,
        
        Involution :=
          function( M )
            return Involution( UnderlyingNonHomogeneousMatrix( M ) );
          end,
        
        CertainRows :=
          function( M, plist )
            return CertainRows( UnderlyingNonHomogeneousMatrix( M ), plist );
          end,
        
        CertainColumns :=
          function( M, plist )
            return CertainColumns( UnderlyingNonHomogeneousMatrix( M ), plist );
          end,
        
        UnionOfRows :=
          function( A, B )
            return UnionOfRows( UnderlyingNonHomogeneousMatrix( A ), UnderlyingNonHomogeneousMatrix( B ) );
          end,
        
        UnionOfColumns :=
          function( A, B )
            return UnionOfColumns( UnderlyingNonHomogeneousMatrix( A ), UnderlyingNonHomogeneousMatrix( B ) );
          end,
        
        DiagMat :=
          function( e )
            return DiagMat( List( e, UnderlyingNonHomogeneousMatrix ) );
          end,
        
        KroneckerMat :=
          function( A, B )
            return KroneckerMat( UnderlyingNonHomogeneousMatrix( A ), UnderlyingNonHomogeneousMatrix( B ) );
          end,
        
        MulMat :=
          function( a, A )
            return UnderlyingNonGradedRingElement( a ) * UnderlyingNonHomogeneousMatrix( A );
          end,
        
        AddMat :=
          function( A, B )
            return UnderlyingNonHomogeneousMatrix( A ) + UnderlyingNonHomogeneousMatrix( B );
          end,
        
        SubMat :=
          function( A, B )
            return UnderlyingNonHomogeneousMatrix( A ) - UnderlyingNonHomogeneousMatrix( B );
          end,
        
        Compose :=
          function( A, B )
            return UnderlyingNonHomogeneousMatrix( A ) * UnderlyingNonHomogeneousMatrix( B );
          end,
        
        NrRows := C -> NrRows( UnderlyingNonHomogeneousMatrix( C ) ),
        
        NrColumns := C -> NrColumns( UnderlyingNonHomogeneousMatrix( C ) ),
        
        IsZeroMatrix := M -> IsZero( UnderlyingNonHomogeneousMatrix( M ) ),
        
        IsIdentityMatrix :=
          function( M )
            return IsOne( UnderlyingNonHomogeneousMatrix( M ) );
          end,
        
        IsDiagonalMatrix := M -> IsDiagonalMatrix( UnderlyingNonHomogeneousMatrix( M ) ),
        
        ZeroRows := C -> ZeroRows( UnderlyingNonHomogeneousMatrix( C ) ),
        
        ZeroColumns := C -> ZeroColumns( UnderlyingNonHomogeneousMatrix( C ) ),

        GetColumnIndependentUnitPositions :=
          function( M, pos_list )
            local pos;
            pos := GetColumnIndependentUnitPositions( UnderlyingNonHomogeneousMatrix( M ), pos_list );
            if pos <> [ ] then
                SetIsZero( M, false );
            fi;
            return pos;
          end,
        
        GetRowIndependentUnitPositions :=
          function( M, pos_list )
            local pos;
            pos := GetRowIndependentUnitPositions( UnderlyingNonHomogeneousMatrix( M ), pos_list );
            if pos <> [ ] then
                SetIsZero( M, false );
            fi;
            return pos;
          end,
        
        GetUnitPosition :=
          function( M, pos_list )
            return GetUnitPosition( UnderlyingNonHomogeneousMatrix( M ), pos_list );
          end,
        
        DivideEntryByUnit :=
          function( M, i, j, u )
            DivideEntryByUnit( UnderlyingNonHomogeneousMatrix( M ), i, j, UnderlyingNonGradedRingElement( u ) );
          end,
        
  
        CopyRowToIdentityMatrix :=
          function( M, i, L, j )
            local l;
            l := List( L, function( a ) if IsHomalgHomogeneousMatrixRep( a ) then return UnderlyingNonHomogeneousMatrix( a ); else return a; fi; end );
            CopyRowToIdentityMatrix( UnderlyingNonHomogeneousMatrix( M ), i, l, j );
          end,
        
        CopyColumnToIdentityMatrix :=
          function( M, j, L, i )
            return CopyColumnToIdentityMatrix( UnderlyingNonHomogeneousMatrix( M ), j, UnderlyingNonHomogeneousMatrix( L ), i );
          end,
        
        SetColumnToZero :=
          function( M, i, j )
            return SetColumnToZero( UnderlyingNonHomogeneousMatrix( M ), i, j );
          end,
        
        GetCleanRowsPositions :=
          function( M, clean_columns )
            return GetCleanRowsPositions(  UnderlyingNonHomogeneousMatrix( M ), clean_columns );
          end,
        
        Diff :=
          function( D, N )
            return Diff( UnderlyingNonHomogeneousMatrix( D ), UnderlyingNonHomogeneousMatrix( N ) );
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
