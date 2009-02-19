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

                   return HomalgLocalMatrix( Eval( M )[2], HomalgRing( M ) );
                   
                 end,
               
               BasisOfColumnModule :=
                 function( M )
                   
                   return HomalgLocalMatrix( Eval( M )[2], HomalgRing( M ) );
                   
                 end,
               
               BasisOfRowsCoeff :=
                 function( M, T )
                   local R, globalR, m;
                   
                   R := HomalgRing( M );
                   
                   globalR := AssociatedGlobalRing( R );
                   
                   m := Eval( M );
                   
                   SetEval( T, [ One( globalR ), m[1] * HomalgIdentityMatrix( NrRows( M ), globalR ) ] );
                   
                   return HomalgLocalMatrix( m[2], R );
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, T )
                   local R, globalR, m;
                   
                   R := HomalgRing( M );
                   
                   globalR := AssociatedGlobalRing( R );
                   
                   m := Eval( M );
                   
                   SetEval( T, [ One( globalR ), m[1] * HomalgIdentityMatrix( NrColumns( M ), globalR ) ] );
                   
                   return HomalgLocalMatrix( m[2], R );
                   
                 end,
               
#                DecideZeroRows :=
#                  function( A, B )
#                    local R, N, i, ClearDenomMatrix, A2, B2;
#                    
#                    R := HomalgRing( A );
#                    
#                    N := HomalgVoidMatrix( 0, NrColumns( A ), R );
#                    
#                    for i in [ 1 .. NrRows( A ) ] do
#                        
#                        ClearDenomMatrix := Eval( UnionOfRows( CertainRows( A, [ i ] ), B ) )[2];
#                        
#                        A2 := CertainRows( ClearDenomMatrix, [ 1 ] );
#                        
#                        B2 := CertainRows( ClearDenomMatrix, [ 2 .. NrRows( ClearDenomMatrix ) ] );
#                        
#                        B2 := UnionOfRows( B2, GeneratorsOfMaximalLeftIdeal( R ) * A2 );
#                        
#                        B2 := BasisOfRowModule( B2 );
#                        
#                        A2 := HomalgLocalMatrix( DecideZeroRows( A2, B2 ), R );
#                        
#                        N := UnionOfRows( N, A2 );
#                        
#                    od;
#                    
#                    return N;
#                    
#                  end,
               
                DecideZeroRows :=
                  function( A, B )
                  
                    return DecideZeroRowsEffectively( A , B , HomalgVoidMatrix( HomalgRing( A ) ) );
                  
                  end,
               
                DecideZeroColumns :=
                  function( A, B )
                  
                    return DecideZeroColumnsEffectively( A , B , HomalgVoidMatrix( HomalgRing( A ) ) );
                  
                  end,
               
               
