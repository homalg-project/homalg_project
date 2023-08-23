# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the ring of integers in Sage.

####################################
#
# global variables:
#
####################################

##
SageMacros.ElementaryDivisors := "\n\
def ElementaryDivisors(M):\n\
  return M.transpose().elementary_divisors()\n\n";

SageMacros.ReducedRowEchelonForm_NU := "\n\
def ReducedRowEchelonForm_NU(M):\n\
  N, U = M.hermite_form(transformation=True)\n\
  return N, U\n\n";

SageMacros.ReducedRowEchelonForm := "\n\
def ReducedRowEchelonForm(M):\n\
  N = M.hermite_form()\n\
  return N\n\n";

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for the ring of integers in Sage",
        [ IsHomalgExternalRingObjectInSageRep
          and IsPrincipalIdealRing ],
        
  function( ext_ring_obj )
    local RP, RP_General, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForSageTools );
    
    RP_General := ShallowCopy( CommonHomalgTableForRings );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForSageBestBasis );
    
    RP_specific :=
          rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               ElementaryDivisors :=
                 function( arg )
                   local M;
                   
                   M:=arg[1];
                   
                   return homalgSendBlocking( [ "ElementaryDivisors(", M, ")" ], "need_output" );
                   
                 end,
                 
               RowRankOfMatrix :=
                 function( M )
                   
                   return Int( homalgSendBlocking( [ M, ".rank()" ], "need_output" ) );
                   
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
                       homalgSendBlocking( [ N, U, " = ReducedRowEchelonForm_NU(", M, ")" ], "need_command", "ReducedEchelonFormC" );
                   else
                       ## compute N only:
                       homalgSendBlocking( [ N, " = ReducedRowEchelonForm(", M, ")" ], "need_command", "ReducedEchelonForm" );
                   fi;
                   
                   SetIsUpperStairCaseMatrix( N, true );
                   
                   return N;
                   
                 end
               
        );
    
    for component in NamesOfComponents( RP_General ) do
        RP.(component) := RP_General.(component);
    od;
    
    for component in NamesOfComponents( RP_BestBasis ) do
        RP.(component) := RP_BestBasis.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
