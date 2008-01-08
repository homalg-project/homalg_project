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
               BestBasis := 
                 function( arg )
                   local M, nar, N, S;
                   
                   M := arg[1];
                   
                   nar := Length( arg );
                   
                   # R := arg[nar];
                   
                   if nar > 3 then
                       ## compute N, U, and V: (1+4+8)
                       N := NormalFormIntMat( Eval( M ), 13 );
                   elif nar > 2 then
                       ## compute N and U: (1+4)
                       N := NormalFormIntMat( Eval( M ), 5 );
                   else
                       ## compute N only: (1)
                       N := NormalFormIntMat( Eval( M ), 1 );
                   fi;
                   
                   # return U:
                   if nar > 2 then
                       SetEval( arg[2], N.rowtrans );
                   fi;
                   
                   # return V;
                   if nar > 3 then
                       SetEval( arg[3], N.coltrans );
                   fi;
                   
                   S := MatrixForHomalg( N.normal );
                   
                   SetRankOfMatrix( S, N.rank );
                   
                   return S;
                   
                 end,
               
               ## Must be defined if other functions are not defined
               TriangularBasis :=
                 function( arg )
                   local M, nar, N, H;
                   
                   M := arg[1];
                   
                   nar := Length( arg );
                   
                   # R := arg[nar];
                   
                   if nar > 3 then
                       ## compute N, U, and V: (0+2+4+8)
                       N := NormalFormIntMat( Eval( M ), 14 );
                   elif nar > 2 then
                       ## compute N and U: (0+2+4)
                       N := NormalFormIntMat( Eval( M ), 6 );
                   else
                       ## compute N only: (0+2)
                       N := NormalFormIntMat( Eval( M ), 2 );
                   fi;
                   
                   # return U:
                   if nar > 2 then
                       SetEval( arg[2], N.rowtrans );
                   fi;
                   
                   # return V;
                   if nar > 3 then
                       SetEval( arg[3], N.coltrans );
                   fi;
                   
                   H := MatrixForHomalg( N.normal );
                   
                   SetRankOfMatrix( H, N.rank );
                   
                   return H;
                   
                 end
          );
                 
    Objectify( HomalgTableType, RP );
    
    return RP;
    
end );
