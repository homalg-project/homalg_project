#############################################################################
##
##  SingularBasic.gd          RingsForHomalg package          Simon Goertzen
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the rings provided by Singular.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForSingularBasic,
        
        rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               BasisOfRowModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = BasisOfRowModule(", M, ")" ], "need_command", HOMALG_IO.Pictograms.BasisOfModule );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = BasisOfColumnModule(", M, ")" ], "need_command", HOMALG_IO.Pictograms.BasisOfModule );
                   
                   return N;
                   
                 end,
               
               BasisOfRowsCoeff :=
                 function( M, T )
                   local v, N;
                   
                   v := homalgStream( HomalgRing( M ) )!.variable_name;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "list ", v, "l=BasisOfRowsCoeff(", M, "); matrix ", N, " = ", v, "l[1]; matrix ", T, " = ", v, "l[2]" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, T )
                   local v, N;
                   
                   v := homalgStream( HomalgRing( M ) )!.variable_name;
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "list ", v, "l=BasisOfColumnsCoeff(", M, "); matrix ", N, " = ", v, "l[1]; matrix ", T, " = ", v, "l[2]" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
                   return N;
                   
                 end,
               
               DecideZeroRows :=
                 function( A, B )
                   local N;
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = DecideZeroRows(", A, B, ")" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumns :=
                 function( A, B )
                   local N;
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = DecideZeroColumns(", A, B, ")" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
                   
                   return N;
                   
                 end,
               
               DecideZeroRowsEffectively :=
                 function( A, B, T )
                   local v, N;
                   
                   v := homalgStream( HomalgRing( A ) )!.variable_name;
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ "list ", v, "l=DecideZeroRowsEffectively(", A, B, "); matrix ", N, " = ", v, "l[1]; matrix ", T, " = ", v, "l[2]" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local v, N;
                   
                   v := homalgStream( HomalgRing( A ) )!.variable_name;
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ "list ", v, "l=DecideZeroColumnsEffectively(", A, B, "); matrix ", N, " = ", v, "l[1]; matrix ", T, " = ", v, "l[2]" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   return N;
                   
                 end,
               
               SyzygiesGeneratorsOfRows :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrRows( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = SyzygiesGeneratorsOfRows(", M, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
               SyzygiesGeneratorsOfColumns :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NrColumns( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = SyzygiesGeneratorsOfColumns(", M, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
               RelativeSyzygiesGeneratorsOfRows :=
                 function( M, M2 )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrRows( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = RelativeSyzygiesGeneratorsOfRows(", M, M2, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
               RelativeSyzygiesGeneratorsOfColumns :=
                 function( M, M2 )
                   local N;
                   
                   N := HomalgVoidMatrix( NrColumns( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = RelativeSyzygiesGeneratorsOfColumns(", M, M2, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
               X_ReducedBasisOfRowModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = ReducedBasisOfRowModule(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedBasisOfModule );
                   
                   return N;
                   
                 end,
               
               X_ReducedBasisOfColumnModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = ReducedBasisOfColumnModule(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedBasisOfModule );
                   
                   return N;
                   
                 end,
               
               ReducedSyzygiesGeneratorsOfRows :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrRows( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = ReducedSyzygiesGeneratorsOfRows(", M, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
               ReducedSyzygiesGeneratorsOfColumns :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NrColumns( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = ReducedSyzygiesGeneratorsOfColumns(", M, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
        )
 );
