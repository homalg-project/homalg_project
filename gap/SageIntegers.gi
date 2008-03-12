#############################################################################
##
##  SageIntegers.gi             sage rings for homalg          Simon Görtzen
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the sage integers.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for Sage Integers",
        [ IsHomalgExternalObjectRep
          and IsHomalgExternalObjectWithIOStream
          and IsSageIntegers ],
        
  function( arg )
    local RP, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForSageTools );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForSageBestBasis );
    
    RP_specific :=
          rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (HomalgTable gives no default value)
               
               RingName := "Z",
               
               ElementaryDivisors :=
                 function( arg )
                   local M, R;
                   
                   M:=arg[1];
		   
		   R := HomalgRing( M );
                   
                   HomalgSendBlocking( [ "_tmp = ", M, ".transpose()" ], "need_command" );
                   HomalgSendBlocking( [ "_tmp = _tmp.elementary_divisors()" ], "need_command", R );
		   return HomalgSendBlocking( [ "_tmp" ], "need_output", R );
                   
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
                       HomalgSendBlocking( [ "_N,_U = ", M, ".dense_matrix().echelon_form(transformation=True)" ], "need_command" );
                       HomalgSendBlocking( [ "_N = _N.sparse_matrix()" ], "need_command", R );
                       rank_of_N := Int( HomalgSendBlocking( [ "_N.rank()" ], "need_output", R ) );
                       N := HomalgSendBlocking( [ "_N" ], R );
                       U := HomalgSendBlocking( [ "_U.sparse_matrix()" ], R );
                       HomalgSendBlocking( [ "_N=0; _U=0;" ], "need_command", R );
                   else
                       ## compute N only:
                       HomalgSendBlocking( [ "_N = ", M, ".echelon_form()" ], "need_command" );
                       HomalgSendBlocking( [ "_N = _N.sparse_matrix()" ], "need_command", R );
                       rank_of_N := Int( HomalgSendBlocking( [ "_N.rank()" ], "need_output", R ) );
                       N := HomalgSendBlocking( [ "_N" ], R );
                       HomalgSendBlocking( [ "_N=0;" ], "need_command", R );
                   fi;
                   
                   # assign U:
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not TriangularBasisOfRows( M, "" )
                       SetEval( arg[2], U );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsInvertibleMatrix( arg[2], true );
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
