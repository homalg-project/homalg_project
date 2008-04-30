#############################################################################
##
##  GAPHomalgPIR.gi           RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the external rings provided by the GAP package homalg.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for rings provided by the gap package homalg",
        [ IsHomalgExternalRingObjectInGAPRep
          and IsPrincipalIdealRing ],
        
  function( arg )
    local RP, RP_default, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForGAPHomalgTools );
    
    RP_default := ShallowCopy( CommonHomalgTableForGAPHomalgDefault );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForGAPHomalgBestBasis );
    
    RP_specific :=
          rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               ElementaryDivisors :=
                 function( arg )
                   local M, R;
                   
                   M:=arg[1];
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "ElementaryDivisors(", M, ")" ], "need_output", "div" );
                   
                 end,
                 
               ## Must be defined if other functions are not defined
               
               TriangularBasisOfRows :=
                 function( arg )
                   local M, R, nargs, N, U, rank_of_N;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), R );
                   
                   if HasIsDiagonalMatrix( M ) and IsDiagonalMatrix( M ) then
                       SetIsDiagonalMatrix( N, true );
                   else
                       SetIsUpperTriangularMatrix( N, true );
                   fi;
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not TriangularBasisOfRows( M, "" )
                       # assign U:
                       U := arg[2];
                       SetNrRows( U, NrRows( M ) );
                       SetNrColumns( U, NrRows( M ) );
                       SetIsInvertibleMatrix( U, true );
                       
                       ## compute N and U:
                       rank_of_N := Int( homalgSendBlocking( [ U, " := HomalgVoidMatrix(", R, ");; ", N, " := TriangularBasisOfRows(", M, U, ");; RowRankOfMatrix(", N, ")" ], "need_output", "TRI" ) );
                   else
                       ## compute N only:
                       rank_of_N := Int( homalgSendBlocking( [ N, " := TriangularBasisOfRows(", M, ");; RowRankOfMatrix(", N, ")" ], "need_output", "TRI" ) );
                   fi;
                   
                   SetRowRankOfMatrix( N, rank_of_N );
                   
                   return N;
                   
                 end
               
          );
    
    for component in NamesOfComponents( RP_BestBasis ) do
        RP.(component) := RP_BestBasis.(component);
    od;
    
    for component in NamesOfComponents( RP_default ) do
        RP.(component) := RP_default.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
