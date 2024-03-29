# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#
#
####################################

InstallMethod( CreateHomalgTable,
        "for the ring of integers in Macaulay2",
        [ IsHomalgExternalRingObjectInMacaulay2Rep
          and IsPrincipalIdealRing ],
        
  function( ext_ring_obj )
    local RP, RP_General, RP_Basic, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForMacaulay2Tools );
    
    RP_General := ShallowCopy( CommonHomalgTableForRings );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForMacaulay2Basic );
    
    #RP_BestBasis := ShallowCopy( CommonHomalgTableForMacaulay2BestBasis );
    
    RP_specific :=
          rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               XElementaryDivisors :=
                 function( M )
                   
                   return homalgSendBlocking( [ "ElementaryDivisors(", M, ")" ], "need_output", "ElementaryDivisors" );
                   
                 end,
               
               RowRankOfMatrixOverDomain :=
                 function( M )
                     
                     return Int( homalgSendBlocking( [ "rank(", M, ")" ], "need_output" ) );
                     
                 end,
               
               ## Must be defined if other functions are not defined
               
               XReducedRowEchelonForm :=
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
                       homalgSendBlocking( [ N, U, " := EchelonForm(", M, ")" ], "need_command", "ReducedEchelonFormC" );
                   else
                       ## compute N only:
                       homalgSendBlocking( [ N, " := EchelonForm(", M, ")" ], "need_command", "ReducedEchelonForm" );
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
    
    #for component in NamesOfComponents( RP_BestBasis ) do
    #    RP.(component) := RP_BestBasis.(component);
    #od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
