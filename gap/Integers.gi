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
               
               RingName := "Z", ## only relevant to the GAP display method of homalg modules
               
               BestBasis := 
                 function( arg )
                   local M, R, nargs, N, S;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 2 then
                       ## compute N, U, and V: (1+4+8)
                       N := NormalFormIntMat( Eval( M ), 13 );
                   elif nargs > 1 then
                       ## compute N and U: (1+4)
                       N := NormalFormIntMat( Eval( M ), 5 );
                   else
                       ## compute N only: (1)
                       N := NormalFormIntMat( Eval( M ), 1 );
                   fi;
                   
                   # assign U:
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not BestBasis( M, "", V )
                       SetEval( arg[2], N.rowtrans );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsFullRowRankMatrix( arg[2], true );
                       SetIsFullColumnRankMatrix( arg[2], true );
                   fi;
                   
                   # assign V:
                   if nargs > 2 and IsHomalgMatrix( arg[3] ) then ## not BestBasis( M, U, "" )
                       SetEval( arg[3], N.coltrans );
                       SetNrRows( arg[3], NrColumns( M ) );
                       SetNrColumns( arg[3], NrColumns( M ) );
                       SetIsFullRowRankMatrix( arg[3], true );
                       SetIsFullColumnRankMatrix( arg[3], true );
                   fi;
                   
                   S := HomalgMatrix( N.normal, R );
                   
                   SetNrRows( S, NrRows( M ) );
                   SetNrColumns( S, NrColumns( M ) );
                   SetRowRankOfMatrix( S, N.rank );
                   SetIsDiagonalMatrix( S, true );
                   
                   return S;
                   
                 end,
               
               ElementaryDivisors :=
                 function( arg )
                   local M;    
                   
                   M := arg[1];
                   
                   return ElementaryDivisorsMat( Eval( M ) );
                   
                 end,
                   
               ## Must be defined if other functions are not defined
                   
               TriangularBasisOfRows :=
                 function( arg )
                   local M, R, nargs, N, H;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 then
                       ## compute N and U: (0+2+4)
                       N := NormalFormIntMat( Eval( M ), 6 );
                   else
                       ## compute N only: (0+2)
                       N := NormalFormIntMat( Eval( M ), 2 );
                   fi;
                   
                   # assign U:
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not TriangularBasisOfRows( M, "" )
                       SetEval( arg[2], N.rowtrans );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsFullRowRankMatrix( arg[2], true );
                       SetIsFullColumnRankMatrix( arg[2], true );
                   fi;
                   
                   H := HomalgMatrix( N.normal, R );
                   
                   SetNrRows( H, NrRows( M ) );
                   SetNrColumns( H, NrColumns( M ) );
                   SetRowRankOfMatrix( H, N.rank );
                   
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
