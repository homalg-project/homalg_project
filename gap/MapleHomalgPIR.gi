#############################################################################
##
##  MapleHomalgPIR.gi           homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
## Implementations for the rings provided by the Maple package PIR
## accessed via the Maple implementation of homalg.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for homalg rings provided by the maple package PIR",
        [ IsHomalgExternalObjectRep
          and IsHomalgExternalObjectWithIOStream
          and IsHomalgPIRMapleRing ],

  function( arg )
    local RP, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForMapleHomalgTools );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForMapleHomalgBestBasis );
    
    RP_specific :=
          rec( 
               
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (HomalgTable gives no default value)
               
               RingName := R -> HomalgSendBlocking( [ "`PIR/Pvar`(", R, "[1])" ], "need_output" ),
               
               ElementaryDivisors :=
                 function( arg )
                   local M, R;
                   
                   M:=arg[1];
                   
                   R := HomalgRing( M );
                   
                   return HomalgSendBlocking( [ "`homalg/DiagonalElementsAndRank`(", R, "[2][BestBasis](", M, R, "[1]),", R, "[1],", R, "[2])[1]" ], "need_output" );
                   
                 end,
                 
               ## Must be defined if other functions are not defined
               
               TriangularBasisOfRows :=
                 function( arg )
                   local M, R, nargs, N, rank_of_N, U;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 then
                       ## compute N and U:
                       HomalgSendBlocking( [ "_N := ", R, "[2][TriangularBasis](", M, R, "[1],", "_U)" ], "need_command" );
                       rank_of_N := Int( HomalgSendBlocking( [ "`homalg/RankOfGauss`(copy(_N),", R, "[2])" ], "need_output", R ) );
                       N := HomalgSendBlocking( [ "copy(_N)" ], R );
                       U := HomalgSendBlocking( [ "copy(_U)" ], R );
                       HomalgSendBlocking( [ "unassign(_N): unassign(_U)" ], "need_command", R );
                   else
                       ## compute N only:
                       HomalgSendBlocking( [ "_N := ", R, "[2][TriangularBasis](", M, R, "[1])" ], "need_command" );
                       rank_of_N := Int( HomalgSendBlocking( [ "`homalg/RankOfGauss`(copy(_N),", R, "[2])" ], "need_output", R ) );
                       N := HomalgSendBlocking( [ "copy(_N)" ], R );
                       HomalgSendBlocking( [ "unassign(_N)" ], "need_command", R );
                   fi;
                   
                   # assign U:
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not TriangularBasisOfRows( M, "" )
                       SetEval( arg[2], U );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsFullRowRankMatrix( arg[2], true );
                       SetIsFullColumnRankMatrix( arg[2], true );
                   fi;
                   
                   N := HomalgMatrix( N, R );
                   
                   SetNrRows( N, NrRows( M ) );
                   SetNrColumns( N, NrColumns( M ) );
                   SetRowRankOfMatrix( N, rank_of_N );
                   
                   if HasIsDiagonalMatrix( M ) and IsDiagonalMatrix( M ) then
                       SetIsDiagonalMatrix( N, true );
                   else
                       SetIsUpperTriangularMatrix( N, true );
                   fi;
                   
                   return N;
                   
                 end,
               
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
                   
               Zero := HomalgExternalObject( "0", "Maple" ),
               
               One := HomalgExternalObject( "1", "Maple" ),
               
               MinusOne := HomalgExternalObject( "(-1)", "Maple" )
               
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
