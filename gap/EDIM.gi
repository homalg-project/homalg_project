#############################################################################
##
##  EDIM.gi                     homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The ring of integers
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for the integers",
        [ IsIntegers ],
        
  function( ext_ring_obj )
    local RP;
    
    RP := rec( 
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               BestBasis := 
                 function( arg )
                   local M, R, nargs, N, S;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 2 then
                       ## compute N, U, and V:
                       N := SmithIntMatLLLTrans( Eval( M )!.matrix );
                   elif nargs > 1 then
                       ## compute N and U:
                       N := SmithIntMatLLLTrans( Eval( M )!.matrix );
                   else
                       ## compute N only:
                       N := SmithIntMatLLL( Eval( M )!.matrix );
                   fi;
                   
                   # assign U:
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not BestBasis( M, "", V )
                       SetEval( arg[2], homalgInternalMatrixHull( N[2] ) );
                       ResetFilterObj( arg[2], IsVoidMatrix );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   fi;
                   
                   # assign V:
                   if nargs > 2 and IsHomalgMatrix( arg[3] ) then ## not BestBasis( M, U, "" )
                       SetEval( arg[3], homalgInternalMatrixHull( N[3] ) );
                       ResetFilterObj( arg[3], IsVoidMatrix );
                       SetNrRows( arg[3], NrColumns( M ) );
                       SetNrColumns( arg[3], NrColumns( M ) );
                       SetIsInvertibleMatrix( arg[3], true );
                   fi;
		   
                   if nargs > 1 then
                       N := N[1];
                   fi;
                   
                   S := HomalgMatrix( N, R );
                   
                   SetNrRows( S, NrRows( M ) );
                   SetNrColumns( S, NrColumns( M ) );
                   SetIsDiagonalMatrix( S, true );
                   
                   return S;
                   
                 end,
               
               RowRankOfMatrix :=
                 function( M )
                   
                   return Rank( Eval( M )!.matrix );
                   
                 end,
               
               ElementaryDivisors :=
                 function( arg )
                   local M, e, z;
                   
                   M := arg[1];
                   
                   e := ElementaryDivisorsMat( Eval( M )!.matrix );
                   
                   z := ListWithIdenticalEntries( NrColumns( M ), 0 );
                   
                   z{ [ 1 .. Length( e ) ] } := e;
                   
                   e := Filtered( z, x -> x <> 1 );
                   
                   return  e;
                   
                 end,
                   
               ## Must be defined if other functions are not defined
               RowReducedEchelonForm :=
                 function( arg )
                   local M, R, nargs, N, H;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not RowReducedEchelonForm( M, "" )
                       ## compute N and U:
                       N := HermiteIntMatLLLTrans( Eval( M )!.matrix );
                       
                       # assign U:
                       SetEval( arg[2], homalgInternalMatrixHull( N[2] ) );
                       ResetFilterObj( arg[2], IsVoidMatrix );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   else
                       ## compute N only:
                       N := HermiteIntMatLLL( Eval( M )!.matrix );
                   fi;
                   
                   if nargs > 1 then
                       N := N[1];
                   fi;
                   
                   H := HomalgMatrix( N, R );
                   
                   SetNrRows( H, NrRows( M ) );
                   SetNrColumns( H, NrColumns( M ) );
                   
                   SetIsUpperStairCaseMatrix( H, true );
                   
                   return H;
                   
                 end
                 
          );
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
