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

InstallValue( InitializeSingularBestBasis,
        
        function( R )
          local command;
          command := Concatenation(

            "proc BestBasis_SUV(M)\n",
            "{\n",
            "  matrix S[nrows(M)][ncols(M)]=transpose(std(transpose(M)));\n",
            "  matrix U[nrows(M)][nrows(M)];\n",
            "  matrix V[ncols(M)][ncols(M)]=transpose(lift(transpose(S),transpose(M),U));\n",
            "  U=transpose(U);\n",
            "  export(S,U,V);\n",
            "  return(nrows(S));\n",
            "};\n\n",

            "proc BestBasis_S(M)\n",
            "{\n",
            "  matrix S[nrows(M)][ncols(M)]=transpose(std(transpose(M)));\n",
            "  export(S);\n",
            "  return(nrows(S));\n",
            "};\n\n",

          );
          
          homalgSendBlocking( [ command ], "need_command", R );
          
        end
);

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
                        
                        ## compute S, U and (if nargs > 2) V with V*S = U*M as side effect
                        ## but these Matrices are only exported and have to be set
                        ## and return the rank
                        rank_of_S := Int( homalgSendBlocking( [ "BestBasis_SUV(",M,")" ], "need_output") );
                        homalgSendBlocking( [ "matrix ",S,"=S" ], "need_command");
                        homalgSendBlocking( [ "matrix ",U,"=U" ], "need_command");
                        homalgSendBlocking( [ "matrix ",V,"=V" ], "need_command");
                     else
                        ## compute S only - same as above
                        rank_of_S := Int( [ "BestBasis_S(",M,")" ], "need_output" );
                        homalgSendBlocking( [ "matrix ",S,"=S" ], "need_command");
                     fi;
                     
                     SetRowRankOfMatrix( S, rank_of_S );
                     
                     return S;
                     
                  end
                  
        )
 );
