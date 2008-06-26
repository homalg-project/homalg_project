#############################################################################
##
##  MapleHomalgBasic.gi       RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the external rings provided by the by the ring packages
##  of the Maple implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForMapleHomalgBasic,
        
        rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               BasisOfRowModule :=
                 function( M )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/BasisOfRowModule`(", M, R, ")" ], "need_command", HOMALG_IO.Pictograms.BasisOfModule );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnModule :=
                 function( M )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", R );
                   
                   homalgSendBlocking( [ N, " := `homalg/BasisOfColumnModule`(", M, R, ")" ], "need_command", HOMALG_IO.Pictograms.BasisOfModule );
                   
                   return N;
                   
                 end,
               
               BasisOfRowsCoeff :=
                 function( M, T )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/BasisOfRowsCoeff`(", M, R, "[1],", T, R, "[-1])" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, T )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", R );
                   
                   homalgSendBlocking( [ N, " := `homalg/BasisOfColumnsCoeff`(", M, R, "[1],", T, R, "[-1])" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
                   return N;
                   
                 end,
               
               DecideZeroRows :=
                 function( A, B )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/DecideZeroRows`(", A, B, R, ")" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumns :=
                 function( A, B )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/DecideZeroColumns`(", A, B, R, ")" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
                   
                   return N;
                   
                 end,
               
               DecideZeroRowsEffectively :=
                 function( A, B, T )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/DecideZeroRowsEffectively`(", A, B, R, "[1],", T, R, "[-1])" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/DecideZeroColumnsEffectively`(", A, B, R, "[1],", T, R, "[-1])" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   return N;
                   
                 end,
               
               SyzygiesGeneratorsOfRows :=
                 function( arg )
                   local M, R, N, M2;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrRows( M ), R );
                   
                   if Length( arg ) > 1 and IsHomalgMatrix( arg[2] ) then
                       
                       M2 := arg[2];
                       
                       homalgSendBlocking( [ N, " := `homalg/SyzygiesGeneratorsOfRows`(", M, M2, R, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                       
                   else
                       
                       homalgSendBlocking( [ N, " := `homalg/SyzygiesGeneratorsOfRows`(", M, ",[],", R, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                       
                   fi;
                   
                   return N;
                   
                 end,
               
               SyzygiesGeneratorsOfColumns :=
                 function( arg )
                   local M, R, N, M2;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NrColumns( M ), "unknown_number_of_columns", R );
                   
                   if Length( arg ) > 1 and IsHomalgMatrix( arg[2] ) then
                       
                       M2 := arg[2];
                       
                       homalgSendBlocking( [ N, " := `homalg/SyzygiesGeneratorsOfColumns`(", M, M2, R, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                       
                   else
                       
                       homalgSendBlocking( [ N, " := `homalg/SyzygiesGeneratorsOfColumns`(", M, ",[],", R, ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                       
                   fi;
                   
                   return N;
                   
                 end,
               
        )
 );
