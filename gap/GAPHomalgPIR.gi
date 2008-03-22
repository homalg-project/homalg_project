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
        [ IsHomalgExternalObjectRep
          and IsHomalgExternalObjectWithIOStream
          and IsPIRForHomalgInExternalGAP ],

  function( arg )
    local RP, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForGAPHomalgTools );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForGAPHomalgBestBasis );
    
    RP_specific :=
          rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (HomalgTable gives no default value)
               
               RingName := R -> HomalgSendBlocking( [ "Display(", R, ")" ], "need_output" ),
               
               ElementaryDivisors :=
                 function( arg )
                   local M, R;
                   
                   M:=arg[1];
                   
                   R := HomalgRing( M );
                   
                   return HomalgSendBlocking( [ "HomalgTable(", R, "!.ElementaryDivisors(", M, ")" ], "need_output" );
                   
                 end,
                 
               ## Must be defined if other functions are not defined
               
               TriangularBasisOfRows :=
                 function( arg )
                   local M, R, nargs, N, U, rank_of_N;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   N := HomalgMatrix( "void", NrRows( M ), NrColumns( M ), R );
                   
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
                       rank_of_N := Int( HomalgSendBlocking( [ U, " := HomalgMatrix(\"void\",", R, ");; ", N, " := HomalgTable(", R, ")!.TriangularBasisOfRows(", M, U, ");; RowRankOfMatrix(", N, ")" ], "need_output" ) );
                   else
                       ## compute N only:
                       rank_of_N := Int( HomalgSendBlocking( [ N, " := HomalgTable(", R, ")!.TriangularBasisOfRows(", M, ");; RowRankOfMatrix(", N, ")" ], "need_output" ) );
                   fi;
                   
                   SetRowRankOfMatrix( N, rank_of_N );
                   
                   return N;
                   
                 end
               
          );
    
    for component in NamesOfComponents( RP_BestBasis ) do
        RP.(component) := RP_BestBasis.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( HomalgTableType, RP );
    
    return RP;
    
end );
