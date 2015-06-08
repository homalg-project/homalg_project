#############################################################################
##
##  MAGMABasic.gi             RingsForHomalg package        Markus Kirschmer
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the rings provided by MAGMA.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForMAGMABasic,
        
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
               
               X_PartiallyReducedBasisOfRowModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := PartiallyReducedBasisOfRowModule(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedBasisOfModule );
                   
                   return N;
                   
                 end,
               
               X_PartiallyReducedBasisOfColumnModule :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := PartiallyReducedBasisOfColumnModule(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedBasisOfModule );
                   
                   return N;
                   
                 end,
               
               BasisOfRowsCoeff :=
                 function( M, T )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, T, " := BasisOfRowsCoeff(", M, ")" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, T )
                   local N;
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, T, " := BasisOfColumnsCoeff(", M, ")" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
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
                   local N;
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ N, T, " := DecideZeroRowsEffectively(", A, B, ")" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local N;
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), HomalgRing( A ) );
                   
                   homalgSendBlocking( [ N, T, " := DecideZeroColumnsEffectively(", A, B, ")" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
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
                   
                   homalgSendBlocking( [ N, " := RelativeSyzygiesGeneratorsOfRows(", M, M2, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
               RelativeSyzygiesGeneratorsOfColumns :=
                 function( M, M2 )
                   local N;
                   
                   N := HomalgVoidMatrix( NrColumns( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " := RelativeSyzygiesGeneratorsOfColumns(", M, M2, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
        )
 );
