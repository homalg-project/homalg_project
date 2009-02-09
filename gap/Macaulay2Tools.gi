#############################################################################
##
##  Macaulay2Tools.gd         RingsForHomalg package          Daniel Robertz
##
##  Copyright 2007-2009 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the external rings provided by the ring packages
##  of the GAP implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForMacaulay2Tools,
        
        rec(
               Zero := HomalgExternalRingElement( R -> homalgPointer( homalgSendBlocking( [ R, "#0" ], HOMALG_IO.Pictograms.Zero ) ), "Macaulay2", IsZero ),
               
               One := HomalgExternalRingElement( R -> homalgPointer( homalgSendBlocking( [ R, "#1" ], HOMALG_IO.Pictograms.One ) ), "Macaulay2", IsOne ),
               
               MinusOne := HomalgExternalRingElement( R -> homalgPointer( homalgSendBlocking( [ "-", R, "#1" ], HOMALG_IO.Pictograms.MinusOne ) ), "Macaulay2", IsMinusOne ),
               
               IsZero := r -> homalgSendBlocking( [ "zero(", r, ")" ] , "need_output", HOMALG_IO.Pictograms.IsZero ) = "1",
               
               IsOne := r -> homalgSendBlocking( [ r, "==", One( r ) ] , "need_output", HOMALG_IO.Pictograms.IsOne ) = "1",
               
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "-(", b, ")" ], "need_output", HOMALG_IO.Pictograms.Minus );
                   
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   
                   return homalgSendBlocking( [ "(", a, ")/(", u, ")"  ], "need_output", HOMALG_IO.Pictograms.DivideByUnit );
                   
                 end,
               
               IsUnit :=
                 function( R, u )
                   
                   return homalgSendBlocking( [ "isUnit(", u, ")" ], "need_output", HOMALG_IO.Pictograms.IsUnit, R ) = "true";
                   
                 end,
               
               Sum :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "+", b ], "need_output", HOMALG_IO.Pictograms.Sum );
                   
                 end,
               
               Product :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "(", a, ")*(", b, ")" ], "need_output", HOMALG_IO.Pictograms.Product );
                   
                 end,
               
               ShallowCopy :=
                 function( C )
                   
                   return HomalgMatrix( homalgSendBlocking( [ C ], HOMALG_IO.Pictograms.CopyMatrix ), NrRows( C ), NrColumns( C ), HomalgRing( C ) );
                   
                 end,
               
               CopyMatrix :=
                 function( C, R )
                   
                   return HomalgMatrix( homalgSendBlocking( [ "substitute(", C, HomalgRing( C ), ")" ], R, HOMALG_IO.Pictograms.CopyMatrix ), NrRows( C ), NrColumns( C ), R );
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   local R;
		   
		   R := HomalgRing( C );
		   
                   return homalgSendBlocking( [ "map(", R, "^", NrColumns( C ), R, "^", NrRows( C ), "0)" ], HOMALG_IO.Pictograms.ZeroMatrix );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "id_(", HomalgRing( C ), "^", NrRows( C ), ")" ], HOMALG_IO.Pictograms.IdentityMatrix );
                   
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "==", B ] , "need_output", HOMALG_IO.Pictograms.AreEqualMatrices ) = "true";
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return homalgSendBlocking( [ "Involution(", M, ")" ], HOMALG_IO.Pictograms.Involution );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   
                   plist := plist - 1;
                   return homalgSendBlocking( [ M, "^{", plist, "}" ], "break_lists", HOMALG_IO.Pictograms.CertainRows );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
		   plist := plist - 1;
                   return homalgSendBlocking( [ M, "^{", plist, "}" ], "break_lists", HOMALG_IO.Pictograms.CertainColumns );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "||", B ], HOMALG_IO.Pictograms.UnionOfRows );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "|", B ], HOMALG_IO.Pictograms.UnionOfColumns );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := Concatenation( [ "DiagMat([" ], e, [ "])" ] );
                   
                   return homalgSendBlocking( f, HOMALG_IO.Pictograms.DiagMat );
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "KroneckerMat(", A, B, ")" ], HOMALG_IO.Pictograms.KroneckerMat );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return homalgSendBlocking( [ "(", a, ")*", A ], HOMALG_IO.Pictograms.MulMat );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "+", B ], HOMALG_IO.Pictograms.AddMat );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "-", B ], HOMALG_IO.Pictograms.SubMat );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "*", B ], HOMALG_IO.Pictograms.Compose );
                   
                 end,
               
               NrRows :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "NrRows(", C, ")" ], "need_output", HOMALG_IO.Pictograms.NrRows ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "NrColumns(", C, ")" ], "need_output", HOMALG_IO.Pictograms.NrColumns ) );
                   
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsZero(", M, ")" ] , "need_output", HOMALG_IO.Pictograms.IsZeroMatrix ) = "true";
                   
                 end,
               
               IsIdentityMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsIdentityMatrix(", M, ")" ] , "need_output", HOMALG_IO.Pictograms.IsIdentityMatrix ) = "true";
                   
                 end,
               
               IsDiagonalMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsDiagonalMatrix(", M, ")" ] , "need_output", HOMALG_IO.Pictograms.IsDiagonalMatrix ) = "true";
                   
                 end,
               
               ZeroRows :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroRows(", C, ")" ], "need_output", HOMALG_IO.Pictograms.ZeroRows );
                   
                   return EvalString( list_string );
                   
                 end,
               
               ZeroColumns :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroColumns(", C, ")" ], "need_output", HOMALG_IO.Pictograms.ZeroColumns );
                   
                   return EvalString( list_string );
                   
                 end,
               
               GetColumnIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositions(", M, pos_list, ")" ], "need_output", HOMALG_IO.Pictograms.GetColumnIndependentUnitPositions ) );
                   
                 end,
               
               GetRowIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositions(", M, pos_list, ")" ], "need_output", HOMALG_IO.Pictograms.GetRowIndependentUnitPositions ) );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPosition(", M, pos_list, ")" ], "need_output", HOMALG_IO.Pictograms.GetUnitPosition );
                   
                   if list_string = "fail" then
                       return fail;
                   else
                       return EvalString( list_string );
                   fi;
                   
                 end,
               
               DivideEntryByUnit :=
                 function( M, i, j, u )
                   
                   homalgSendBlocking( [ "DivideEntryByUnit(", M, i, j, u, ")" ], "need_command", HOMALG_IO.Pictograms.DivideEntryByUnit );
                   
                 end,
               
               DivideRowByUnit :=
                 function( M, i, u, j )
                   
                   homalgSendBlocking( [ "DivideRowByUnit(", M, i, u, j, ")" ], "need_command", HOMALG_IO.Pictograms.DivideRowByUnit );
                   
                 end,
               
               DivideColumnByUnit :=
                 function( M, j, u, i )
                   
                   homalgSendBlocking( [ "DivideColumnByUnit(", M, j, u, i, ")" ], "need_command", HOMALG_IO.Pictograms.DivideColumnByUnit );
                   
                 end,
               
               CopyRowToIdentityMatrix :=
                 function( M, i, L, j )
                   
                   homalgSendBlocking( [ "CopyRowToIdentityMatrix(", M, i, ",[", L[1], ",", L[2], "],", j, ")" ], "need_command", HOMALG_IO.Pictograms.CopyRowToIdentityMatrix );
                   
                 end,
               
               CopyColumnToIdentityMatrix :=
                 function( M, j, L, i )
                   
                   homalgSendBlocking( [ "CopyColumnToIdentityMatrix(", M, j, ",[", L[1], ",", L[2], "],", i, ")" ], "need_command", HOMALG_IO.Pictograms.CopyColumnToIdentityMatrix );
                   
                 end,
               
               SetColumnToZero :=
                 function( M, i, j )
                   
                   homalgSendBlocking( [ "SetColumnToZero(", M, i, j, ")" ], "need_command", HOMALG_IO.Pictograms.SetColumnToZero );
                   
                 end,
               
               GetCleanRowsPositions :=
                 function( M, clean_columns )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "GetCleanRowsPositions(", M, clean_columns, ")" ], "need_output", HOMALG_IO.Pictograms.GetCleanRowsPositions );
                   
                   return EvalString( list_string );
                   
                 end,
               
               ConvertRowToMatrix :=
                 function( M, r, c )
                   
                   return homalgSendBlocking( [ "ConvertRowToMatrix(", M, r, c, ")" ], HOMALG_IO.Pictograms.ConvertRowToMatrix );
                   
                 end,
               
               ConvertColumnToMatrix :=
                 function( M, r, c )
                   
                   return homalgSendBlocking( [ "ConvertColumnToMatrix(", M, r, c, ")" ], HOMALG_IO.Pictograms.ConvertColumnToMatrix );
                   
                 end,
               
               ConvertMatrixToRow :=
                 function( M )
                   
                   return homalgSendBlocking( [ "ConvertMatrixToRow(", M, ")" ], HOMALG_IO.Pictograms.ConvertMatrixToRow );
                   
                 end,
               
               ConvertMatrixToColumn :=
                 function( M )
                   
                   return homalgSendBlocking( [ "ConvertMatrixToColumn(", M, ")" ], HOMALG_IO.Pictograms.ConvertMatrixToColumn );
                   
                 end,
               
        )
 );
