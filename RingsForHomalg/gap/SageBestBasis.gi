# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the rings with BestBasis provided by Sage.

####################################
#
# global variables:
#
####################################

SageMacros.BestBasis_S_only := "\n\
def BestBasis_S_only(M):\n\
  elemdivlist=M.elementary_divisors()\n\
  TempMat=matrix(M.base_ring(),M.nrows(),M.ncols())\n\
  for i in range(len(elemdivlist)):\n\
    TempMat[i,i]=elemdivlist[i]\n\
  return TempMat\n\n";

##
BindGlobal( "CommonHomalgTableForSageBestBasis",
        
        rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               BestBasis :=
                 function( arg )
                   local M, R, nargs, S, U, V;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   S := HomalgVoidMatrix( NumberRows( M ), NumberColumns( M ), R );
                   SetIsDiagonalMatrix( S, true );
                   
                   if nargs > 1 then
                       # assign U:
                       if IsHomalgMatrix( arg[2] ) then ## not BestBasis( M, "", V )
                           U := arg[2];
                           SetNumberRows( U, NumberRows( M ) );
                           SetNumberColumns( U, NumberRows( M ) );
                           SetIsInvertibleMatrix( U, true );
                       else
                           U := HomalgVoidMatrix( R );
                       fi;
                       
                       # assign V:
                       if nargs > 2 and IsHomalgMatrix( arg[3] ) then ## not BestBasis( M, U, "" )
                           V := arg[3];
                           SetNumberRows( V, NumberColumns( M ) );
                           SetNumberColumns( V, NumberColumns( M ) );
                           SetIsInvertibleMatrix( V, true );
                       else
                           V := HomalgVoidMatrix( R );
                       fi;
                       
                       ## compute S, U and (if nargs > 2) V: S = U*M*V
                       homalgSendBlocking( [ S, U, V, "=", M, ".smith_form()" ], "need_command", "BestBasis" );
                   else
                       ## compute S only:
                       homalgSendBlocking( [ S, " = BestBasis_S_only(", M, ")" ], "need_command", "BestBasis" );
                   fi;
                   
                   return S;
                   
                 end
               
        )
 );
