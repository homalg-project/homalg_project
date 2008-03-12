#############################################################################
##
##  MapleHomalgDefault.gi       homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
## Implementations for the rings with BestBasis provided by the ring packages
## of the Maple implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForMapleHomalgDefault,
        
        rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (HomalgTable gives no default value)
               
               BasisOfRowModule :=
                 function( arg )
                   local M, R, nargs, N, rank_of_N, U;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 then
                       ## compute N and U:
                       HomalgSendBlocking( [ "_N := ", R, "[2][TriangularBasis](", M, R, "[1],", "_U)" ], "need_command" );
                       rank_of_N := Int( HomalgSendBlocking( [ "`homalg/RankOfGauss`(copy(_N),", R, "[2])" ], "need_output", R ) );
                       N := HomalgSendBlocking( [ "copy(_N)" ], R );
                       U := HomalgSendBlocking( [ "copy(_U)" ], R );
                       HomalgSendBlocking( [ "unassign(_N): unassign(_U)" ], "need_command", R );
                   else
                       ## compute N only:
                       HomalgSendBlocking( [ "_N := ", R, "[2][TriangularBasis](", M, R, "[1])" ], "need_command" );
                       rank_of_N := Int( HomalgSendBlocking( [ "`homalg/RankOfGauss`(copy(_N),", R, "[2])" ], "need_output", R ) );
                       N := HomalgSendBlocking( [ "copy(_N)" ], R );
                       HomalgSendBlocking( [ "unassign(_N)" ], "need_command", R );
                   fi;
                   
                   # assign U:
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not TriangularBasisOfRows( M, "" )
                       SetEval( arg[2], U );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsFullRowRankMatrix( arg[2], true );
                       SetIsFullColumnRankMatrix( arg[2], true );
                   fi;
                   
                   N := HomalgMatrix( N, R );
                   
                   SetNrRows( N, NrRows( M ) );
                   SetNrColumns( N, NrColumns( M ) );
                   SetRowRankOfMatrix( N, rank_of_N );
                   
                   if HasIsDiagonalMatrix( M ) and IsDiagonalMatrix( M ) then
                       SetIsDiagonalMatrix( N, true );
                   else
                       SetIsUpperTriangularMatrix( N, true );
                   fi;
                   
                   return N;
                   
                 end
               
        )
 );
