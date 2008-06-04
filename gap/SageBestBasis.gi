#############################################################################
##
##  SageBestBasis.gi          RingsForHomalg package           Simon Goertzen
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the rings with BestBasis provided by Sage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallGlobalFunction( InitializeSageBestBasis,
        
        function( R )
          local command;
          command := Concatenation(

            "def BestBasis_SUV( M ):\n",
            "  S, U, V = M.smith_form()\n",
            "  InvertedRowList = range(M.nrows()-1,-1,-1)\n",
            "  InvertedColumnList = range(M.ncols()-1,-1,-1)\n",
            "  S = S.matrix_from_rows_and_columns(InvertedRowList, InvertedColumnList)\n",
            "  U = U.matrix_from_rows( InvertedRowList )\n",
            "  V = V.matrix_from_columns( InvertedColumnList )\n",
            "  return S, U, V\n\n",
            
            "def BestBasis_S_only(M):\n",
            "  elemdivlist=M.elementary_divisors()\n",
            "  TempMat=matrix(M.base_ring(),M.nrows(),M.ncols())\n",
            "  for i in range(len(elemdivlist)):\n",
            "    TempMat[i,i]=elemdivlist[i]\n",
            "  return TempMat\n\n"
            
          );
            
          homalgSendBlocking( [ command ], "need_command", R, HOMALG_IO.Pictograms.define );
          
        end
);


InstallValue( CommonHomalgTableForSageBestBasis,
        
        rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               BestBasis :=
                 function( arg )
                   local M, R, nargs, S, U, V, rank_of_S;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   S := HomalgVoidMatrix( NrRows( M ), NrColumns( M ), R );
                   SetIsDiagonalMatrix( S, true );
                   
                   if nargs > 1 then
                       # assign U:
                       if IsHomalgMatrix( arg[2] ) then ## not BestBasis( M, "", V )
                           U := arg[2];
                           SetNrRows( U, NrRows( M ) );
                           SetNrColumns( U, NrRows( M ) );
                           SetIsInvertibleMatrix( U, true );
                       else
                           U := HomalgVoidMatrix( R );
                       fi;
                       
                       # assign V:
                       if nargs > 2 and IsHomalgMatrix( arg[3] ) then ## not BestBasis( M, U, "" )
                           V := arg[3];
                           SetNrRows( V, NrColumns( M ) );
                           SetNrColumns( V, NrColumns( M ) );
                           SetIsInvertibleMatrix( V, true );
                       else
                           V := HomalgVoidMatrix( R );
                       fi;
                       
                       ## compute S, U and (if nargs > 2) V: S = U*M*V
                       rank_of_S := StringToInt( homalgSendBlocking( [ S, U, V, "= BestBasis_SUV(", M, "); ", S, ".rank()" ], "need_output", HOMALG_IO.Pictograms.BestBasis ) );
                   else
                       ## compute S only:
                       rank_of_S := StringToInt( homalgSendBlocking( [ S, " = BestBasis_S_only(", M, "); ", S, ".rank()" ], "need_output", HOMALG_IO.Pictograms.BestBasis ) );
                   fi;
                   
                   SetRowRankOfMatrix( S, rank_of_S );
                   
                   return S;
                   
                 end

        )
 );
