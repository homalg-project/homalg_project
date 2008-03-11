#############################################################################
##
##  MapleHomalg.gi              homalg package               Mohamed Barakat
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

InstallValue( CommonHomalgTableForMapleHomalgBestBasis,
        
        rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (HomalgTable gives no default value)
               
               BestBasis :=
                 function( arg )
                   local M, R, nargs, S, rank_of_S, U, V;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 then
                       ## compute S, U and (if nargs > 2) V: S = U*M*V
                       HomalgSendBlocking( [ "_S := ", R, "[2][BestBasis](", M, R, "[1],", "_U,_V):" ], "need_command" );
                       rank_of_S := Int( HomalgSendBlocking( [ "`homalg/RankOfGauss`(copy(_S),", R,"[2])" ], "need_output" ) );
                       S := HomalgSendBlocking( [ "copy(_S)" ], R );
                       U := HomalgSendBlocking( [ "copy(_U)" ], R );
                       V := HomalgSendBlocking( [ "copy(_V)" ], R );
                       HomalgSendBlocking( [ "unassign(_S): unassign(_U): unassign(_V):" ], "need_command", R );
                   else
                       ## compute S only:
                       HomalgSendBlocking( [ "_S := ", R, "[2][BestBasis](", M, R, "[1]):" ], "need_command" );
                       rank_of_S := Int( HomalgSendBlocking( [ "`homalg/RankOfGauss`(copy(_S),", R,"[2])" ], "need_output" ) );
                       S := HomalgSendBlocking( [ "copy(_S)" ], R );
                       HomalgSendBlocking( [ "unassign(_S):" ], "need_command", R );
                   fi;
                   
                   # assign U:
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not BestBasis( M, "", V )
                       SetEval( arg[2], U );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsFullRowRankMatrix( arg[2], true );
                       SetIsFullColumnRankMatrix( arg[2], true );
                   fi;
                   
                   # assign V:
                   if nargs > 2 and IsHomalgMatrix( arg[3] ) then ## not BestBasis( M, U, "" )
                       SetEval( arg[3], V );
                       SetNrRows( arg[3], NrColumns( M ) );
                       SetNrColumns( arg[3], NrColumns( M ) );
                       SetIsFullRowRankMatrix( arg[3], true );
                       SetIsFullColumnRankMatrix( arg[3], true );
                   fi;
                   
                   S := HomalgMatrix( S, R );
                   
                   SetNrRows( S, NrRows( M ) );
                   SetNrColumns( S, NrColumns( M ) );
                   SetRowRankOfMatrix( S, rank_of_S );
                   SetIsDiagonalMatrix( S, true );
                   
                   return S;
                   
                 end
               
        )
 );
