# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the external rings provided by the GAP package homalg.

####################################
#
# global variables:
#
####################################

BindGlobal( "CommonHomalgTableForGAPHomalgBasic",
        
        rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               BasisOfRowModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberColumns( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := BasisOfRowModule(", M, ")" ], "need_command", "BasisOfModule" );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := BasisOfColumnModule(", M, ")" ], "need_command", "BasisOfModule" );
                   
                   return N;
                   
                 end,
               
               BasisOfRowsCoeff :=
                 function( M, T )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberColumns( M ), R );
                   
                   homalgSendBlocking( [ T, " := HomalgVoidMatrix(", R, ");; ", N, " := BasisOfRowsCoeff(", M, T, ")" ], "need_command", "BasisCoeff" );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, T )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NumberRows( M ), "unknown_number_of_columns", R );
                   
                   homalgSendBlocking( [ T, " := HomalgVoidMatrix(", R, ");; ", N, " := BasisOfColumnsCoeff(", M, T, ")" ], "need_command", "BasisCoeff" );
                   
                   return N;
                   
                 end,
               
               DecideZeroRows :=
                 function( A, B )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberRows( A ), NumberColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ N, " := DecideZeroRows(", A, B, ")" ], "need_command", "DecideZero" );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumns :=
                 function( A, B )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberRows( A ), NumberColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ N, " := DecideZeroColumns(", A, B, ")" ], "need_command", "DecideZero" );
                   
                   return N;
                   
                 end,
               
               DecideZeroRowsEffectively :=
                 function( A, B, T )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NumberRows( A ), NumberColumns( A ), R );
                   
                   homalgSendBlocking( [ T, " := HomalgVoidMatrix(", R, ");; ", N, " := DecideZeroRowsEffectively(", A, B, T, ")" ], "need_command", "DecideZeroEffectively" );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NumberRows( A ), NumberColumns( A ), R );
                   
                   homalgSendBlocking( [ T, " := HomalgVoidMatrix(", R, ");; ", N, " := DecideZeroColumnsEffectively(", A, B, T, ")" ], "need_command", "DecideZeroEffectively" );
                   
                   return N;
                   
                 end,
               
               SyzygiesGeneratorsOfRows :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberRows( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := SyzygiesGeneratorsOfRows(", M, ")" ], "need_command", "SyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
               SyzygiesGeneratorsOfColumns :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberColumns( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := SyzygiesGeneratorsOfColumns(", M, ")" ], "need_command", "SyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
               RelativeSyzygiesGeneratorsOfRows :=
                 function( M, M2 )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberRows( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := SyzygiesGeneratorsOfRows(", M, M2, ")" ], "need_command", "SyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
               RelativeSyzygiesGeneratorsOfColumns :=
                 function( M, M2 )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberColumns( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := SyzygiesGeneratorsOfColumns(", M, M2, ")" ], "need_command", "SyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
               ReducedBasisOfRowModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberColumns( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := ReducedBasisOfRowModule(", M, ")" ], "need_command", "ReducedBasisOfModule" );
                   
                   return N;
                   
                 end,
               
               ReducedBasisOfColumnModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := ReducedBasisOfColumnModule(", M, ")" ], "need_command", "ReducedBasisOfModule" );
                   
                   return N;
                   
                 end,
               
               ReducedSyzygiesGeneratorsOfRows :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberRows( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := ReducedSyzygiesGeneratorsOfRows(", M, ")" ], "need_command", "ReducedSyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
               ReducedSyzygiesGeneratorsOfColumns :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberColumns( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := ReducedSyzygiesGeneratorsOfColumns(", M, ")" ], "need_command", "ReducedSyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
        )
 );
