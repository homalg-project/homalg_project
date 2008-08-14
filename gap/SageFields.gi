#############################################################################
##
##  SageFields.gd              RingsForHomalg package            Simon Goertzen
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for GF(p) and Q in Sage.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for GF(p) and Q in Sage",
        [ IsHomalgExternalRingObjectInSageRep
          and IsFieldForHomalg ],
        
  function( ext_ring_obj )
    local RP, command, RP_specific, component;
    
    InitializeSageTools( ext_ring_obj );
    RP := ShallowCopy( CommonHomalgTableForSageTools );
    
    command := Concatenation(           
            
            "def TriangularBasisOfRows_NU(M):\n",
            "  MId = block_matrix([M,identity_matrix(M.base_ring(),M.nrows())],1,2)\n",
            "  MId.echelonize()\n",
            "  N = MId.matrix_from_columns(range( M.ncols() ))\n",
            "  U = MId.matrix_from_columns(range( M.ncols(), M.ncols() + M.nrows()))\n",
            "  return N, U\n\n",
                 
            "def TriangularBasisOfRows_N_only(M):\n",
            "  return M.echelon_form()\n\n"
            
            );
    
    homalgSendBlocking( [ command ], "need_command", ext_ring_obj, HOMALG_IO.Pictograms.define ); ## the last procedures to initialize
    
    RP_specific :=
          rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               RowRankOfMatrix :=
                 function( M )
                     
                     return Int( homalgSendBlocking( [  M, ".rank()" ], "need_output" ) );
                     
                 end,
               
               ## Must be defined if other functions are not defined
               
               TriangularBasisOfRows :=
                 function( arg )
                   local M, R, nargs, N, U, rank_of_N;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   N := HomalgVoidMatrix( NrRows( M ), NrColumns( M ), R );
                   
                   SetIsUpperTriangularMatrix( N, true );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not TriangularBasisOfRows( M, "" )
                       # assign U:
                       U := arg[2];
                       SetNrRows( U, NrRows( M ) );
                       SetNrColumns( U, NrRows( M ) );
                       SetIsInvertibleMatrix( U, true );
                       
                       ## compute N and U:
                       rank_of_N := StringToInt( homalgSendBlocking( [ N, U, "=TriangularBasisOfRows_NU(", M, "); ", N, ".rank()" ], "need_output", HOMALG_IO.Pictograms.TriangularBasisC ) );
                   else
                       ## compute N only:
                       rank_of_N := StringToInt( homalgSendBlocking( [ N, "=TriangularBasisOfRows_N_only(", M, "); ", N, ".rank()" ], "need_output", HOMALG_IO.Pictograms.TriangularBasis ) );
                   fi;
                   
                   SetRowRankOfMatrix( N, rank_of_N );
                   
                   return N;
                   
                 end
               
          );
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
