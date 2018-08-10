#############################################################################
##
##  Integers.gi                 MatricesForHomalg package    Mohamed Barakat
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
        
  function( ring )
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
                       ## compute N, U, and V: (1+4+8)
                       N := NormalFormIntMat( Eval( M )!.matrix, 13 );
                   elif nargs > 1 then
                       ## compute N and U: (1+4)
                       N := NormalFormIntMat( Eval( M )!.matrix, 5 );
                   else
                       ## compute N only: (1)
                       N := NormalFormIntMat( Eval( M )!.matrix, 1 );
                   fi;
                   
                   # assign U:
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not BestBasis( M, "", V )
                       SetEval( arg[2], homalgInternalMatrixHull( N.rowtrans ) );
                       ResetFilterObj( arg[2], IsVoidMatrix );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   fi;
                   
                   # assign V:
                   if nargs > 2 and IsHomalgMatrix( arg[3] ) then ## not BestBasis( M, U, "" )
                       SetEval( arg[3], homalgInternalMatrixHull( N.coltrans ) );
                       ResetFilterObj( arg[3], IsVoidMatrix );
                       SetNrRows( arg[3], NrColumns( M ) );
                       SetNrColumns( arg[3], NrColumns( M ) );
                       SetIsInvertibleMatrix( arg[3], true );
                   fi;
                   
                   S := HomalgMatrix( N.normal, R );
                   
                   SetNrRows( S, NrRows( M ) );
                   SetNrColumns( S, NrColumns( M ) );
                   SetZeroRows( S, [ N.rank + 1 .. NrRows( S ) ] );
                   SetIsDiagonalMatrix( S, true );
                   
                   return S;
                   
                 end,
               
               RowRankOfMatrix :=
                 function( M )
                   
                   return Rank( Eval( M )!.matrix );
                   
                 end,
               
               ElementaryDivisors :=
                 function( arg )
                   local M;
                   
                   M := arg[1];
                   
                   return ElementaryDivisorsMat( Eval( M )!.matrix );
                   
                 end,
               
               Gcd :=
                 function( a, b )
                   
                   return GcdInt( a, b );
                   
                 end,
               
               CancelGcd :=
                 function( a, b )
                   local gcd;
                   
                   gcd := GcdInt( a, b );
                   
                   return [ a / gcd, b / gcd ];
                   
                 end,
               
               PrimaryDecomposition :=
                 function( mat )
                   local R, fac;
                   
                   if not NrColumns( mat ) = 1 then
                       Error( "only primary decomposition of one-column matrices is supported\n" );
                   fi;
                   
                   R := HomalgRing( mat );
                   
                   ## an empty matrix is excluded by the high-level procedure
                   mat := BasisOfRows( mat );
                   
                   fac := Collected( FactorsInt( AbsInt( MatElm( mat, 1, 1 ) ) ) );
                   
                   return List( fac, a -> [ HomalgMatrix( [ a[1]^a[2] ], 1, 1, R ), HomalgMatrix( [ a[1] ], 1, 1, R ) ] );
                   
                 end,
               
               ## Must be defined if other functions are not defined
               
               RowReducedEchelonForm :=
                 function( arg )
                   local M, R, nargs, N, H;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not RowReducedEchelonForm( M, "" )
                       ## compute N and U: (0+2+4)
                       N := NormalFormIntMat( Eval( M )!.matrix, 6 );
                       
                       # assign U:
                       SetEval( arg[2], homalgInternalMatrixHull( N.rowtrans ) );
                       ResetFilterObj( arg[2], IsVoidMatrix );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   else
                       ## compute N only: (0+2)
                       N := NormalFormIntMat( Eval( M )!.matrix, 2 );
                   fi;
                   
                   H := HomalgMatrix( N.normal, R );
                   
                   SetNrRows( H, NrRows( M ) );
                   SetNrColumns( H, NrColumns( M ) );
                   SetZeroRows( H, [ N.rank + 1 .. NrRows( H ) ] );
                   
                   SetIsUpperStairCaseMatrix( H, true );
                   
                   return H;
                   
                 end
                 
          );
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );

## create a globally defined ring of integers
HOMALG_MATRICES.ZZ := HomalgRingOfIntegers( );