#                DecideZeroColumns :=
#                  function( A, B )
#                    local R, N, i, ClearDenomMatrix, A2, B2;
#                    
#                    R := HomalgRing( A );
#                    
#                    N := HomalgVoidMatrix( NrRows( A ), 0, R );
#                    
#                    for i in [ 1 .. NrColumns( A ) ] do
#                        
#                        ClearDenomMatrix := Eval( UnionOfColumns( CertainColumns( A, [ i ] ), B ) )[2];
#                        
#                        A2 := CertainColumns( ClearDenomMatrix, [ 1 ] );
#                        
#                        B2 := CertainColumns( ClearDenomMatrix, [ 2 .. NrColumns( ClearDenomMatrix ) ] );
#                        
#                        B2 := UnionOfColumns( B2, A2 * GeneratorsOfMaximalRightIdeal( R ) );
#                        
#                        B2 := BasisOfColumnModule( B2 );
#                        
#                        A2 := HomalgLocalMatrix( DecideZeroColumns( A2, B2 ), R );
#                        
#                        N := UnionOfColumns( N, A2 );
#                        
#                    od;
#                    
#                    return N;
#                    
#                  end,
               
               DecideZeroRowsEffectively :=
                 function( A, B, T )
                   local R, m, gens, n, GlobalR, one, N, TT, denA, denB, i, A1, B1, A2, B2, S, u, SS;
                   
                   R := HomalgRing( A );
                   
                   m := NrRows( B );
                   
                   gens := GeneratorsOfMaximalLeftIdeal( R );
                   
                   n := NrRows( gens );
                   
                   GlobalR := AssociatedGlobalRing( R );
                   
                   one := One( GlobalR );
                   
                   N := HomalgZeroMatrix( 0, NrColumns( A ), R );
                   
                   TT := HomalgZeroMatrix( 0, m, R );
                   
                   denA := Eval( A )[1];
                   
                   denB := Eval( B )[1];
                   
                   for i in [ 1 .. NrRows( A ) ] do
                   
                       A1 := CertainRows( Eval( A )[2] , [ i ] );
                       
                       B1 := Eval( B )[2];
                       
                       B2 := UnionOfRows( B1, gens * A1 );
                       
                       SS := HomalgVoidMatrix( GlobalR );
                       
                       B2 := BasisOfRowsCoeff( B2, SS );
                       
                       S := HomalgVoidMatrix( 1, NrRows( B2 ), GlobalR );
                       
                       A2 := HomalgLocalMatrix( DecideZeroRowsEffectively( A1, B2, S ), R );
                       
                       S := S * SS;
                       
                       u := CertainColumns( S, [ m + 1 .. n + m ] ) * gens;
                       
                       IsZero( u );
                       
                       u := one + GetEntryOfHomalgMatrix( u, 1, 1, GlobalR );
                       
                       S := HomalgLocalMatrix( CertainColumns( S, [ 1 .. m ] ), u , R );
                       
                       TT := UnionOfRows( TT, S );
                       
                       A2 := HomalgRingElement( One( GlobalR ) , u , R ) * A2;
                       
                       N := UnionOfRows( N, A2 );
                       
                       Assert( 4, S*HomalgLocalMatrix(B1,R)+HomalgLocalMatrix(A1,R) = A2 );
                       
                   od;
                   
                   if HasEvalUnionOfRows( TT ) then
                       SetEvalUnionOfRows( T, EvalUnionOfRows( TT ) );
                   else
                       SetEval( T, Eval( TT ) );
                   fi;
                   
                   N := HomalgRingElement( One( GlobalR ) , denA , R ) * N;
                   
                   T := HomalgRingElement( denB , denA , R ) * T;
                   
                   Assert( 4, N = A + T * B );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local R, m, gens, n, GlobalR, one, N, TT, denA, denB, i, A1, B1, A2, B2, S, u, SS;
                   
                   R := HomalgRing( A );
                   
                   n := NrColumns( B );
                   
                   gens := GeneratorsOfMaximalRightIdeal( R );
                   
                   m := NrColumns( gens );
                   
                   GlobalR := AssociatedGlobalRing( R );
                   
                   one := One( GlobalR );
                   
                   N := HomalgZeroMatrix( NrRows( A ), 0, R );
                   
                   TT := HomalgZeroMatrix( n, 0, R );
                  
                   denA := Eval( A )[1];
                  
                   denB := Eval( B )[1];
                   
                   for i in [ 1 .. NrColumns( A ) ] do
                   
                       A1 := CertainColumns( Eval( A )[2] , [ i ] );
                       
                       B1 := Eval( B )[2];
                       
                       B2 := UnionOfColumns( B1, A1 * gens );
                       
                       SS := HomalgVoidMatrix( GlobalR );
                       
                       B2 := BasisOfColumnsCoeff( B2, SS );
                       
                       S := HomalgVoidMatrix( NrColumns( B2 ), 1, GlobalR );
                       
                       A2 := HomalgLocalMatrix( DecideZeroColumnsEffectively( A1, B2, S ), R );
                       
                       S := SS * S;
                      
                       u := gens * CertainRows( S, [ n + 1 .. n + m ] );
                       
                       IsZero( u );
                       
                       u := one + GetEntryOfHomalgMatrix( u, 1, 1, GlobalR );
                       
                       S := HomalgLocalMatrix( CertainRows( S, [ 1 .. n ] ), u, R );
                       
                       TT := UnionOfColumns( TT, S );
                       
                       A2 := HomalgRingElement( One( GlobalR ) , u , R ) * A2;
                       
                       N := UnionOfColumns( N, A2 );
                       
                       Assert( 4, HomalgLocalMatrix(B1,R)*S+HomalgLocalMatrix(A1,R) = A2 );
                       
                   od;
                   
                   if HasEvalUnionOfColumns( TT ) then
                       SetEvalUnionOfColumns( T, EvalUnionOfColumns( TT ) );
                   else
                       SetEval( T, Eval( TT ) );
                   fi;
                  
                   N := HomalgRingElement( One( GlobalR ) , denA , R ) * N;
                  
                   T := HomalgRingElement( denB , denA , R ) * T;
                   
                   Assert( 4, N = A + B * T );
                   
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
                       
                       N := SyzygiesGeneratorsOfRows( Eval( M )[2], Eval( M2 )[2] );
                       
                   else
                       
                       N := SyzygiesGeneratorsOfRows( Eval( M )[2] );
                       
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
                       
                       N := SyzygiesGeneratorsOfColumns( Eval( M )[2], Eval( M2 )[2] );
                       
                   else
                       
                       N := SyzygiesGeneratorsOfColumns( Eval( M )[2] );
                       
                   fi;
                   
                   return HomalgLocalMatrix( N, R );
                   
                 end,
               
        )
 );
