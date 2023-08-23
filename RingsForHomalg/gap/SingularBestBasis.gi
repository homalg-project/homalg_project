# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the rings with BestBasis provided by Singular.

####################################
#
# global variables:
#
####################################

BindGlobal( "CommonHomalgTableForSingularBestBasis",
        
        rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
                BestBasis :=
                  function( arg )
                     local M, R, RP, nargs, S, U, V;
                     
                     M := arg[1];
                     
                     R := HomalgRing( M );
    
                     RP := homalgTable( R );
                     
                     nargs := Length( arg );
                     
                     #create void matrix for S
                     S := HomalgVoidMatrix( R );
                     
                     #todo: reinsert, as soon as smith works
                     #SetIsDiagonalMatrix( S, true );
                     
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
                        
                        ## compute S, U and (if nargs > 2) V with S = U*M*V as side effect
                        ## but these Matrices are only exported and have to be set
                        homalgSendBlocking( [ "list l=smith(", M,")" ], "need_command", "BestBasis" );
                        homalgSendBlocking( [ "matrix ",S,"=l[1]" ], "need_command");
                        homalgSendBlocking( [ "matrix ",U,"=l[3]" ], "need_command");
                        homalgSendBlocking( [ "matrix ",V,"=l[4]" ], "need_command");
                     else
                        ## compute S only - same as above
                        homalgSendBlocking( [ "list l=smith(", M,")" ], "need_command", "BestBasis" );
                        homalgSendBlocking( [ "matrix ",S,"=l[1]" ], "need_command");
                     fi;
                     
                     return S;
                     
                  end,

        )
 );
