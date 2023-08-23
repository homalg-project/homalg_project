# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for GF(p) and Q in Sage.

####################################
#
# global variables:
#
####################################

##
SageMacros.ReducedRowEchelonForm_NU_Fields := "\n\
def ReducedRowEchelonForm_NU_Fields(M):\n\
  MId = block_matrix([M,identity_matrix(M.base_ring(),M.nrows())],1,2)\n\
  MId.echelonize()\n\
  N = MId.matrix_from_columns(range( M.ncols() ))\n\
  U = MId.matrix_from_columns(range( M.ncols(), M.ncols() + M.nrows()))\n\
  return N, U\n\n";

SageMacros.ReducedRowEchelonForm_Fields := "\n\
def ReducedRowEchelonForm_Fields(M):\n\
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
               
               ReducedRowEchelonForm :=
                 function( arg )
                   local M, R, nargs, N, U;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   N := HomalgVoidMatrix( NumberRows( M ), NumberColumns( M ), R );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not ReducedRowEchelonForm( M, "" )
                       # assign U:
                       U := arg[2];
                       SetNumberRows( U, NumberRows( M ) );
                       SetNumberColumns( U, NumberRows( M ) );
                       SetIsInvertibleMatrix( U, true );
                       
                       ## compute N and U:
                       homalgSendBlocking( [ N, U, "=ReducedRowEchelonForm_NU_Fields(", M, ")" ], "need_command", "ReducedEchelonFormC" );
                   else
                       ## compute N only:
                       homalgSendBlocking( [ N, "=ReducedRowEchelonForm_Fields(", M, ")" ], "need_command", "ReducedEchelonForm" );
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
