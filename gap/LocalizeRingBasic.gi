#############################################################################
##
##  LocalizeRingBasic.gi     LocalizeRingBasic package       Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementation stuff for LocalizeRingForHomalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForLocalizedRingsBasic,
        
        rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               BasisOfRowModule :=
                 function( M )

                   return HomalgLocalMatrix( BasisOfRowModule( Numerator( M ) ), HomalgRing( M ) );
                   
                 end,
               
               BasisOfColumnModule :=
                 function( M )
                   
                   return HomalgLocalMatrix( BasisOfColumnModule( Numerator( M ) ), HomalgRing( M ) );
                   
                 end,
               
               BasisOfRowsCoeff :=
                 function( M, T )
                   local R, ComputationRing, TT, result;
                   
                   R := HomalgRing( M );
                   
                   ComputationRing := AssociatedComputationRing( R );
                   
                   SetEval( T, [ Denominator( M ) * HomalgIdentityMatrix( NrRows( M ), ComputationRing ), One( globalR ) ] );
                   
                   TT := HomalgVoidMatrix( ComputationRing );
                   
                   result := HomalgLocalMatrix( BasisOfRowModuleCoeff( Numerator( M ) , TT ), R );
                   
                   #stimmt die reihenfolge? benutze den hook der basisbestimung...
                   T := T * TT;
                   
                   return result;
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, T )
                   local R, ComputationRing, TT, result;
                   
                   R := HomalgRing( M );
                   
                   ComputationRing := AssociatedComputationRing( R );
                   
                   SetEval( T, [ Denominator( M ) * HomalgIdentityMatrix( NrColumns( M ), ComputationRing ), One( globalR ) ] );
                   
                   TT := HomalgVoidMatrix( ComputationRing );
                   
                   result := HomalgLocalMatrix( BasisOfColumnModuleCoeff( Numerator( M ), TT ), R );
                   
                   #stimmt die reihenfolge? benutze den hook der basisbestimung...
                   T := T * TT;
                   
                   return result;
                   
                 end,
               
               DecideZeroRows :=
                 function( A, B )

                   return DecideZeroRows( Numerator( A ) , Numerator( B ) );

                 end,
               
               DecideZeroColumns :=
                 function( A, B )
                   
                   return DecideZeroColumns( Numerator( A ) , Numerator( B ) );
                   
                 end,
               
               DecideZeroRowsEffectively :=
                 function( A, B, T )
                   local result;
                   
                   result := DecideZeroRowsEffectively( Numerator( A ) , Numerator ( B ) );
                   
                   return result;
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ "list l=DecideZeroColumnsEffectively(", A, B, "); matrix ", N, " = l[1]; matrix ", T, " = l[2]" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   return N;
                   
                 end,
               
               
               SyzygiesGeneratorsOfRows :=
                 function( arg )
                   local M, R, M2, M3, N;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   if Length( arg ) > 1 and IsHomalgMatrix( arg[2] ) then
                       
                       M2 := arg[2];
                       
                       M3 := UnionOfRows( M, M2 );
                       
                       M := CertainRows( M3, [ 1 .. NrRows( M ) ] );
                       
                       M2 := CertainRows( M3, [ NrRows( M ) + 1 .. NrRows( M3 ) ] );
                       
                       N := SyzygiesGeneratorsOfRows( Numerator( M ), Numerator( M2 ) );
                       
                   else
                       
                       N := SyzygiesGeneratorsOfRows( Numerator( M ) );
                       
                   fi;
                   
                   return HomalgLocalMatrix( N, R );
                   
                 end,
               
               SyzygiesGeneratorsOfColumns :=
                 function( arg )
                   local M, R, M2, M3, N;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   if Length( arg ) > 1 and IsHomalgMatrix( arg[2] ) then
                       
                       M2 := arg[2];
                       
                       M3 := UnionOfColumns( M, M2 );
                       
                       M := CertainColumns( M3, [ 1 .. NrColumns( M ) ] );
                       
                       M2 := CertainColumns( M3, [ NrColumns( M ) + 1 .. NrColumns( M3 ) ] );
                       
                       N := SyzygiesGeneratorsOfColumns( Numerator( M ), Numerator( M2 ) );
                       
                   else
                       
                       N := SyzygiesGeneratorsOfColumns( Numerator( M ) );
                       
                   fi;
                   
                   return HomalgLocalMatrix( N, R );
                   
                 end,
               
        )
 );

