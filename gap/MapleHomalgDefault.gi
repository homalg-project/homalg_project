#############################################################################
##
##  MapleHomalgDefault.gi     RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the rings with BestBasis provided by the ring packages
##  of the Maple implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForMapleHomalgDefault,
        
        rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               BasisOfRowModule :=
                 function( M )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/NormalizeInput`(`homalg/BasisOfModule`(", M, R, "),", R, "[2])" ], "need_command" );
                   
                   return N;
                   
                 end,
               
               BasisOfRowsCoeff :=
                 function( M, U )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/NormalizeInput`(`homalg/BasisCoeff`(", M, R, "[1],", U, R, "[2]),", R, "[2])" ], "need_command" );
                   
                   return N;
                   
                 end,
                 
               DecideZeroRows :=
                 function( A, B )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/NormalizeInput`(`homalg/Reduce`(", A, B, R, "),", R, "[2])" ], "need_command" );
                   
                   return N;
                   
                 end,
                 
               EffectivelyDecideZeroRows :=
                 function( A, B, U )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ N, " := `homalg/NormalizeInput`(`homalg/ReduceCoeff`(", A, B, R, "[1],", U, R, "[2]),", R, "[2])" ], "need_command" );
                   
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
                       
                       homalgSendBlocking( [ N, " := `homalg/NormalizeInput`(`homalg/SyzygiesGenerators`(", M, M2, R, "),", R, "[2])" ], "need_command" );
                       
                   else
                       
                       homalgSendBlocking( [ N, " := `homalg/NormalizeInput`(`homalg/SyzygiesGenerators`(", M, ",[],", R, "),", R, "[2])" ], "need_command" );
                       
                   fi;
                   
                   return N;
                   
                 end
                 
        )
 );
