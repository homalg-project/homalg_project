# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the external rings provided by the GAP package homalg.

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for rings provided by the gap package homalg",
        [ IsHomalgExternalRingObjectInGAPRep
          and IsPrincipalIdealRing ],
        
  function( ext_ring_obj )
    local RP, RP_Basic, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForGAPHomalgTools );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForGAPHomalgBasic );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForGAPHomalgBestBasis );
    
    RP_specific :=
          rec(
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               ElementaryDivisors :=
                 function( arg )
                   local M, R;
                   
                   M:=arg[1];
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "ElementaryDivisors(", M, ")" ], "need_output", "ElementaryDivisors" );
                   
                 end,
               
               RowRankOfMatrixOverDomain :=
                 function( M )
                     
                     return Int( homalgSendBlocking( [ "RowRankOfMatrix(", M, ")" ], "need_output" ) );
                     
                 end,
               
               ## Must be defined if other functions are not defined
               
               ReducedRowEchelonForm :=
                 function( arg )
                   local M, R, nargs, N, U;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberColumns( M ), R );
                   
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not ReducedRowEchelonForm( M, "" )
                       # assign U:
                       U := arg[2];
                       SetNumberRows( U, NumberRows( M ) );
                       SetNumberColumns( U, NumberRows( M ) );
                       SetIsInvertibleMatrix( U, true );
                       
                       ## compute N and U:
                       homalgSendBlocking( [ U, ":=HomalgVoidMatrix(", R, ");;", N, ":=ReducedRowEchelonForm(", M, U, ")" ], "need_command", "ReducedEchelonFormC" );
                   else
                       ## compute N only:
                       homalgSendBlocking( [ N, ":=ReducedRowEchelonForm(", M, ")" ], "need_command", "ReducedEchelonForm" );
                   fi;
                   
                   SetIsUpperStairCaseMatrix( N, true );
                   
                   return N;
                   
                 end
               
          );
    
    if homalgSendBlocking( [ "IsBound(homalgTable(", ext_ring_obj, ")!.BestBasis)" ], "need_output", "initialize" ) = "true" then
        for component in NamesOfComponents( RP_BestBasis ) do
            RP.(component) := RP_BestBasis.(component);
        od;
    fi;
    
    for component in NamesOfComponents( RP_Basic ) do
        RP.(component) := RP_Basic.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );

##
InstallMethod( CreateHomalgTable,
        "for rings provided by the gap package homalg",
        [ IsHomalgExternalRingObjectInGAPRep ],
        
  function( ext_ring_obj )
    local RP;
    
    RP := rec( );
    
    ## RP_General
    AppendToAhomalgTable( RP, CommonHomalgTableForRings );
    
    ## RP_Tools
    AppendToAhomalgTable( RP, CommonHomalgTableForGAPHomalgTools );
    
    ## RP_Basic
    AppendToAhomalgTable( RP, CommonHomalgTableForGAPHomalgBasic );
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
