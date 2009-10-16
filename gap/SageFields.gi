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
            
            "def RowReducedEchelonForm_NU(M):\n",
            "  MId = block_matrix([M,identity_matrix(M.base_ring(),M.nrows())],1,2)\n",
            "  MId.echelonize()\n",
            "  N = MId.matrix_from_columns(range( M.ncols() ))\n",
            "  U = MId.matrix_from_columns(range( M.ncols(), M.ncols() + M.nrows()))\n",
            "  return N, U\n\n",
                 
            "def RowReducedEchelonForm_N_only(M):\n",
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
               
               RowReducedEchelonForm :=
                 function( arg )
                   local M, R, nargs, N, U;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   N := HomalgVoidMatrix( NrRows( M ), NrColumns( M ), R );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not RowReducedEchelonForm( M, "" )
                       # assign U:
                       U := arg[2];
                       SetNrRows( U, NrRows( M ) );
                       SetNrColumns( U, NrRows( M ) );
                       SetIsInvertibleMatrix( U, true );
                       
                       ## compute N and U:
                       homalgSendBlocking( [ N, U, "=RowReducedEchelonForm_NU(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedEchelonFormC );
                   else
                       ## compute N only:
                       homalgSendBlocking( [ N, "=RowReducedEchelonForm_N_only(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedEchelonForm );
                   fi;
                   
                   SetIsUpperStairCaseMatrix( N, true );
                   
                   return N;
                   
                 end
               
          );
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
