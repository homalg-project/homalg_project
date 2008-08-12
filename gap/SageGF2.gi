#############################################################################
##
##  SageGF2.gi                RingsForHomalg package           Simon Görtzen
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the field GF(2) in Sage.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for the finite field GF(2) in Sage",
        [ IsHomalgExternalRingObjectInSageRep
          and IsPrimeField and IsFinite ],

  function( ext_ring_obj )
    local RP, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForSageTools );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForSageBestBasis );
    
    RP_specific :=
          rec(

	       RowRankOfMatrix :=
	         function( M )
		   return homalgSendBlocking( [ M, ".rank()" ], "need_output" );
	         end,
	      
	       ## Must be defined if other functions are not defined
               
               TriangularBasisOfRows :=
                 function( arg )
                   local M, R, nargs, N, rank_of_N, U;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 then
                       ## compute N and U: N = U*M, create M|Id_NrRows(N) and do Gauss there
                       homalgSendBlocking( [ "_Id = identity_matrix(GF(2),", NrRows(M), ").sparse_matrix()" ], "need_command", R );
                       homalgSendBlocking( [ "_MId = block_matrix([", M, ".sparse_matrix(),_Id],2).echelonize()" ], "need_command" );
                       homalgSendBlocking( [ "_N=_MId.matrix_from_columns(range(", NrColumns(M) ,"))"], "need_command", R );
                       rank_of_N := StringToInt( homalgSendBlocking( [ "_N.rank()" ], "need_output", R ) );
                       N := homalgSendBlocking( [ "_N.copy()"], R );
                       U := homalgSendBlocking( [ "_MId.matrix_from_columns(range(", NrColumns(M), ",", NrColumns(M)+NrRows(M), ")).copy()"], R );
                       #homalgSendBlocking( [ "_N=0; _MId=0" ], "need_command", R);
                   else
                       ## compute N only:
                       homalgSendBlocking( [ "_N = ", M, ".echelon_form()" ], "need_command" );
                       homalgSendBlocking( [ "_N = _N.sparse_matrix()" ], "need_command", R );
                       rank_of_N := StringToInt( homalgSendBlocking( [ "_N.rank()" ], "need_output", R ) );
                       N := homalgSendBlocking( [ "_N" ], R );
                       homalgSendBlocking( [ "_N=0;" ], "need_command", R );
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
                   
                 end,
               
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
                   
               MinusOne := HomalgExternalRingElement( "1", "Sage", IsOne ), ## CAUTION: only over GF(2)

          );
    
    for component in NamesOfComponents( RP_BestBasis ) do
        RP.(component) := RP_BestBasis.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
