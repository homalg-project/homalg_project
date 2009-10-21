#############################################################################
##
##  SageFields.gd             RingsForHomalg package          Simon Goertzen
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for GF(p) and Q in Sage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

##
SageMacros.RowReducedEchelonForm_NU_Fields := "\n\
def RowReducedEchelonForm_NU_Fields(M):\n\
  MId = block_matrix([M,identity_matrix(M.base_ring(),M.nrows())],1,2)\n\
  MId.echelonize()\n\
  N = MId.matrix_from_columns(range( M.ncols() ))\n\
  U = MId.matrix_from_columns(range( M.ncols(), M.ncols() + M.nrows()))\n\
  return N, U\n\n";

SageMacros.RowReducedEchelonForm_Fields := "\n\
def RowReducedEchelonForm_Fields(M):\n\
  return M.echelon_form()\n\n";

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
    local RP, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForSageTools );
    
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
                       homalgSendBlocking( [ N, U, "=RowReducedEchelonForm_NU_Fields(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedEchelonFormC );
                   else
                       ## compute N only:
                       homalgSendBlocking( [ N, "=RowReducedEchelonForm_Fields(", M, ")" ], "need_command", HOMALG_IO.Pictograms.ReducedEchelonForm );
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
