# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the rings provided by Macaulay2.

####################################
#
# global variables:
#
####################################

BindGlobal( "CommonHomalgTableForMacaulay2Basic",
        
        rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               BasisOfRowModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberColumns( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " = BasisOfRowModule(", M, ")" ], "need_command", "BasisOfModule" );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " = BasisOfColumnModule(", M, ")" ], "need_command", "BasisOfModule" );
                   
                   return N;
                   
                 end,
               
               BasisOfRowsCoeff :=
                 function( M, T )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberColumns( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "(", N, T, ") = BasisOfRowsCoeff(", M, ")" ], "need_command", "BasisCoeff" );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, T )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "(", N, T, ") = BasisOfColumnsCoeff(", M, ")" ], "need_command", "BasisCoeff" );
                   
                   return N;
                   
                 end,
               
               DecideZeroRows :=
                 function( A, B )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberRows( A ), NumberColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ N, " = DecideZeroRows(", A, B, ")" ], "need_command", "DecideZero" );
                                      
                   return N;
                   
                 end,
               
               DecideZeroColumns :=
                 function( A, B )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberRows( A ), NumberColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ N, " = DecideZeroColumns(", A, B, ")" ], "need_command", "DecideZero" );
                   
                   return N;
                   
                 end,
               
               DecideZeroRowsEffectively :=
                 function( A, B, T )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberRows( A ), NumberColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ "(", N, T, ") = DecideZeroRowsEffectively(", A, B, ")" ], "need_command", "DecideZeroEffectively" );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberRows( A ), NumberColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ "(", N, T, ") = DecideZeroColumnsEffectively(", A, B, ")" ], "need_command", "DecideZeroEffectively" );
                   
                   return N;
                   
                 end,
               
               SyzygiesGeneratorsOfRows :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberRows( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " = SyzygiesGeneratorsOfRows(", M, ")" ], "need_command", "SyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
               SyzygiesGeneratorsOfColumns :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberColumns( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " = SyzygiesGeneratorsOfColumns(", M, ")" ], "need_command", "SyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
               RelativeSyzygiesGeneratorsOfRows :=
                 function( M, M2 )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberRows( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " = RelativeSyzygiesGeneratorsOfRows(", M, M2, ")" ], "need_command", "SyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
               RelativeSyzygiesGeneratorsOfColumns :=
                 function( M, M2 )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberColumns( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " = RelativeSyzygiesGeneratorsOfColumns(", M, M2, ")" ], "need_command", "SyzygiesGenerators" );
                   
                   return N;
                   
                 end,
               
        )
 );
