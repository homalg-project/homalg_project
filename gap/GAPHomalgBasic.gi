#############################################################################
##
##  GAPHomalgBasic.gi         RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the external rings provided by the GAP package homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForGAPHomalgBasic,
        
        rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               BasisOfRowModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := BasisOfRowModule(", M, ")" ], "need_command", HOMALG_IO.Pictograms.BasisOfModule );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := BasisOfColumnModule(", M, ")" ], "need_command", HOMALG_IO.Pictograms.BasisOfModule );
                   
                   return N;
                   
                 end,
               
               BasisOfRowsCoeff :=
                 function( M, T )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), R );
                   
                   homalgSendBlocking( [ T, " := HomalgVoidMatrix(", R, ");; ", N, " := BasisOfRowsCoeff(", M, T, ")" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, T )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", R );
                   
                   homalgSendBlocking( [ T, " := HomalgVoidMatrix(", R, ");; ", N, " := BasisOfColumnsCoeff(", M, T, ")" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
                   return N;
                   
                 end,
               
               DecideZeroRows :=
                 function( A, B )
                   local N;
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ N, " := DecideZeroRows(", A, B, ")" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumns :=
                 function( A, B )
                   local N;
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ N, " := DecideZeroColumns(", A, B, ")" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
                   
                   return N;
                   
                 end,
               
               DecideZeroRowsEffectively :=
                 function( A, B, T )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ T, " := HomalgVoidMatrix(", R, ");; ", N, " := DecideZeroRowsEffectively(", A, B, T, ")" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ T, " := HomalgVoidMatrix(", R, ");; ", N, " := DecideZeroColumnsEffectively(", A, B, T, ")" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   return N;
                   
                 end,
               
               SyzygiesGeneratorsOfRows :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrRows( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := SyzygiesGeneratorsOfRows(", M, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
               SyzygiesGeneratorsOfColumns :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NrColumns( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := SyzygiesGeneratorsOfColumns(", M, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
               RelativeSyzygiesGeneratorsOfRows :=
                 function( M, M2 )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrRows( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := SyzygiesGeneratorsOfRows(", M, M2, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
               RelativeSyzygiesGeneratorsOfColumns :=
                 function( M, M2 )
                   local N;
                   
                   N := HomalgVoidMatrix( NrColumns( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := SyzygiesGeneratorsOfColumns(", M, M2, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
               ReducedBasisOfRowModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := ReducedBasisOfRowModule(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedBasisOfModule );
                   
                   return N;
                   
                 end,
               
               ReducedBasisOfColumnModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := ReducedBasisOfColumnModule(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedBasisOfModule );
                   
                   return N;
                   
                 end,
               
               ReducedSyzygiesGeneratorsOfRows :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrRows( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := ReducedSyzygiesGeneratorsOfRows(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedSyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
               ReducedSyzygiesGeneratorsOfColumns :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NrColumns( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := ReducedSyzygiesGeneratorsOfColumns(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedSyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
        )
 );
