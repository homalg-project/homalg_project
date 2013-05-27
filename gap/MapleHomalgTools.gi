#############################################################################
##
##  MapleHomalgTools.gi       RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the rings provided by the ring packages
##  of the Maple implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForMapleHomalgTools,
        
        rec(
               Zero := HomalgExternalRingElement( function( R ) homalgSendBlocking( [ "`homalg/homalg_options`(", R, "[-1])" ], "need_command", HOMALG_IO.Pictograms.initialize );
                                                                return homalgSendBlocking( [ "convert( ", R, "[-1][Zero](), symbol )" ], "need_output", HOMALG_IO.Pictograms.Zero ); end, "Maple", IsZero ),
               
               One := HomalgExternalRingElement( R -> homalgSendBlocking( [ "convert( ", R, "[-1][One], symbol )" ], "need_output", HOMALG_IO.Pictograms.One ), "Maple", IsOne ),
               
               MinusOne := HomalgExternalRingElement( R -> homalgSendBlocking( [ "convert( ", R, "[-1][Minus](", Zero( R ), One( R ), R, "[1]), symbol )" ], "need_output", HOMALG_IO.Pictograms.MinusOne ), "Maple", IsMinusOne ),
               
               IsZero := r -> homalgSendBlocking( [ "evalb( ", r, " = ",  Zero( r ), " )" ] , "need_output", HOMALG_IO.Pictograms.IsZero ) = "true",
               
               IsOne := r -> homalgSendBlocking( [ "evalb( ", r, " = ",  One( r ), " )" ] , "need_output", HOMALG_IO.Pictograms.IsOne ) = "true",
               
               Minus :=
                 function( a, b )
                   local R;
                   
                   R := HomalgRing( a );
                   
                   return homalgSendBlocking( [ R, "[-1][Minus](", a, ",", b, ",", R, "[1])" ], HOMALG_IO.Pictograms.Minus ); ## do not delete "," in case a and b are passed as strings
                   
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   local R;
                   
                   R := HomalgRing( a );
                   
                   return homalgSendBlocking( [ R, "[-1][DivideByUnit](", a, ",", u, ",", R, "[1])" ], HOMALG_IO.Pictograms.DivideByUnit ); ## do not delete "," in case a and b are passed as strings
                   
                 end,
               
               IsUnit :=
                 function( R, r )
                   
                   return homalgSendBlocking( [ "evalb( `homalg/InverseElement`(", r, R, ") <> FAIL )" ], "need_output", HOMALG_IO.Pictograms.IsUnit ) = "true";
                   
                 end,
               
               Gcd :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "gcd(", a, ",", b, ")" ], HOMALG_IO.Pictograms.Gcd ); ## do not delete "," in case a and b are passed as strings
                   
                 end,
               
               CancelGcd :=
                 function( a, b )
                   local a_g, b_g;
                   
                   homalgSendBlocking( [ "g := gcd(", a, ",", b, ")" ], "need_command", HOMALG_IO.Pictograms.Gcd ); ## do not delete "," in case a and b are passed as strings
                   a_g := homalgSendBlocking( [ "normal((", a, ") / g)" ], HOMALG_IO.Pictograms.CancelGcd );
                   b_g := homalgSendBlocking( [ "normal((", b, ") / g)" ], HOMALG_IO.Pictograms.CancelGcd );
                   
                   return [ a_g, b_g ];
                   
                 end,
               
               ShallowCopy := C -> homalgSendBlocking( [ "copy( ", C, " )" ], HOMALG_IO.Pictograms.CopyMatrix ),
               
               CopyMatrix :=
                 function( C, R )
                   
                   return homalgSendBlocking( [ R, "[-1][matrix](copy( ", C, " ))" ], HOMALG_IO.Pictograms.CopyMatrix );
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return homalgSendBlocking( [ "`homalg/ZeroMap`(", NrRows( C ), NrColumns( C ), R, ")" ], HOMALG_IO.Pictograms.ZeroMatrix );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return homalgSendBlocking( [ "`homalg/IdentityMap`(", NrRows( C ), R, ")" ], HOMALG_IO.Pictograms.IdentityMatrix );
                   
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ "linalg[iszero](`homalg/SubMat`(", A, B, R, "))" ] , HOMALG_IO.Pictograms.AreEqualMatrices, "need_output" ) = "true";
                   
                 end,
               
               Involution :=
                 function( M )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "`homalg/Involution`(", M, R, ")" ], HOMALG_IO.Pictograms.Involution );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ R, "[-1][CertainRows](", M, plist, ")" ], HOMALG_IO.Pictograms.CertainRows );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ R, "[-1][CertainColumns](", M, plist, ")" ], HOMALG_IO.Pictograms.CertainColumns );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ R, "[-1][matrix](", R, "[-1][UnionOfRows](", A, B, "))" ], HOMALG_IO.Pictograms.UnionOfRows );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ R, "[-1][matrix](", R, "[-1][UnionOfColumns](", A, B, "))" ], HOMALG_IO.Pictograms.UnionOfColumns );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local R, f;
                   
                   R := HomalgRing( e[1] );
                   
                   f := Concatenation( [ "`homalg/DiagMat`(" ], e, [ R, "[-1])" ] );
                   
                   return homalgSendBlocking( f, HOMALG_IO.Pictograms.DiagMat );
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ "`homalg/KroneckerMat`(", A, B, R, ")" ], HOMALG_IO.Pictograms.KroneckerMat );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ "`homalg/MulMat`(", a, A, R, ")" ], HOMALG_IO.Pictograms.MulMat );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ "`homalg/AddMat`(", A, B, R, ")" ], HOMALG_IO.Pictograms.AddMat );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ "`homalg/SubMat`(", A, B, R, ")" ], HOMALG_IO.Pictograms.SubMat );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ "`homalg/Compose`(", A, B, R, ")" ], HOMALG_IO.Pictograms.Compose );
                   
                 end,
               
               NrRows :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return StringToInt( homalgSendBlocking( [ R, "[-1][NumberOfRows](", C, ")" ], "need_output", HOMALG_IO.Pictograms.NrRows ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return StringToInt( homalgSendBlocking( [ R, "[-1][NumberOfGenerators](", C, ")" ], "need_output", HOMALG_IO.Pictograms.NrColumns ) );
                   
                 end,
               
               Determinant :=
                 function( C )
                   
                   return homalgSendBlocking( [ "linalg[det](", C, ")" ], HOMALG_IO.Pictograms.Determinant );
                   
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "linalg[iszero](`homalg/ReduceRingElements`(", M, R, "))" ], HOMALG_IO.Pictograms.IsZeroMatrix, "need_output" ) = "true";
                   
                 end,
               
               ZeroRows :=
                 function( C )
                   local R, list_string;
                   
                   R := HomalgRing( C );
                   
                   list_string := homalgSendBlocking( [ "`homalg/ZeroRows`(", C, R, ")" ], HOMALG_IO.Pictograms.ZeroRows, "need_output" );
                   return StringToIntList( list_string );
                   
                 end,
               
               ZeroColumns :=
                 function( C )
                   local R, list_string;
                   
                   R := HomalgRing( C );
                   
                   list_string := homalgSendBlocking( [ "`homalg/ZeroColumns`(", C, R, ")" ], HOMALG_IO.Pictograms.ZeroColumns, "need_output" );
                   return StringToIntList( list_string );
                   
                 end,
               
               GetColumnIndependentUnitPositions :=
                 function( M, pos_list )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "`homalg/GetColumnIndependentUnitPositions`(", M, pos_list, R, ")" ], "need_output", HOMALG_IO.Pictograms.GetColumnIndependentUnitPositions ) );
                   
                 end,
               
               GetRowIndependentUnitPositions :=
                 function( M, pos_list )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "`homalg/GetRowIndependentUnitPositions`(", M, pos_list, R, ")" ], "need_output", HOMALG_IO.Pictograms.GetRowIndependentUnitPositions ) );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local R, list_string;
                   
                   R := HomalgRing( M );
                   
                   list_string := homalgSendBlocking( [ "`homalg/GetUnitPosition`(", M, pos_list, R, ")" ], "need_output", HOMALG_IO.Pictograms.GetUnitPosition );
                   
                   if list_string = "" then
                       return fail;
                   else
                       return StringToIntList( list_string );
                   fi;
                   
                 end,
               
               GetCleanRowsPositions :=
                 function( M, clean_columns )
                   local R, list_string;
                   
                   R := HomalgRing( M );
                   
                   list_string := homalgSendBlocking( [ "`homalg/GetCleanRowsPositions`(", M, clean_columns, R, ")" ], "need_output", HOMALG_IO.Pictograms.GetCleanRowsPositions );
                   
                   if list_string = "" then
                       return [ ];
                   else
                       return StringToIntList( list_string );
                   fi;
                   
                 end,
               
               ConvertRowToMatrix :=
                 function( M, r, c )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "`homalg/ConvertRowToMatrix`(", M, r, c, R, ")" ], HOMALG_IO.Pictograms.ConvertRowToMatrix );
                   
                 end,
               
               ConvertColumnToMatrix :=
                 function( M, r, c )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "`homalg/ConvertColumnToMatrix`(", M, r, c, R, ")" ], HOMALG_IO.Pictograms.ConvertColumnToMatrix );
                   
                 end,
                
               CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries :=
                 function( mat )
                   local R, n, s, hilb;
                   
                   R := HomalgRing( mat );
                   
                   n := Length( Indeterminates( R ) );
                   
                   s := "'homalg_variable_for_HP'";
                   
                   hilb := homalgSendBlocking( [ "CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries(", mat, R, "[1],", s, ",", n, ")"  ], "need_output", HOMALG_IO.Pictograms.HilbertPoincareSeries );
                   
                   return StringToIntList( hilb );
                   
                 end,
                
               CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries :=
                 function( mat, weights, degrees )
                   local R, var, var_string, s, denom, hilb;
                   
                   R := HomalgRing( mat );
                   
                   var := Indeterminates( R );
                   
                   var_string := ListN( var, weights,
                                        function( v, w ) return Concatenation( String( v ), "=", String( w ) ); end );
                   
                   Append( var_string,
                           ListN( [ 1 .. NrColumns( mat ) ], degrees,
                                  function( i, d ) return Concatenation( String( i ), "=", String( d ) ); end ) );
                   
                   var_string := JoinStringsWithSeparator( var_string );
                   
                   s := "'homalg_variable_for_HP'";
                   
                   denom := List( weights, i -> Concatenation( "(1-", s, "^", String( i ), ")" ) );
                   
                   denom := JoinStringsWithSeparator( denom, "*" );
                   
                   hilb := homalgSendBlocking( [ "CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries(", mat, ",[", var_string, "],", s, ",", denom, ")"  ], "need_output", HOMALG_IO.Pictograms.HilbertPoincareSeries );
                   
                   return StringToIntList( hilb );
                   
                 end,
               
               Eliminate :=
                 function( rel, indets, R )
                   
                   return homalgSendBlocking( [ R, "[-1][matrix](map(a->[a],Eliminate(", rel, indets, R, "[1])))" ], HOMALG_IO.Pictograms.Eliminate );
                   
                 end,
               
               DegreeOfRingElement :=
                 function( r, R )
                   local deg;
                   
                   deg := Int( homalgSendBlocking( [ "degree( ", r, " )" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                   if deg <> fail then
                       return deg;
                   fi;
                   
                   return -1;
                   
                 end,
               
        )
 );
