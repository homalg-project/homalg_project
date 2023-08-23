# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Implementations
#

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
                       SetNumberRows( arg[2], NumberRows( M ) );
                       SetNumberColumns( arg[2], NumberRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   fi;
                   
                   # assign V:
                   if nargs > 2 and IsHomalgMatrix( arg[3] ) then ## not BestBasis( M, U, "" )
                       SetEval( arg[3], homalgInternalMatrixHull( N.coltrans ) );
                       ResetFilterObj( arg[3], IsVoidMatrix );
                       SetNumberRows( arg[3], NumberColumns( M ) );
                       SetNumberColumns( arg[3], NumberColumns( M ) );
                       SetIsInvertibleMatrix( arg[3], true );
                   fi;
                   
                   S := HomalgMatrix( N.normal, R );
                   
                   SetNumberRows( S, NumberRows( M ) );
                   SetNumberColumns( S, NumberColumns( M ) );
                   SetZeroRows( S, [ N.rank + 1 .. NumberRows( S ) ] );
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
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only primary decomposition of one-column matrices is supported\n" );
                   fi;
                   
                   R := HomalgRing( mat );
                   
                   ## an empty matrix is excluded by the high-level procedure
                   mat := BasisOfRows( mat );
                   
                   fac := Collected( FactorsInt( AbsInt( mat[ 1, 1 ] ) ) );
                   
                   return List( fac, a -> [ HomalgMatrix( [ a[1]^a[2] ], 1, 1, R ), HomalgMatrix( [ a[1] ], 1, 1, R ) ] );
                   
                 end,
               
               RadicalDecomposition :=
                 function( mat )
                   local R, fac;
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only primary decomposition of one-column matrices is supported\n" );
                   fi;
                   
                   R := HomalgRing( mat );
                   
                   ## an empty matrix is excluded by the high-level procedure
                   mat := BasisOfRows( mat );
                   
                   fac := PrimeDivisors( AbsInt( mat[ 1, 1 ] ) );
                   
                   return List( fac, a -> HomalgMatrix( [ a ], 1, 1, R ) );
                   
                 end,
               
               RadicalSubobject :=
                 function( mat )
                   local rad;
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only radical of one-column matrices is supported\n" );
                   fi;
                   
                   ## an empty matrix is excluded by the high-level procedure
                   mat := BasisOfRows( mat );
                   
                   rad := Product( PrimeDivisors( AbsInt( mat[ 1, 1 ] ) ) );
                   
                   return homalgInternalMatrixHull( [ [ rad ] ] );
                   
                 end,
               
               Eliminate :=
                 function( rel, indets, R )
                   
                   return homalgInternalMatrixHull( List( rel, a -> [ a ] ) );
                   
                 end,
               
               ## Must be defined if other functions are not defined
               
               ReducedRowEchelonForm :=
                 function( arg )
                   local M, R, nargs, N, H;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not ReducedRowEchelonForm( M, "" )
                       ## compute N and U: (0+2+4)
                       N := NormalFormIntMat( Eval( M )!.matrix, 6 );
                       
                       # assign U:
                       SetEval( arg[2], homalgInternalMatrixHull( N.rowtrans ) );
                       ResetFilterObj( arg[2], IsVoidMatrix );
                       SetNumberRows( arg[2], NumberRows( M ) );
                       SetNumberColumns( arg[2], NumberRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
                   else
                       ## compute N only: (0+2)
                       N := NormalFormIntMat( Eval( M )!.matrix, 2 );
                   fi;
                   
                   H := HomalgMatrix( N.normal, R );
                   
                   SetNumberRows( H, NumberRows( M ) );
                   SetNumberColumns( H, NumberColumns( M ) );
                   SetZeroRows( H, [ N.rank + 1 .. NumberRows( H ) ] );
                   
                   SetIsUpperStairCaseMatrix( H, true );
                   
                   return H;
                   
                 end
                 
          );
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );

## create a globally defined ring of integers
HOMALG_MATRICES.ZZ := HomalgRingOfIntegers( );
