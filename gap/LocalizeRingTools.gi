#############################################################################
##
##  LocalizeRingTools.gd   LocalizeRingForHomalg package     Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for localized rings.
##
#############################################################################

####################################
#
# global variables:
#
####################################

#possibility to use the underlying global ringtable?

InstallValue( CommonHomalgTableForLocalizedRingsTools,

    rec(
               IsZero := a -> IsZero(NumeratorOfLocalElement(a)),
               
               IsOne := a -> IsZero(NumeratorOfLocalElement(a)-DenominatorOfLocalElement(a)),
               
               Minus :=
                 function( a, b )
                   return HomalgLocalRingElement(
                                  NumeratorOfLocalElement(a)*DenominatorOfLocalElement(b)
                                  -NumeratorOfLocalElement(b)*DenominatorOfLocalElement(a),
                                  DenominatorOfLocalElement(a)*DenominatorOfLocalElement(b),
                                  HomalgRing(a));
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   return HomalgLocalRingElement(
                                  NumeratorOfLocalElement(a)*DenominatorOfLocalElement(u),
                                  DenominatorOfLocalElement(a)*NumeratorOfLocalElement(u),
                                  HomalgRing(a));
                 end,
               
               IsUnit :=
                 function( R, u )
                 local globalR;
                   
                   globalR := AssociatedGlobalRing( R );
                   
                   return IsZero( DecideZeroRows( HomalgMatrix ( NumeratorOfLocalElement(u) , 1 , 1 , globalR ) , GeneratorsOfMaximalLeftIdeal( R ) ) );
                   
                 end,
               
               Sum :=
                 function( a, b )
                   return HomalgLocalRingElement(
                                  NumeratorOfLocalElement(a)*DenominatorOfLocalElement(b)
                                  +NumeratorOfLocalElement(b)*DenominatorOfLocalElement(a),
                                  DenominatorOfLocalElement(a)*DenominatorOfLocalElement(b),
                                  HomalgRing(a));
                 end,
               
               Product :=
                 function( a, b )
                   return HomalgLocalRingElement(
                                  NumeratorOfLocalElement(a)*NumeratorOfLocalElement(b),
                                  DenominatorOfLocalElement(a)*DenominatorOfLocalElement(b),
                                  HomalgRing(a));
                 end,
               
               ShallowCopy := C -> List( Eval( C ), ShallowCopy ),
               
               ZeroMatrix :=
                 function( C )
                   local R;
                   
                   R := AssociatedGlobalRing( C );
                   
                   return [ 
                     One( R ),
                     HomalgZeroMatrix( NrRows( C ), NrColumns( C ), R )
                   ];
                 end,
               
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := AssociatedGlobalRing( C );
                   
                   return [
                     One( R ),
                     HomalgIdentityMatrix( NrRows( C ), R ),
                   ];
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   local a, b;
                   
                   a := Eval( A );
                   b := Eval( B );
                   
                   return IsZero( b[1] * a[2] - a[1] * b[2] );
                   
                 end,
               
               Involution :=
                 function( M )
                   local m;
                   
                   m := Eval( M );
                   
                   return [
                     m[1],
                     Involution( m[2] )
                   ];
                 end,
               
               CertainRows :=
                 function( M, plist )
                   local m;
                   
                   m := Eval( M );
                   
                   return [
                     m[1],
                     CertainRows( m[2], plist )
                   ];
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   local m;
                   
                   m := Eval( M );
                   
                   return [
                     m[1],
                     CertainColumns( m[2], plist )
                   ];
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   local a, b;
                   
                   a := Eval( A );
                   b := Eval( B );
                   
                   return [
                     a[1] * b[1],
                     UnionOfRows( b[1] * a[2], a[1] * b[2] )
                   ];
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   local a, b;
                   
                   a := Eval( A );
                   b := Eval( B );
                   
                   return [
                     a[1] * b[1],
                     UnionOfColumns( b[1] * a[2], a[1] * b[2] )
                   ];
                 end,
               
                 DiagMat :=
                   function( e )
                     local R, u, l, A;
                     
                     R := HomalgRing( e[1] );
                     
                     u := One( AssociatedGlobalRing (R ) );
                     
                     l := [];
                     
                     for A in e do
                     
                       u := u * Eval(A)[1];
                       
                       Add( l , Eval(A)[2] );
                       
                     od;
                     
                     return [ u , DiagMat( l ) ];
                     
                   end,
               
               KroneckerMat :=
                 function( A, B )
                   local a, b;
                   
                   a := Eval( A );
                   b := Eval( B );
                   
                   return [
                     a[1] * b[1],
                     KroneckerMat( a[2], b[2] )
                   ];
                 end,
               
               MulMat :=
                 function( a, A )
                   local e;
                   
                   e := Eval( A );
                   
                   return [
                     DenominatorOfLocalElement(a) * e[1],
                     NumeratorOfLocalElement(a) * e[2]
                     ];
                 end,
               
               AddMat :=
                 function( A, B )
                   local a, b;
                   
                   a := Eval( A );
                   b := Eval( B );
                   
                   return [
                     a[1] * b[1],
                     b[1] * a[2] + a[1] * b[2]
                   ];
                 end,
               
               SubMat :=
                 function( A, B )
                   local a, b;
                   
                   a := Eval( A );
                   b := Eval( B );
                   
                   return [
                     a[1] * b[1],
                     b[1] * a[2] - a[1] * b[2]
                   ];
                 end,
               
               Compose :=
                 function( A, B )
                   local a, b;
                   
                   a := Eval( A );
                   b := Eval( B );
                   
                   return [
                     a[1] * b[1],
                     a[2] * b[2]
                   ];
                 end,
               
               NrRows := C -> NrRows( Eval( C )[2] ),
               
               NrColumns := C -> NrColumns( Eval( C )[2] ),
               
               IsZeroMatrix := M -> IsZero( Eval( M )[2] ),
               
#  -> fallback
#               IsIdentityMatrix :=
#                 function( M )
#                   
#                 end,
               
               IsDiagonalMatrix := M -> IsDiagonalMatrix( Eval( M )[2] ),
               
               ZeroRows := C -> ZeroRows( Eval( C )[2] ),
               
               ZeroColumns := C -> ZeroColumns( Eval( C )[2] ),
               
#               GetColumnIndependentUnitPositions :=
#                 function( M, pos_list )
#                   
#                 end,
               
#               GetRowIndependentUnitPositions :=
#                  function( M, pos_list )
#                    
#                    
#                  end,
               
#                GetUnitPosition :=
#                  function( M, pos_list )
#                    
#                    
#                  end,
               
#                DivideEntryByUnit :=
#                  function( M, i, j, u )
#                    
#                    
#                  end,
               
         
#                CopyRowToIdentityMatrix :=
#                  function( M, i, L, j )
#                    
#                    
#                  end,
               
#                CopyColumnToIdentityMatrix :=
#                  function( M, j, L, i )
#                    
#                    
#                  end,
               
#                SetColumnToZero :=
#                  function( M, i, j )
#                    
#                    
#                  end,
               
#                GetCleanRowsPositions :=
#                  function( M, clean_columns )
#                    
#                    
#                  end,
    )
 );
