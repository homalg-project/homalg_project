# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the rings provided by the ring packages
##  of the Maple implementation of homalg.

####################################
#
# global variables:
#
####################################

BindGlobal( "CommonHomalgTableForMapleHomalgBestBasis",
        
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
                   ## SetIsDiagonalMatrix( S, true ); ## do not set this, it is false for Quillen-Suslin output
                   
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
                       homalgSendBlocking( [ S, " := ", R, "[-1][BestBasis](", M, R, "[1],", U, V, ")" ], "need_command", "BestBasis" );
                   else
                       ## compute S only:
                       homalgSendBlocking( [ S, " := ", R, "[-1][BestBasis](", M, R, "[1])" ], "need_command", "BestBasis" );
                   fi;
                   
                   return S;
                   
                 end
               
        )
 );
