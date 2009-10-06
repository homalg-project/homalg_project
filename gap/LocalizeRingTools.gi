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
                   local c;
                   
                   c := Cancel( Denominator( a ), Denominator( b ) );
                   
                   return HomalgLocalRingElement(
                                  Numerator( a ) * c[2]
                                  -Numerator( b ) * c[1],
                                  Denominator( a ) * c[2],
                                  HomalgRing( a ) );
                 end,
               
               #HomalgLocalRingElement will cancel here
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
                   
                   globalR := AssociatedComputationRing( R );
                   
                   return not IsZero( DecideZeroRows( HomalgMatrix ( [ Numerator( u ) ], 1, 1, globalR ), GeneratorsOfMaximalLeftIdeal( R ) ) );
                   
                 end,
               
               Sum :=
                 function( a, b )
                   local c;
                   
                   c := Cancel( Denominator( a ), Denominator( b ) );
                   
                   return HomalgLocalRingElement(
                                  Numerator( a ) * c[2]
                                  +Numerator( b ) * c[1],
                                  Denominator( a ) * c[2],
                                  HomalgRing( a ) );
                 end,
               
               #HomalgLocalRingElement will cancel here
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
                   
                   R := AssociatedComputationRing( C );
                   
                   return [ 
                     HomalgZeroMatrix( NrRows( C ), NrColumns( C ), R ),
                     One( R )
                   ];
                 end,
               
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := AssociatedComputationRing( C );
                   
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
                   local a, b, c;
                   
                   a := Eval( A );
                   b := Eval( B );
                   c := Cancel( a[2], b[2] );
                   
                   return [
                     UnionOfRows( c[2] * a[1], c[1] * b[1] ),
                     c[1] * b[2]
                   ];
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   local a, b, c;
                   
                   a := Eval( A );
                   b := Eval( B );
                   c := Cancel( a[2], b[2] );
                   
                   return [
                     UnionOfColumns( c[2] * a[1], c[1] * b[1] ),
                     c[1] * b[2]
                   ];
                 end,
               
               DiagMat :=
                 function( e )
                   local R, u, NumerList, A, a, c;
                   
                   R := HomalgRing( e[1] );
                   
                   u := One( AssociatedComputationRing ( R ) );
                   
                   NumerList := [ ];
                   
                   for A in e do
                       
                       a := Eval( A );
                       
                       #u/a[2]=c[1]/c[2] <=> u*c[2]=a[2]*c[1]
                       #NumerList/u and a[1]/a[2]
                       #     --->
                       #(c[2]*NumerList)/(c[2]*u) and 
                       #(c[1]*a[1])/(c[1]*a[2]) = (c[1]*a[1])/(c[2]*u)
                       
                       c := Cancel( u, a[2] );
                       
                       u := u * c[2];
                       
                       NumerList := c[2] * NumerList;
                       
                       Add( NumerList , c[1] * a[1] );
                       
                   od;
                   
                   return [ DiagMat( NumerList ), u ];
                   
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
                   local e, c;
                   
                   e := Eval( A );
                   c := Cancel( Numerator( a ), Denominator( a ) * e[2] );
                   
                   return [
                      c[1] * e[1],
                      c[2]
                     ];
                 end,
               
               AddMat :=
                 function( A, B )
                   local a, b, c;
                   
                   a := Eval( A );
                   b := Eval( B );
                   c := Cancel( a[2], b[2] );
                   
                   return [
                     c[2] * a[1] + c[1] * b[1],
                     c[1] * b[2]
                   ];
                 end,
               
               SubMat :=
                 function( A, B )
                   local a, b, c;
                   
                   a := Eval( A );
                   b := Eval( B );
                   c := Cancel( a[2], b[2] );
                   
                   return [
                     c[2] * a[1] - c[1] * b[1],
                     c[1] * b[2]
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
#                 local pos, f;
#                   f := function( a )
#                     if IsList(a) then
#                       return [a[2],a[1]];
#                     else 
#                       return a;
#                     fi;
#                   end;
#                   pos:=GetRowIndependentUnitPositions( Involution( M ), List( pos_list, f ) );
#                   if pos <> [ ] then
#                       SetIsZero( M, false );
#                   fi;
#                   return pos;
#                 end,
#                
#               GetRowIndependentUnitPositions :=
#                  function( M, pos_list )
#                  local rest, pos, j, l, k;
#                   rest := [ 1 .. NrRows( M ) ];
#                   pos := [ ];
#                   for j in [ 1 .. NrColumns( M ) ] do
#                     l := GetUnitPosition( CertainColumns( M, [ j ] ), List( Filtered( [ 1 .. NrRows( M ) ], a->not( a in rest )), b->[b,1] ) );
#                     if l <> fail then
#                       k := l[1];
#                       Add( pos, [ j, k ] );
#                       rest := Filtered( rest, a -> IsZero( GetEntryOfHomalgMatrix( M, a, j ) ) );
#                     fi;
#                       
#                   od;
#                   
#                   if pos <> [ ] then
#                       SetIsZero( M, false );
#                   fi;
#                   return pos;
#                  end,

               GetColumnIndependentUnitPositions :=
                 function( M, pos_list )
                   local pos, f;
                     
                   f := function( a )
                     if IsList(a) then
                       return [a[2],a[1]];
                     else 
                       return a;
                     fi;
                   end;
                   pos:=GetRowIndependentUnitPositions( Involution( M ), List( pos_list, f ) );
                   if pos <> [ ] then
                       SetIsZero( M, false );
                   fi;
                   return pos;
                   
                 end,
               
               GetRowIndependentUnitPositions :=
                 function( M, pos_list )
                   local rest, pos, j, l, k;
                   
                   rest := [ 1 .. NrRows( M ) ];
                   pos := [ ];
                   for j in [ 1 .. NrColumns( M ) ] do
                     l := GetUnitPosition( CertainColumns( M, [ j ] ), List( Filtered( [ 1 .. NrRows( M ) ], a->not( a in rest )), b->[b,1] ) );
                     if l <> fail then
                       k := l[1];
                       Add( pos, [ j, k ] );
                       rest := Filtered( rest, a -> IsZero( GetEntryOfHomalgMatrix( M, a, j ) ) );
                     fi;
                       
                   od;
                   
                   if pos <> [ ] then
                       SetIsZero( M, false );
                   fi;
                   return pos;
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                 local R, A, i, N, l;
                 
                   R:= AssociatedComputationRing( M );
                   Assert( 4, IsIdenticalObj( R, AssociatedGlobalRing( M ) ) );#should not be called by mora
                   
                   #our stuff
                   A := R * GeneratorsOfMaximalLeftIdeal( HomalgRing( M ) );
                   for i in [ 1 .. NrColumns( M ) ] do
                     if not i in pos_list then
                       N := CertainColumns( Numerator( M ) , [ i ] );
                       N := DecideZero( N, A );
                       l := GetUnitPosition( N, List( Filtered( pos_list, a->IsList(a) and a[2]=i ), b->[b[1],i] ));
                       if l <> fail then 
                         return [l[1],i];
                       fi;
                     fi;
                   od;
                     
                   return fail;
                   
                 end,
#                
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