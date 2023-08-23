# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for homalg rings provided by the maple package PIR",
        [ IsHomalgExternalRingObjectInMapleUsingPIRRep ],
        
  function( ext_ring_obj )
    local RP, RP_General, RP_Basic, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForMapleHomalgTools );
    
    RP_General := ShallowCopy( CommonHomalgTableForRings );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForMapleHomalgBasic );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForMapleHomalgBestBasis );
    
    RP_specific :=
          rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               ElementaryDivisors :=
                 function( M )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "convert(`homalg/DiagonalElementsAndRank`(", R, "[-1][BestBasis](", M, R, "[1]),", R, ")[1],symbol)" ], "need_output" );
                   
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
                       homalgSendBlocking( [ N, " := ", R, "[-1][ReducedEchelonForm](", M, R, "[1],", U, ")" ], "need_command", "ReducedEchelonFormC" );
                   else
                       ## compute N only:
                       homalgSendBlocking( [ N, " := ", R, "[-1][ReducedEchelonForm](", M, R, "[1])" ], "need_command", "ReducedEchelonForm" );
                   fi;
                   
                   SetIsUpperStairCaseMatrix( N, true );
                   
                   return N;
                   
                 end
               
          );
    
    for component in NamesOfComponents( RP_General ) do
        RP.(component) := RP_General.(component);
    od;
    
    for component in NamesOfComponents( RP_Basic ) do
        RP.(component) := RP_Basic.(component);
    od;
    
    for component in NamesOfComponents( RP_BestBasis ) do
        if component = "BestBasis" then
            RP.BestBasis :=
              function( arg )
                local S;
                S := CallFuncList( RP_BestBasis.BestBasis, arg );
                SetIsDiagonalMatrix( S, true );
                return S;
            end;
        else
            RP.(component) := RP_BestBasis.(component);
        fi;
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
