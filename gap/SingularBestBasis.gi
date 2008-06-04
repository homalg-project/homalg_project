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
               ## (homalgTable gives no default value)
               
                BestBasis :=
                  function( arg )
                     local M, R, nargs, S, U, V, rank_of_S, RP;
                     
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
                        
                        ## compute S, U and (if nargs > 2) V with S = U*M*V as side effect
                        ## but these Matrices are only exported and have to be set
                        ## and return the rank
                        homalgSendBlocking( [ "list l=smith(", M,")" ], "need_command", HOMALG_IO.Pictograms.BestBasis );
                        rank_of_S := StringToInt( homalgSendBlocking( [ "l[2]" ], R, "need_output") );
                        homalgSendBlocking( [ "matrix ",S,"=l[1]" ], "need_command");
                        homalgSendBlocking( [ "matrix ",U,"=l[3]" ], "need_command");
                        homalgSendBlocking( [ "matrix ",V,"=l[4]" ], "need_command");
                     else
                        ## compute S only - same as above
                        homalgSendBlocking( [ "list l=smith(", M,")" ], "need_command", HOMALG_IO.Pictograms.BestBasis );
                        rank_of_S := StringToInt( homalgSendBlocking( [ "l[2]" ], "need_output") );
                        homalgSendBlocking( [ "matrix ",S,"=l[1]" ], "need_command");
                     fi;
                     
                     SetRowRankOfMatrix( S, rank_of_S );
                     
                     return S;
                     
                  end,

        )
 );
