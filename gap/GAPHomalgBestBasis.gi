#############################################################################
##
##  GAPHomalgBestBasis.gi     RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the external rings provided by the ring packages
##  of the GAP implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForGAPHomalgBestBasis,
        
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
                   
                   S := HomalgMatrix( "void", NrRows( M ), NrColumns( M ), R );
                   SetIsDiagonalMatrix( S, true );
                   
                   if nargs > 1 then
                       # assign U:
                       if IsHomalgMatrix( arg[2] ) then ## not BestBasis( M, "", V )
                           U := arg[2];
                           SetNrRows( U, NrRows( M ) );
                           SetNrColumns( U, NrRows( M ) );
                           SetIsInvertibleMatrix( U, true );
                       else
                           U := HomalgMatrix( "void", R );
                       fi;
                       
                       # assign V:
                       if nargs > 2 and IsHomalgMatrix( arg[3] ) then ## not BestBasis( M, U, "" )
                           V := arg[3];
                           SetNrRows( V, NrColumns( M ) );
                           SetNrColumns( V, NrColumns( M ) );
                           SetIsInvertibleMatrix( V, true );
                       else
                           V := HomalgMatrix( "void", R );
                       fi;
                       
                       ## compute S, U and (if nargs > 2) V: S = U*M*V
                       rank_of_S := Int( HomalgSendBlocking( [ U, " := HomalgMatrix(\"void\",", R, ");; ", V, " := HomalgMatrix(\"void\",", R, ");; ", S, " := HomalgTable(", R, ")!.BestBasis(", M, U, V, ");; RowRankOfMatrix(", S, ")" ], "need_output" ) );
                   else
                       ## compute S only:
                       rank_of_S := Int( HomalgSendBlocking( [ S, " := HomalgTable(", R, ")!.BestBasis(", M, ");; RowRankOfMatrix(", S, ")" ], "need_output" ) );
                   fi;
                   
                   SetRowRankOfMatrix( S, rank_of_S );
                   
                   return S;
                   
                 end
               
        )
 );
