# SPDX-License-Identifier: GPL-2.0-or-later
# LocalizeRingForHomalg: A Package for Localization of Polynomial Rings
#
# Implementations
#

##  Implementations for localized rings.

####################################
#
# global variables:
#
####################################

#possibility to use the underlying global ringtable?

InstallValue( CommonHomalgTableForLocalizedRingsAtPrimeIdealsTools,

    rec(
               IsZero := a -> IsZero( EvalRingElement( a ) ),
               
               IsOne := a -> IsOne( EvalRingElement( a ) ),
               
               Minus :=
                 function( a, b )
                   
                   return EvalRingElement( a ) - EvalRingElement( b );
                   
                 end,
               
               #HomalgLocalRingElement will cancel here
               DivideByUnit :=
                 function( a, u )
                   return EvalRingElement( a ) / EvalRingElement( u );
                 end,
                   
               DegreeOfRingElement :=
                 function( r, R )
                     
                     return Degree( Numerator( r ) / AssociatedComputationRing( R ) );
                     
                 end,
                   
               IsUnit :=
                 function( R, u )
                     local uu;
                     
                     if Degree ( u ) > 0 then
                         return false;
                     fi;
                     
                     # RP := homalgTable( R );

                     # if not IsBound(RP!.Numerator) then
                     #     Error( "Table entry for Numerator not found\n" );
                     # fi;
                     
                     uu := Numerator( u ) / AssociatedComputationRing( R );
                     
                     ## Use DecideZero(u, matrix)
                     if DecideZero( uu, BasisOfColumns( GeneratorsOfPrimeIdeal( R ) ) ) <> 0 then
                         return true;
                     fi;
                     
                     return false;
                     
                 end,
               
               Sum :=
                 function( a, b )
                   
                   return EvalRingElement( a ) + EvalRingElement( b );
                   
                 end,
               
               #HomalgLocalRingElement will cancel here
               Product :=
                 function( a, b )
                   
                   return EvalRingElement( a ) * EvalRingElement( b );
                   
                 end,
               
               ShallowCopy := C -> ShallowCopy( Eval( C ) ),
               
               InitialMatrix :=
                 function( C )
                   local R;
                   
                   R := AssociatedComputationRing( C );
                   
                   return HomalgInitialMatrix( NumberRows( C ), NumberColumns( C ), R );
                 end,
               
               InitialIdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := AssociatedComputationRing( C );
                   
                   return HomalgInitialIdentityMatrix( NumberRows( C ), R );
                 end,
               
               ZeroMatrix :=
                 function( C )
                   local R;
                   
                   R := AssociatedComputationRing( C );
                   
                   return HomalgZeroMatrix( NumberRows( C ), NumberColumns( C ), R );
                 end,
               
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := AssociatedComputationRing( C );
                   
                   return HomalgIdentityMatrix( NumberRows( C ), R );
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return Eval( A ) = Eval( B );
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return Involution( Eval( M ) );
                 end,
               
               CertainRows :=
                 function( M, plist )
                   
                   return CertainRows( Eval( M ), plist );
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   return CertainColumns( Eval( M ), plist );
                 end,
               
               UnionOfRows :=
                 function( L )
                   
                   return UnionOfRows( List( L, Eval ) );
                 end,
               
               UnionOfColumns :=
                 function( L )
                   
                   return UnionOfColumns( List( L, Eval ) );
                 end,
               
               DiagMat :=
                 function( e )
                   
                   return DiagMat( List( e, EvalRingElement ) );
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   
                   return KroneckerMat( Eval( A ), Eval( B ) );
                 end,
               
               DualKroneckerMat :=
                 function( A, B )
                   
                   return DualKroneckerMat( Eval( A ), Eval( B ) );
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return EvalRingElement( a ) * Eval( A );
                 end,
               
               AddMat :=
                 function( A, B )
                   
                   return Eval( A ) + Eval( B );
                 end,
               
               SubMat :=
                 function( A, B )
                   
                   return Eval( A ) - Eval( B );
                 end,
               
               Compose :=
                 function( A, B )
                   
                   return Eval( A ) * Eval( B );
                 end,
               
               NumberRows := C -> NumberRows( Eval( C ) ),
               
               NumberColumns := C -> NumberColumns( Eval( C ) ),
               
               IsZeroMatrix := M -> IsZero( Eval( M ) ),
                                        
               IsDiagonalMatrix := M -> IsDiagonalMatrix( Eval( M ) ),
               
               ZeroRows := C -> ZeroRows( Eval( C ) ),
               
               ZeroColumns := C -> ZeroColumns( Eval( C ) ),
               
               CoefficientsOfUnivariatePolynomial :=
                 function( p, y )
                   local R, coef;
                   
                   R := HomalgRing( p );
                   
                   if not Indeterminates( R ) = [ y ] then
                       Error( "the ring is not a univariate polynomial ring over a base ring\n" );
                   fi;
                   
                   return CoefficientsOfUnivariatePolynomial( EvalRingElement( p ), EvalRingElement( y ) );

                 end,
               
    )
 );
