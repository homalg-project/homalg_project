#############################################################################
##
##  MapleHomalgPIR.gi           homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The rings available through the Maple implementation of homalg
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
    local RP;

    RP := rec( 
               
               IsZeroMatrix :=
                 function( M )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return NormalizedWhitespace( HomalgSendBlocking( [ "`homalg/IsZeroMapF`(", M, R, "[1],", R, "[2])" ] , "need_output" ) ) = "true";
                   
                 end,
               
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (HomalgTable gives no default value)
               
               RingName := R -> HomalgSendBlocking( [ "`PIR/Pvar`(", R, "[1])" ], "need_output" ),
               
               BestBasis :=
                 function( arg )
                   local M, R, nargs, S, rank_of_S, U, V;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 then
                       ## compute S, U and (if nargs > 2) V: S = U*M*V
                       HomalgSendBlocking( [ "_S := ", R, "[2][BestBasis](", M, R, "[1],", "_U,_V):" ], "need_command" );
                       rank_of_S := Int( NormalizedWhitespace( HomalgSendBlocking( [ "`homalg/RankOfGauss`(copy(_S),", R,"[2])" ], "need_output" ) ) );
                       S := HomalgSendBlocking( [ "copy(_S)" ], R );
                       U := HomalgSendBlocking( [ "copy(_U)" ], R );
                       V := HomalgSendBlocking( [ "copy(_V)" ], R );
                       HomalgSendBlocking( [ "unassign(_S): unassign(_U): unassign(_V):" ], "need_command", R );
                   else
                       ## compute S only:
                       HomalgSendBlocking( [ "_S := ", R, "[2][BestBasis](", M, R, "[1]):" ], "need_command" );
                       rank_of_S := Int( NormalizedWhitespace( HomalgSendBlocking( [ "`homalg/RankOfGauss`(copy(_S),", R,"[2])" ], "need_output" ) ) );
                       S := HomalgSendBlocking( [ "copy(_S)" ], R );
                       HomalgSendBlocking( [ "unassign(_S):" ], "need_command", R );
                   fi;
                   
                   # assign U:
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not BestBasis( M, "", V )
                       SetEval( arg[2], U );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsFullRowRankMatrix( arg[2], true );
                       SetIsFullColumnRankMatrix( arg[2], true );
                   fi;
                   
                   # assign V:
                   if nargs > 2 and IsHomalgMatrix( arg[3] ) then ## not BestBasis( M, U, "" )
                       SetEval( arg[3], V );
                       SetNrRows( arg[3], NrColumns( M ) );
                       SetNrColumns( arg[3], NrColumns( M ) );
                       SetIsFullRowRankMatrix( arg[3], true );
                       SetIsFullColumnRankMatrix( arg[3], true );
                   fi;
                   
                   S := HomalgMatrix( S, R );
                   
                   SetNrRows( S, NrRows( M ) );
                   SetNrColumns( S, NrColumns( M ) );
                   SetRowRankOfMatrix( S, rank_of_S );
                   SetIsDiagonalMatrix( S, true );
                   
                   return S;
                   
                 end,
               
               ElementaryDivisors :=
                 function( arg )
                   local M;
                   
                   M:=arg[1];
                   
                   return HomalgSendBlocking( [ M, ".elementary_divisors()" ] );
                   
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
                       rank_of_N := Int( NormalizedWhitespace( HomalgSendBlocking( [ "`homalg/RankOfGauss`(copy(_N),", R, "[2])" ], "need_output", R ) ) );
                       N := HomalgSendBlocking( [ "copy(_N)" ], R );
                       U := HomalgSendBlocking( [ "copy(_U)" ], R );
                       HomalgSendBlocking( [ "unassign(_N): unassign(_U)" ], "need_command", R );
                   else
                       ## compute N only:
                       HomalgSendBlocking( [ "_N := ", R, "[2][TriangularBasis](", M, R, "[1])" ], "need_command" );
                       rank_of_N := Int( NormalizedWhitespace( HomalgSendBlocking( [ "`homalg/RankOfGauss`(copy(_N),", R, "[2])" ], "need_output", R ) ) );
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
                   
               True := "true",
               
               Zero := HomalgExternalObject( "0", "Maple" ),
               
               One := HomalgExternalObject( "1", "Maple" ),
               
               MinusOne := HomalgExternalObject( "(-1)", "Maple" ),
               
               AreEqualMatrices :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return NormalizedWhitespace( HomalgSendBlocking( [ "`homalg/IsZeroMapF`(", "`homalg/SubMat`(", A, B, R, "[1],", R, "[2]),", R, "[1],", R, "[2])" ] , "need_output" ) ) = "true";
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return HomalgSendBlocking( [ "`homalg/ZeroMap`(", NrRows( C ), NrColumns( C ), R, "[1],", R, "[2])" ] );
                   
                 end,
             
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return HomalgSendBlocking( [ "`homalg/IdentityMap`(", NrRows( C ), R, "[1],", R, "[2])" ] );
                   
                 end,
               
               Involution :=
                 function( M )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return HomalgSendBlocking( [ "`homalg/Involution`(", M, R, "[1],", R, "[2])" ] );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return HomalgSendBlocking( [ R, "[2][CertainRows](", M, plist, ")" ] );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return HomalgSendBlocking( [ R, "[2][CertainColumns](", M, plist, ")" ] );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ R, "[2][matrix](", R, "[2][UnionOfRows](", A, B, "))" ] );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ R, "[2][matrix](", R, "[2][UnionOfColumns](", A, B, "))" ] );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local R, f;
                   
                   R := HomalgRing( e[1] );
                   
                   f := Concatenation( [ "`homalg/DiagMat`(" ], e, [ R, "[2])" ] );
                   
                   return HomalgSendBlocking( f );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ "`homalg/MulMat`(", a, A, R, "[1],", R, "[2])" ] );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ "`homalg/AddMat`(", A, B, R, "[1],", R, "[2])" ] );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ "`homalg/SubMat`(", A, B, R, "[1],", R, "[2])" ] );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ "`homalg/Compose`(", A, B, R, "[1],", R, "[2])" ] );
                   
                 end,
               
               NrRows :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return Int( NormalizedWhitespace( HomalgSendBlocking( [ R, "[2][NumberOfRows](", C, ")" ], "need_output" ) ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return Int( NormalizedWhitespace( HomalgSendBlocking( [ R, "[2][NumberOfGenerators](", C, ")" ], "need_output" ) ) );
                   
                 end
               
          );
    
    Objectify( HomalgTableType, RP );
    
    return RP;
    
end );
