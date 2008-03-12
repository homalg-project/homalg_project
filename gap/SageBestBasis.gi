#############################################################################
##
##  SageBestBasis.gi            sage rings for homalg          Simon Görtzen
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
## Implementations for the rings with BestBasis provided by sage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForSageBestBasis,
        
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
                       HomalgSendBlocking( [ "_S,_U,_V =", M, ".dense_matrix().smith_form()" ], "need_command" );
                       HomalgSendBlocking( [ "left_matrix=matrix(ZZ,", NrRows( M ), ",sparse=True)" ], "need_command", R );
                       HomalgSendBlocking( [ "for i in range(", NrRows( M ), "):\n  left_matrix[i,", NrRows( M ) - 1, "-i]=1\n\n" ], "need_command", R );
                       HomalgSendBlocking( [ "right_matrix=matrix(ZZ,", NrColumns( M ), ",sparse=True)" ], "need_command", R );
                       HomalgSendBlocking( [ "for i in range(", NrColumns( M ), "):\n  right_matrix[i,", NrColumns( M ) - 1, "-i]=1\n\n" ], "need_command", R );
                       rank_of_S := Int( HomalgSendBlocking( [ "_S.rank()" ], "need_output", R ) );
                       S := HomalgSendBlocking( [ "left_matrix*_S.sparse_matrix()*right_matrix" ], R );
                       U := HomalgSendBlocking( [ "left_matrix*_U.sparse_matrix()" ], R );
                       if nargs > 2 then V := HomalgSendBlocking( [ "_V.sparse_matrix()*right_matrix" ], R ); fi;
                   else
                       ## compute S only:
                       HomalgSendBlocking( [ "elemdivlist=", M, ".elementary_divisors()" ], "need_command" );
                       HomalgSendBlocking( [ "TempMat=matrix(ZZ,", NrRows(M), ",", NrColumns(M), ",sparse=True)" ], "need_command", R );
                       HomalgSendBlocking( [ "for i in range(len(elemdivlist)):\n  TempMat[i,i]=elemdivlist[i]\n\n" ], "need_command", R );
                       rank_of_S := Int( HomalgSendBlocking( [ "TempMat.rank()" ], "need_output", R ) );
                       S := HomalgSendBlocking( [ "TempMat" ], R );
                   fi;
                   
                   # assign U:
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not BestBasis( M, "", V )
                       SetEval( arg[2], U );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   fi;
                   
                   # assign V:
                   if nargs > 2 and IsHomalgMatrix( arg[3] ) then ## not BestBasis( M, U, "" )
                       SetEval( arg[3], V );
                       SetNrRows( arg[3], NrColumns( M ) );
                       SetNrColumns( arg[3], NrColumns( M ) );
                       SetIsInvertibleMatrix( arg[3], true );
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
