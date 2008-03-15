#############################################################################
##
##  Integers.gi                 homalg package               Mohamed Barakat
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
        
  function( arg )
    local RP;
    
    RP := rec( 
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (HomalgTable gives no default value)
               RingName := "Z",
               
               BestBasis := 
                 function( arg )
                   local M, R, nargs, N, S;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 2 then
                       ## compute N, U, and V:
                       N := SmithIntMatLLLTrans( Eval( M ) );
                   elif nargs > 1 then
                       ## compute N and U:
                       N := SmithIntMatLLLTrans( Eval( M ) );
                   else
                       ## compute N only:
                       N := SmithIntMatLLL( Eval( M ) );
                   fi;
                   
                   # return U:
                   if nargs > 1 then
                       SetEval( arg[2], N[2] );
                       ResetFilterObj( arg[2], IsVoidMatrix );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   fi;
                   
                   # return V:
                   if nargs > 2 then
                       SetEval( arg[3], N[3] );
                       ResetFilterObj( arg[3], IsVoidMatrix );
                       SetNrRows( arg[3], NrColumns( M ) );
                       SetNrColumns( arg[3], NrColumns( M ) );
                       SetIsInvertibleMatrix( arg[3], true );
                   fi;
                   
                   if nargs > 1 then
                       N := N[1];
                   fi;
                   
                   S := HomalgMatrix( N, R );
                   
                   SetIsDiagonalMatrix( S, true );
     
                   return S;
                   
                 end,
               
               ElementaryDivisors :=
                 function( arg )
                   local M, e, z;    
                   
                   M := arg[1];
                   
                   e := ElementaryDivisorsMat( Eval( M ) );
                   
                   z := ListWithIdenticalEntries( NrColumns( M ), 0 );
                   
                   z{ [ 1 .. Length( e ) ] } := e;
                   
                   e := Filtered( z, x -> x <> 1 );
                   
                   return  e;
                   
                 end,
                   
               ## Must be defined if other functions are not defined
               TriangularBasisOfRows :=
                 function( arg )
                   local M, R, nargs, N, H;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 then
                       ## compute N and U:
                       N := HermiteIntMatLLLTrans( Eval( M ) );
                   else
                       ## compute N only:
                       N := HermiteIntMatLLL( Eval( M ) );
                   fi;
                   
                   # return U:
                   if nargs > 1 then
                       SetEval( arg[2], N[2] );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   fi;
                   
                   if nargs > 1 then
                       N := N[1];
                   fi;
                   
                   H := HomalgMatrix( N, R );
                   
                   if HasIsDiagonalMatrix( M ) and IsDiagonalMatrix( M ) then
                       SetIsDiagonalMatrix( H, true );   
                   else
                       SetIsUpperTriangularMatrix( H, true );
                   fi;
                   
                   return H;
                   
                 end
                   
          );
                 
    Objectify( HomalgTableType, RP );
    
    return RP;
    
end );
