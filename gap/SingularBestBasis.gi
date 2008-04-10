#############################################################################
##
##  SingularBestBasis.gi      RingsForHomalg package  Markus Lange-Hegermann
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the rings with BestBasis provided by Singular.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForSingularBestBasis,
        
        rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (HomalgTable gives no default value)
               
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
                        HomalgSendBlocking( [ "list l=smith(", M, "); matrix ", U, "=l[3]; matrix ", V, "=l[4]; matrix ", S, "=l[1]" ], "need_command" );
                        rank_of_S := Int( HomalgSendBlocking( [ "l[2]" ], "need_output", R ) );
                     else
                        ## compute S only:
                        HomalgSendBlocking( [ "list l=smith(", M, "); matrix ", S, "=l[1]" ], "need_command" );
                        rank_of_S := Int( HomalgSendBlocking( [ "l[2]" ], "need_output", R ) );
                     fi;
                     
                     SetRowRankOfMatrix( S, rank_of_S );
                     
                     return S;
                     
                  end
                  
        )
 );