InstallValue( HomalgTableReductionMethodsForLocalizedRingsBasic,
        
        rec(
        
               DecideZeroRows :=
                 function( A, B )
                   local R, T, m, gens, n, GlobalR, one, N, a, numA, denA, i, A1, B1, A2, B2, A3;
                   
                   R := HomalgRing( A );
                   
                   T := HomalgVoidMatrix( R );
                   
                   m := NrRows( B );
                   
                   gens := GeneratorsOfMaximalLeftIdeal( R );
                   
                   n := NrRows( gens );
                   
                   GlobalR := AssociatedComputationRing( R );
                   
                   one := One( GlobalR );
                   
                   N := HomalgZeroMatrix( 0, NrColumns( A ), R );
                   
                   a := Eval( A );
                   
                   numA := a[1];
                   denA := a[2];
                   
                   B1 := Numerator( B );
                   
                   for i in [ 1 .. NrRows( A ) ] do
                   
                       A1 := CertainRows( numA, [ i ] );
                           
                       A2 := HomalgLocalMatrix( DecideZeroRows( A1, B1 ), R );
                       
                       if not IsZero( A2 ) then
                       
                         B2 := UnionOfRows( B1, gens * A1 );
                       
                         B2 := BasisOfRows( B2 );
                       
                         A3 := HomalgLocalMatrix( DecideZeroRows( A1, B2 ), R );
                         
                         if IsZero( A3 ) then
                         
                           A2 := A3;
                           
                         fi;
                       
                       fi;
                       
                       N := UnionOfRows( N, A2 );
                       
                   od;
                   
                   N := HomalgRingElement( One( GlobalR ), denA, R ) * N;
                   
                   return N;
                   
                 end,
               
               DecideZeroColumns :=
                 function( A, B )
                   local R, T, m, gens, n, GlobalR, one, N, a, numA, denA, i, A1, B1, A2, B2, A3;
                   
                   R := HomalgRing( A );
                   
                   T := HomalgVoidMatrix( R );
                   
                   m := NrColumns( B );
                   
                   gens := GeneratorsOfMaximalRightIdeal( R );
                   
                   n := NrColumns( gens );
                   
                   GlobalR := AssociatedComputationRing( R );
                   
                   one := One( GlobalR );
                   
                   N := HomalgZeroMatrix( NrRows( A ), 0, R );
                   
                   a := Eval( A );
                   
                   numA := a[1];
                   denA := a[2];
                   
                   B1 := Numerator( B );
                   
                   for i in [ 1 .. NrColumns( A ) ] do
                   
                       A1 := CertainColumns( numA, [ i ] );
                           
                       A2 := HomalgLocalMatrix( DecideZeroColumns( A1, B1 ), R );
                       
                       if not IsZero( A2 ) then
                         
                         B2 := UnionOfColumns( B1, A1 * gens );
                         
                         B2 := BasisOfColumns( B2 );
                         
                         A3 := HomalgLocalMatrix( DecideZeroColumns( A1, B2 ), R );
                         
                         if IsZero( A3 ) then
                         
                           A2 := A3;
                         
                         fi;
                       
                       fi;
                       
                       N := UnionOfColumns( N, A2 );
                       
                   od;
                   
                   N := HomalgRingElement( One( GlobalR ), denA, R ) * N;
                   
                   return N;
                   
                 end,
               
               DecideZeroRowsEffectively :=
                 function( A, B, T )
                   local R, m, gens, n, GlobalR, one, N, TT, a, numA, denA, b, numB, denB, i, A1, B1, A2, B2, S, S1, u, SS, A3;
                   
                   R := HomalgRing( A );
                   
                   m := NrRows( B );
                   
                   gens := GeneratorsOfMaximalLeftIdeal( R );
                   
                   n := NrRows( gens );
                   
                   GlobalR := AssociatedComputationRing( R );
                   
                   one := One( GlobalR );
                   
                   N := HomalgZeroMatrix( 0, NrColumns( A ), R );
                   
                   TT := HomalgZeroMatrix( 0, m, R );
                   
                   a := Eval( A );

                   numA := a[1];
                   denA := a[2];
                   
                   b := Eval( B );
                   
                   numB := b[1];
                   denB := b[2];
                   
                   for i in [ 1 .. NrRows( A ) ] do
                   
                       A1 := CertainRows( numA, [ i ] );
                       
                       B1 := numB;
                       
                       S1 := HomalgVoidMatrix( GlobalR );
                       
                       A2 := HomalgLocalMatrix( DecideZeroRowsEffectively( A1, B1, S1 ), R );
                       
                       if not IsZero( A2 ) then
                       
                         B2 := UnionOfRows( B1, gens * A1 );
                         
                         SS := HomalgVoidMatrix( GlobalR );
                         
                         B2 := BasisOfRowsCoeff( B2, SS );
                         
                         S := HomalgVoidMatrix( GlobalR );
                         
                         A3 := HomalgLocalMatrix( DecideZeroRowsEffectively( A1, B2, S ), R );
                         
                         if IsZero( A3) then
                         
                           S := S * SS;
                           
                           u := CertainColumns( S, [ m + 1 .. n + m ] ) * gens;
                           
                           u := GetEntryOfHomalgMatrix( u, 1, 1, GlobalR );
                           
                           IsZero( u );
                           
                           u := one + u;
                           
                           S := HomalgLocalMatrix( CertainColumns( S, [ 1 .. m ] ), u, R );
                           
                           A2 := HomalgRingElement( one , u , R ) * A3;
                           
                         fi;
                       
                       else
                         
                         S := HomalgLocalMatrix( S1 , one , R );
                       
                       fi;
                       
                       TT := UnionOfRows( TT, S );
                       
                       N := UnionOfRows( N, A2 );
                       
                       Assert( 5, S * HomalgLocalMatrix( B1, R ) + HomalgLocalMatrix( A1, R ) = A2 );
                       
                   od;
                   
                   TT := HomalgRingElement( denB, denA, R ) * TT;
                   
                   if HasEvalUnionOfRows( TT ) then
                       SetEvalUnionOfRows( T, EvalUnionOfRows( TT ) );
                   elif HasEvalMulMat( TT ) then
                       SetEvalMulMat( T, EvalMulMat( TT ) );
                   else
                       SetEval( T, Eval( TT ) );
                   fi;
                   
                   N := HomalgRingElement( one , denA , R ) * N;
                   
                   return N;
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local R, m, gens, n, GlobalR, one, N, TT, a, numA, denA, b, numB, denB, i, A1, B1, A2, B2, S, S1, u, SS, A3;
                   
                   R := HomalgRing( A );
                   
                   m := NrColumns( B );
                   
                   gens := GeneratorsOfMaximalRightIdeal( R );
                   
                   n := NrColumns( gens );
                   
                   GlobalR := AssociatedComputationRing( R );
                   
                   one := One( GlobalR );
                   
                   N := HomalgZeroMatrix( NrRows( A ), 0, R );
                   
                   TT := HomalgZeroMatrix( m, 0, R );
                  
                   a := Eval( A );
                   
                   numA := a[1];
                   denA := a[2];
                   
                   b := Eval( B );
                   
                   numB := b[1];
                   denB := b[2];
                   
                   for i in [ 1 .. NrColumns( A ) ] do
                   
                       A1 := CertainColumns( numA, [ i ] );
                       
                       B1 := numB;
                       
                       S1 := HomalgVoidMatrix( GlobalR );
                       
                       A2 := HomalgLocalMatrix( DecideZeroColumnsEffectively( A1, B1, S1 ), R );
                       
                       if not IsZero( A2 ) then
                         
                         B2 := UnionOfColumns( B1, A1 * gens );
                         
                         SS := HomalgVoidMatrix( GlobalR );
                         
                         B2 := BasisOfColumnsCoeff( B2, SS );
                         
                         S := HomalgVoidMatrix( GlobalR );
                         
                         A3 := HomalgLocalMatrix( DecideZeroColumnsEffectively( A1, B2, S ), R );
                         
                         if IsZero( A3 ) then
                         
                           S := SS * S;
                          
                           u := gens * CertainRows( S, [ m + 1 .. n + m ] );
                           
                           u := GetEntryOfHomalgMatrix( u, 1, 1, GlobalR );
                           
                           IsZero( u );
                           
                           u := one + u;
                           
                           S := HomalgLocalMatrix( CertainRows( S, [ 1 .. m ] ), u, R );
                           
                           A2 := HomalgRingElement( one, u, R ) * A3;
                         
                         else
                         
                           S := HomalgVoidMatrix( GlobalR );
                           
                           A2 := HomalgLocalMatrix( DecideZeroColumnsEffectively( A1 , B1 , S ) , one , R );
                           
                           S := HomalgLocalMatrix( S , one , R );
                         
                         fi;
                         
                       else
                         
                         S := HomalgLocalMatrix( S1 , one , R );
                       
                       fi;
                       
                       TT := UnionOfColumns( TT, S );
                       
                       N := UnionOfColumns( N, A2 );
                       
                       Assert( 5, HomalgLocalMatrix( B1, R ) * S + HomalgLocalMatrix( A1, R ) = A2 );
                       
                   od;
                   
                   TT := HomalgRingElement( denB, denA, R ) * TT;
                   
                   if HasEvalUnionOfColumns( TT ) then
                       SetEvalUnionOfColumns( T, EvalUnionOfColumns( TT ) );
                   elif HasEvalMulMat( TT ) then
                       SetEvalMulMat( T, EvalMulMat( TT ) );
                   else
                       SetEval( T, Eval( TT ) );
                   fi;
                  
                   N := HomalgRingElement( one , denA , R ) * N;
                  
                   return N;
                   
                 end,
               
        )
 );