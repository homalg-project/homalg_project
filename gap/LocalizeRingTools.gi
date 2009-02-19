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
               IsZero := a -> IsZero( Numerator( a ) ),
               
               IsOne := a -> IsZero( Numerator( a ) - Denominator( a ) ),
               
               Minus :=
                 function( a, b )
                   return HomalgLocalRingElement(
                                  Numerator( a ) * Denominator( b )
                                  -Numerator( b ) * Denominator( a ),
                                  Denominator( a ) * Denominator( b ),
                                  HomalgRing( a ) );
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   return HomalgLocalRingElement(
                                  Numerator( a ) * Denominator( u ),
                                  Denominator( a ) * Numerator( u ),
                                  HomalgRing( a ) );
                 end,
               
               IsUnit :=
                 function( R, u )
                 local globalR;
                   
                   globalR := AssociatedGlobalRing( R );
                   
                   return not IsZero( DecideZeroRows( HomalgMatrix ( [ Numerator( u ) ], 1, 1, globalR ), GeneratorsOfMaximalLeftIdeal( R ) ) );
                   
                 end,
               
               Sum :=
                 function( a, b )
                   return HomalgLocalRingElement(
                                  Numerator( a ) * Denominator( b )
                                  +Numerator( b ) * Denominator( a ),
                                  Denominator( a ) * Denominator( b ),
                                  HomalgRing( a ) );
                 end,
               
               Product :=
                 function( a, b )
                   return HomalgLocalRingElement(
                                  Numerator( a ) * Numerator( b ),
                                  Denominator( a ) * Denominator( b ),
                                  HomalgRing( a ) );
                 end,
               
               ShallowCopy := C -> List( Eval( C ), ShallowCopy ),
               
               ZeroMatrix :=
                 function( C )
                   local R;
                   
                   R := AssociatedGlobalRing( C );
                   
                   return [ 
                     HomalgZeroMatrix( NrRows( C ), NrColumns( C ), R ),
                     One( R )
                   ];
                 end,
               
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := AssociatedGlobalRing( C );
                   
                   return [
                     HomalgIdentityMatrix( NrRows( C ), R ),
                     One( R )
                   ];
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   local a, b;
                   
                   a := Eval( A );
                   b := Eval( B );
                   
                   return IsZero( b[2] * a[1] - a[2] * b[1] );
                   
                 end,
               
               Involution :=
                 function( M )
                   local m;
                   
                   m := Eval( M );
                   
                   return [
                     Involution( m[1] ),
                     m[2]
                   ];
                 end,
               
               CertainRows :=
                 function( M, plist )
                   local m;
                   
                   m := Eval( M );
                   
                   return [
                     CertainRows( m[1], plist ),
                     m[2]
                   ];
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   local m;
                   
                   m := Eval( M );
                   
                   return [
                     CertainColumns( m[1], plist ),
                     m[2]
                   ];
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   local a, b;
                   
                   a := Eval( A );
                   b := Eval( B );
                   
                   return [
                     UnionOfRows( b[2] * a[1], a[2] * b[1] ),
                     a[2] * b[2]
                   ];
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   local a, b;
                   
                   a := Eval( A );
                   b := Eval( B );
                   
                   return [
                     UnionOfColumns( b[2] * a[1], a[2] * b[1] ),
                     a[2] * b[2]
                   ];
                 end,
               
               DiagMat :=
                 function( e )
                   local R, u, l, A, a;
                   
                   R := HomalgRing( e[1] );
                   
                   u := One( AssociatedGlobalRing ( R ) );
                   
                   l := [ ];
                   
                   for A in e do
                       
                       a := Eval( A );
                       
                       u := u * a[2];
                       
                       Add( l, a[1] );
                       
                   od;
                   
                   return [ DiagMat( l ), u ];
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   local a, b;
                   
                   a := Eval( A );
                   b := Eval( B );
                   
                   return [
                     KroneckerMat( a[1], b[1] ),
                     a[2] * b[2]
                   ];
                 end,
               
               MulMat :=
                 function( a, A )
                   local e;
                   
                   e := Eval( A );
                   
                   return [
                     Numerator( a ) * e[1],
                     Denominator( a ) * e[2]
                     ];
                 end,
               
               AddMat :=
                 function( A, B )
                   local a, b;
                   
                   a := Eval( A );
                   b := Eval( B );
                   
                   return [
                     b[2] * a[1] + a[2] * b[1],
                     a[2] * b[2]
                   ];
                 end,
               
               SubMat :=
                 function( A, B )
                   local a, b;
                   
                   a := Eval( A );
                   b := Eval( B );
                   
                   return [
                     b[2] * a[1] - a[2] * b[1],
                     a[2] * b[2]
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
               
               NrRows := C -> NrRows( Numerator( C ) ),
               
               NrColumns := C -> NrColumns( Numerator( C ) ),
               
               IsZeroMatrix := M -> IsZero( Numerator( M ) ),
               
#  -> fallback
#               IsIdentityMatrix :=
#                 function( M )
#                   
#                 end,
               
               IsDiagonalMatrix := M -> IsDiagonalMatrix( Numerator( M ) ),
               
               ZeroRows := C -> ZeroRows( Numerator( C ) ),
               
               ZeroColumns := C -> ZeroColumns( Numerator( C ) ),
               
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
