# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the external rings provided by the ring packages
##  of the GAP implementation of homalg.

####################################
#
# global variables:
#
####################################

BindGlobal( "CommonHomalgTableForGAPHomalgTools",
        
        rec(
               Zero := HomalgExternalRingElement( R -> homalgSendBlocking( [ "Zero( ", R, " )" ], "Zero" ), "GAP", IsZero ),
               
               One := HomalgExternalRingElement( R -> homalgSendBlocking( [ "One( ", R, " )" ], "One" ), "GAP", IsOne ),
               
               MinusOne := HomalgExternalRingElement( R -> homalgSendBlocking( [ "MinusOne( ", R, " )" ], "MinusOne" ), "GAP", IsMinusOne ),
               
               RingElement := R -> r -> homalgSendBlocking( [ "One(", R, ")*(", r, ")" ], "define" ),
               
               IsZero := r -> homalgSendBlocking( [ "IsZero(", r, ")" ] , "need_output", "IsZero" ) = "true",
               
               IsOne := r -> homalgSendBlocking( [ "IsOne(", r, ")" ] , "need_output", "IsOne" ) = "true",
               
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "-(", b, ")" ], "Minus" );
                   
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   
                   return homalgSendBlocking( [ "(", a, ")/(", u, ")"  ], "DivideByUnit" );
                   
                 end,
               
               IsUnit :=
                 function( R, u )
                   
                   return homalgSendBlocking( [ "IsUnit(", R, u, ")" ], "need_output", "IsUnit" ) = "true";
                   
                 end,
               
               Sum :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "+(", b, ")" ], "Sum" );
                   
                 end,
               
               Product :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "(", a, ")*(", b, ")" ], "Product" );
                   
                 end,
               
               CancelGcd :=
                 function( a, b )
                   local R, a_g, b_g;
                   
                   R := HomalgRing( a );
                   
                   ## Cancel is declared in the package LocalizeRingForHomalg, so we cannot call it directly
                   ## unless LocalizeRingForHomalg has been loaded in external GAP
                   homalgSendBlocking( [ "ccd := homalgTable(", R, ")!.CancelGcd(", a, b, ")" ], "need_command", "CancelGcd" );
                   a_g := homalgSendBlocking( [ "ccd[1]" ], R, "CancelGcd" );
                   b_g := homalgSendBlocking( [ "ccd[2]" ], R, "CancelGcd" );
                   
                   a_g := HomalgExternalRingElement( a_g, R );
                   b_g := HomalgExternalRingElement( b_g, R );
                   
                   return [ a_g, b_g ];
                   
                 end,
               
               ShallowCopy := C -> homalgSendBlocking( [ "ShallowCopy(", C, ")" ], "CopyMatrix" ),
               
               CopyMatrix :=
                 function( C, R )
                   
                   return homalgSendBlocking( [ "HomalgMatrix(", C, R, ")" ], "CopyMatrix" );
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "HomalgZeroMatrix(", NumberRows( C ), NumberColumns( C ), HomalgRing( C ), ")" ], "ZeroMatrix" );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "HomalgIdentityMatrix(", NumberRows( C ), HomalgRing( C ), ")" ], "IdentityMatrix" );
                   
                 end,
               
               InitialMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "HomalgInitialMatrix(", NumberRows( C ), NumberColumns( C ), HomalgRing( C ), ")" ], "ZeroMatrix" );
                   
                 end,
               
               InitialIdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "HomalgInitialIdentityMatrix(", NumberRows( C ), HomalgRing( C ), ")" ], "IdentityMatrix" );
                   
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "=", B ] , "need_output", "AreEqualMatrices" ) = "true";
                   
                 end,
               
               Involution := M -> homalgSendBlocking( [ "Involution(", M, ")" ], "Involution" ),
               
               TransposedMatrix := M -> homalgSendBlocking( [ "TransposedMatrix(", M, ")" ], "TransposedMatrix" ),
               
               CertainRows :=
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "CertainRows(", M, plist, ")" ], "CertainRows" );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "CertainColumns(", M, plist, ")" ], "CertainColumns" );
                   
                 end,
               
               UnionOfRows :=
                 function( L )
                   local f;
                   
                   f := Concatenation( [ "UnionOfRows([" ], L, [ "])" ] );
                   
                   return homalgSendBlocking( f, "UnionOfRows" );
                   
                 end,
               
               UnionOfColumns :=
                 function( L )
                   local f;
                   
                   f := Concatenation( [ "UnionOfColumns([" ], L, [ "])" ] );
                   
                   return homalgSendBlocking( f, "UnionOfColumns" );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := Concatenation( [ "DiagMat([" ], e, [ "])" ] );
                   
                   return homalgSendBlocking( f, "DiagMat" );
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "KroneckerMat(", A, B, ")" ], "KroneckerMat" );
                   
                 end,
               
               DualKroneckerMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "DualKroneckerMat(", A, B, ")" ], "DualKroneckerMat" );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return homalgSendBlocking( [ "(", a, ")*", A ], "MulMat" );
                   
                 end,
               
               MulMatRight :=
                 function( A, a )
                   
                   return homalgSendBlocking( [ A, "*(", a, ")" ], "MulMatRight" );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "+", B ], "AddMat" );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "-", B ], "SubMat" );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "*", B ], "Compose" );
                   
                 end,
               
               NumberRows :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "NumberRows(", C, ")" ], "need_output", "NumberRows" ) );
                   
                 end,
               
               NumberColumns :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "NumberColumns(", C, ")" ], "need_output", "NumberColumns" ) );
                   
                 end,
               
               Determinant :=
                 function( C )
                   
                   return homalgSendBlocking( [ "Determinant( ", C, " )" ], "need_output", "Determinant" );
                   
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsZero(", M, ")" ] , "need_output", "IsZeroMatrix" ) = "true";
                   
                 end,
               
               IsIdentityMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsOne(", M, ")" ] , "need_output", "IsIdentityMatrix" ) = "true";
                   
                 end,
               
               IsDiagonalMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsDiagonalMatrix(", M, ")" ] , "need_output", "IsDiagonalMatrix" ) = "true";
                   
                 end,
               
               ZeroRows :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroRows(", C, ")" ], "need_output", "ZeroRows" );
                   
                   return EvalString( list_string );
                   
                 end,
               
               ZeroColumns :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroColumns(", C, ")" ], "need_output", "ZeroColumns" );
                   
                   return EvalString( list_string );
                   
                 end,
               
               GetColumnIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositions(", M, pos_list, ")" ], "need_output", "GetColumnIndependentUnitPositions" ) );
                   
                 end,
               
               GetRowIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositions(", M, pos_list, ")" ], "need_output", "GetRowIndependentUnitPositions" ) );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPosition(", M, pos_list, ")" ], "need_output", "GetUnitPosition" );
                   
                   if list_string = "fail" then
                       return fail;
                   else
                       return EvalString( list_string );
                   fi;
                   
                 end,
               
               PositionOfFirstNonZeroEntryPerRow :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "PositionOfFirstNonZeroEntryPerRow( ", M, " )" ], "need_output", "PositionOfFirstNonZeroEntryPerRow" );
                   
                   L := StringToIntList( L );
                   
                   if Length( L ) = 1 then
                       return ListWithIdenticalEntries( NumberRows( M ), L[1] );
                   fi;
                   
                   return L;
                   
                 end,
               
               PositionOfFirstNonZeroEntryPerColumn :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "PositionOfFirstNonZeroEntryPerColumn( ", M, " )" ], "need_output", "PositionOfFirstNonZeroEntryPerColumn" );
                   
                   L := StringToIntList( L );
                   
                   if Length( L ) = 1 then
                       return ListWithIdenticalEntries( NumberColumns( M ), L[1] );
                   fi;
                   
                   return L;
                   
                 end,
               
               DivideEntryByUnit :=
                 function( M, i, j, u )
                   
                   homalgSendBlocking( [ "DivideEntryByUnit(", M, i, j, u, ")" ], "need_command", "DivideEntryByUnit" );
                   
                 end,
               
               DivideRowByUnit :=
                 function( M, i, u, j )
                   
                   homalgSendBlocking( [ "DivideRowByUnit(", M, i, u, j, ")" ], "need_command", "DivideRowByUnit" );
                   
                 end,
               
               DivideColumnByUnit :=
                 function( M, j, u, i )
                   
                   homalgSendBlocking( [ "DivideColumnByUnit(", M, j, u, i, ")" ], "need_command", "DivideColumnByUnit" );
                   
                 end,
               
               CopyRowToIdentityMatrix :=
                 function( M, i, L, j )
                   
                   homalgSendBlocking( [ "CopyRowToIdentityMatrix(", M, i, ",[", L[1], ",", L[2], "],", j, ")" ], "need_command", "CopyRowToIdentityMatrix" );
                   
                 end,
               
               CopyColumnToIdentityMatrix :=
                 function( M, j, L, i )
                   
                   homalgSendBlocking( [ "CopyColumnToIdentityMatrix(", M, j, ",[", L[1], ",", L[2], "],", i, ")" ], "need_command", "CopyColumnToIdentityMatrix" );
                   
                 end,
               
               SetColumnToZero :=
                 function( M, i, j )
                   
                   homalgSendBlocking( [ "SetColumnToZero(", M, i, j, ")" ], "need_command", "SetColumnToZero" );
                   
                 end,
               
               GetCleanRowsPositions :=
                 function( M, clean_columns )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "GetCleanRowsPositions(", M, clean_columns, ")" ], "need_output", "GetCleanRowsPositions" );
                   
                   return EvalString( list_string );
                   
                 end,
               
               ConvertRowToMatrix :=
                 function( M, r, c )
                   
                   return homalgSendBlocking( [ "ConvertRowToMatrix(", M, r, c, ")" ], "ConvertRowToMatrix" );
                   
                 end,
               
               ConvertColumnToMatrix :=
                 function( M, r, c )
                   
                   return homalgSendBlocking( [ "ConvertColumnToMatrix(", M, r, c, ")" ], "ConvertColumnToMatrix" );
                   
                 end,
               
               ConvertMatrixToRow :=
                 function( M )
                   
                   return homalgSendBlocking( [ "ConvertMatrixToRow(", M, ")" ], "ConvertMatrixToRow" );
                   
                 end,
               
               ConvertMatrixToColumn :=
                 function( M )
                   
                   return homalgSendBlocking( [ "ConvertMatrixToColumn(", M, ")" ], "ConvertMatrixToColumn" );
                   
                 end,
               
               ConvertRowToTransposedMatrix :=
                 function( M, r, c )
                   
                   return homalgSendBlocking( [ "ConvertRowToTransposedMatrix(", M, r, c, ")" ], "ConvertRowToMatrix" );
                   
                 end,
               
               ConvertColumnToTransposedMatrix :=
                 function( M, r, c )
                   
                   return homalgSendBlocking( [ "ConvertColumnToTransposedMatrix(", M, r, c, ")" ], "ConvertColumnToMatrix" );
                   
                 end,
               
               ConvertTransposedMatrixToRow :=
                 function( M )
                   
                   return homalgSendBlocking( [ "ConvertTransposedMatrixToRow(", M, ")" ], "ConvertMatrixToRow" );
                   
                 end,
               
               ConvertTransposedMatrixToColumn :=
                 function( M )
                   
                   return homalgSendBlocking( [ "ConvertTransposedMatrixToColumn(", M, ")" ], "ConvertMatrixToColumn" );
                   
                 end,
               
        )
 );
