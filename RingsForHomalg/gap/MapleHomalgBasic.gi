# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the external rings provided by the by the ring packages
##  of the Maple implementation of homalg.

####################################
#
# global variables:
#
####################################

BindGlobal( "CommonHomalgTableForMapleHomalgBasic",
        
        rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               RowEchelonForm :=
                 function( M )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberColumns( M ), R );
                   
                   homalgSendBlocking( [ N, " := ", R, "[-1][matrix](LinearAlgebra[GaussianElimination](Matrix(", M, ")))" ], "need_command", "ReducedEchelonForm" );
                   
                   return N;
                   
                 end,
               
               BasisOfRowModule :=
                 function( M )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberColumns( M ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/BasisOfRowModule`(", M, R, ")" ], "need_command", "BasisOfModule" );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnModule :=
                 function( M )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NumberRows( M ), "unknown_number_of_columns", R );
                   
                   homalgSendBlocking( [ N, " := `homalg/BasisOfColumnModule`(", M, R, ")" ], "need_command", "BasisOfModule" );
                   
                   return N;
                   
                 end,
               
               BasisOfRowsCoeff :=
                 function( M, T )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberColumns( M ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/BasisOfRowsCoeff`(", M, R, "[1],", T, R, "[-1])" ], "need_command", "BasisCoeff" );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, T )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NumberRows( M ), "unknown_number_of_columns", R );
                   
                   homalgSendBlocking( [ N, " := `homalg/BasisOfColumnsCoeff`(", M, R, "[1],", T, R, "[-1])" ], "need_command", "BasisCoeff" );
                   
                   return N;
                   
                 end,
               
               DecideZeroRows :=
                 function( A, B )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NumberRows( A ), NumberColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/DecideZeroRows`(", A, B, R, ")" ], "need_command", "DecideZero" );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumns :=
                 function( A, B )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NumberRows( A ), NumberColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/DecideZeroColumns`(", A, B, R, ")" ], "need_command", "DecideZero" );
                   
                   return N;
                   
                 end,
               
               DecideZeroRowsEffectively :=
                 function( A, B, T )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NumberRows( A ), NumberColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/DecideZeroRowsEffectively`(", A, B, R, "[1],", T, R, "[-1])" ], "need_command", "DecideZeroEffectively" );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NumberRows( A ), NumberColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/DecideZeroColumnsEffectively`(", A, B, R, "[1],", T, R, "[-1])" ], "need_command", "DecideZeroEffectively" );
                   
                   return N;
                   
                 end,
               
               SyzygiesGeneratorsOfRows :=
                 function( M )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberRows( M ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/SyzygiesGeneratorsOfRows`(", M, ",[],", R, ")" ], "need_command", "SyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
               SyzygiesGeneratorsOfColumns :=
                 function( M )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NumberColumns( M ), "unknown_number_of_columns", R );
                   
                   homalgSendBlocking( [ N, " := `homalg/SyzygiesGeneratorsOfColumns`(", M, ",[],", R, ")" ], "need_command", "SyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
               RelativeSyzygiesGeneratorsOfRows :=
                 function( M, M2 )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberRows( M ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/SyzygiesGeneratorsOfRows`(", M, M2, R, ")" ], "need_command", "SyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
               RelativeSyzygiesGeneratorsOfColumns :=
                 function( M, M2 )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NumberColumns( M ), "unknown_number_of_columns", R );
                   
                   homalgSendBlocking( [ N, " := `homalg/SyzygiesGeneratorsOfColumns`(", M, M2, R, ")" ], "need_command", "SyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
        )
 );
