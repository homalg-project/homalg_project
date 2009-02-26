#############################################################################
##
##  MapleHomalgTools.gd       RingsForHomalg package         Mohamed Barakat
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
                   
                   return homalgSendBlocking( [ "convert(", R, "[-1][Minus](", a, ",", b, ",", R, "[1]),symbol)" ], "need_output", HOMALG_IO.Pictograms.Minus ); ## do not delete "," in case a and b are passed as strings
                   
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   local R;
                   
                   R := HomalgRing( a );
                   
                   return homalgSendBlocking( [ "convert(", R, "[-1][DivideByUnit](", a, ",", u, ",", R, "[1]),symbol)" ], "need_output", HOMALG_IO.Pictograms.DivideByUnit ); ## do not delete "," in case a and b are passed as strings
                   
                 end,
               
               IsUnit :=
                 function( R, r )
                   
                   return homalgSendBlocking( [ "evalb( `homalg/InverseElement`(", r, R, ") <> FAIL )" ], "need_output", HOMALG_IO.Pictograms.IsUnit ) = "true";
                   
                 end,
               
               DegreeMultivariatePolynomial :=
                 function( r, R )
                   local deg;
                   
                   deg := Int( homalgSendBlocking( [ "degree( ", r, " )" ], "need_output", HOMALG_IO.Pictograms.DegreeMultivariatePolynomial ) );
                   
                   if deg <> fail then
                       return deg;
                   fi;
                   
                   return -1;
                   
                 end,
               
               WeightedDegreeMultivariatePolynomial :=
                 function( r, weights, R )
                   local deg, var;
                   
                   if Set( weights ) <> [ 0, 1 ] then	## there is not direct way to compute the weighted degree in Maple
                       TryNextMethod( );
                   fi;
                   
                   var := Indeterminates( R );
                   
                   var := var{Filtered( [ 1 .. Length( var ) ], p -> weights[p] = 1 )};
                   
                   deg := Int( homalgSendBlocking( [ "degree(", r, var, ")" ], "need_output", HOMALG_IO.Pictograms.DegreeMultivariatePolynomial ) );
                   
                   if deg <> fail then
                       return deg;
                   fi;
                   
                   return -1;
                   
                 end,
               
               ShallowCopy :=
                 function( C )
                   
                   return homalgSendBlocking( [ "copy( ", C, " )" ], HOMALG_IO.Pictograms.CopyMatrix );
                   
                 end,
               
               CopyMatrix :=
                 function( C, R )
                   
                   return homalgSendBlocking( [ "copy( ", C, " )" ], HOMALG_IO.Pictograms.CopyMatrix );
                   
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
                   
                   return homalgSendBlocking( [ "`homalg/AreEqualMatrices`(", A, B, R, ")" ] , HOMALG_IO.Pictograms.AreEqualMatrices, "need_output" ) = "true";
                   
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
               
               IsZeroMatrix :=
                 function( M )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "`homalg/IsZeroMatrix`(", M, R, ")" ], HOMALG_IO.Pictograms.IsZeroMatrix, "need_output" ) = "true";
                   
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
               
        )
 );
