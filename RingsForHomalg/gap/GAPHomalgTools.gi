#############################################################################
##
##  GAPHomalgTools.gi         RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
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

InstallValue( CommonHomalgTableForGAPHomalgTools,
        
        rec(
               Zero := HomalgExternalRingElement( R -> homalgSendBlocking( [ "Zero( ", R, " )" ], HOMALG_IO.Pictograms.Zero ), "GAP", IsZero ),
               
               One := HomalgExternalRingElement( R -> homalgSendBlocking( [ "One( ", R, " )" ], HOMALG_IO.Pictograms.One ), "GAP", IsOne ),
               
               MinusOne := HomalgExternalRingElement( R -> homalgSendBlocking( [ "MinusOne( ", R, " )" ], HOMALG_IO.Pictograms.MinusOne ), "GAP", IsMinusOne ),
               
               RingElement := R -> r -> homalgSendBlocking( [ "One(", R, ")*(", r, ")" ], HOMALG_IO.Pictograms.define ),
               
               IsZero := r -> homalgSendBlocking( [ "IsZero(", r, ")" ] , "need_output", HOMALG_IO.Pictograms.IsZero ) = "true",
               
               IsOne := r -> homalgSendBlocking( [ "IsOne(", r, ")" ] , "need_output", HOMALG_IO.Pictograms.IsOne ) = "true",
               
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "-(", b, ")" ], HOMALG_IO.Pictograms.Minus );
                   
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   
                   return homalgSendBlocking( [ "(", a, ")/(", u, ")"  ], HOMALG_IO.Pictograms.DivideByUnit );
                   
                 end,
               
               IsUnit :=
                 function( R, u )
                   
                   return homalgSendBlocking( [ "IsUnit(", R, u, ")" ], "need_output", HOMALG_IO.Pictograms.IsUnit ) = "true";
                   
                 end,
               
               Sum :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "+(", b, ")" ], HOMALG_IO.Pictograms.Sum );
                   
                 end,
               
               Product :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "(", a, ")*(", b, ")" ], HOMALG_IO.Pictograms.Product );
                   
                 end,
               
               CancelGcd :=
                 function( a, b )
                   local R, a_g, b_g;
                   
                   R := HomalgRing( a );
                   
                   ## Cancel is declared in the package LocalizeRingForHomalg, so we cannot call it directly
                   ## unless LocalizeRingForHomalg has been loaded in external GAP
                   homalgSendBlocking( [ "ccd := homalgTable(", R, ")!.CancelGcd(", a, b, ")" ], "need_command", HOMALG_IO.Pictograms.CancelGcd );
                   a_g := homalgSendBlocking( [ "ccd[1]" ], R, HOMALG_IO.Pictograms.CancelGcd );
                   b_g := homalgSendBlocking( [ "ccd[2]" ], R, HOMALG_IO.Pictograms.CancelGcd );
                   
                   a_g := HomalgExternalRingElement( a_g, R );
                   b_g := HomalgExternalRingElement( b_g, R );
                   
                   return [ a_g, b_g ];
                   
                 end,
               
               ShallowCopy := C -> homalgSendBlocking( [ "ShallowCopy(", C, ")" ], HOMALG_IO.Pictograms.CopyMatrix ),
               
               CopyMatrix :=
                 function( C, R )
                   
                   return homalgSendBlocking( [ "HomalgMatrix(", C, R, ")" ], HOMALG_IO.Pictograms.CopyMatrix );
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "HomalgInitialMatrix(", NrRows( C ), NrColumns( C ), HomalgRing( C ), ")" ], HOMALG_IO.Pictograms.ZeroMatrix );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "HomalgInitialIdentityMatrix(", NrRows( C ), HomalgRing( C ), ")" ], HOMALG_IO.Pictograms.IdentityMatrix );
                   
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "=", B ] , "need_output", HOMALG_IO.Pictograms.AreEqualMatrices ) = "true";
                   
                 end,
               
               Involution := M -> homalgSendBlocking( [ "Involution(", M, ")" ], HOMALG_IO.Pictograms.Involution ),
               
               CertainRows :=
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "CertainRows(", M, plist, ")" ], HOMALG_IO.Pictograms.CertainRows );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "CertainColumns(", M, plist, ")" ], HOMALG_IO.Pictograms.CertainColumns );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "UnionOfRowsOp(", A, B, ")" ], HOMALG_IO.Pictograms.UnionOfRows );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "UnionOfColumnsOp(", A, B, ")" ], HOMALG_IO.Pictograms.UnionOfColumns );
                   
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
               
               MulMatRight :=
                 function( A, a )
                   
                   return homalgSendBlocking( [ A, "*(", a, ")" ], HOMALG_IO.Pictograms.MulMatRight );
                   
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
               
               Determinant :=
                 function( C )
                   
                   return homalgSendBlocking( [ "Determinant( ", C, " )" ], "need_output", HOMALG_IO.Pictograms.Determinant );
                   
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsZero(", M, ")" ] , "need_output", HOMALG_IO.Pictograms.IsZeroMatrix ) = "true";
                   
                 end,
               
               IsIdentityMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsOne(", M, ")" ] , "need_output", HOMALG_IO.Pictograms.IsIdentityMatrix ) = "true";
                   
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
               
               PositionOfFirstNonZeroEntryPerRow :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "PositionOfFirstNonZeroEntryPerRow( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.PositionOfFirstNonZeroEntryPerRow );
                   
                   L := StringToIntList( L );
                   
                   if Length( L ) = 1 then
                       return ListWithIdenticalEntries( NrRows( M ), L[1] );
                   fi;
                   
                   return L;
                   
                 end,
               
               PositionOfFirstNonZeroEntryPerColumn :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "PositionOfFirstNonZeroEntryPerColumn( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.PositionOfFirstNonZeroEntryPerColumn );
                   
                   L := StringToIntList( L );
                   
                   if Length( L ) = 1 then
                       return ListWithIdenticalEntries( NrColumns( M ), L[1] );
                   fi;
                   
                   return L;
                   
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
