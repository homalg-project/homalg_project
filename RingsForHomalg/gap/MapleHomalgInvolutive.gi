# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the rings provided by the Maple package Involutive
##  accessed via the Maple implementation of homalg.

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for homalg rings provided by the maple package Involutive",
        [ IsHomalgExternalRingObjectInMapleUsingInvolutiveRep ],
        
  function( ext_ring_obj )
    local RP, RP_Basic, RP_General, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForMapleHomalgTools );
    
    RP_General := ShallowCopy( CommonHomalgTableForRings );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForMapleHomalgBasic );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForMapleHomalgBestBasis );
    
    RP_specific :=
          rec(
               
               Inequalities :=
                 function( R )
                   local v, l;
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ v, "l:=PolZeroSets()" ], R, "need_command", "Inequalities" );
                   
                   l := Int( homalgSendBlocking( [ "nops(", v, "l)" ], R, "need_output", "Inequalities" ) );
                   
                   l := List( [ 1 .. l ], i -> homalgSendBlocking( [ v, "l[", i, "]" ], R, "Inequalities" ) );
                   
                   return List( l, a -> HomalgExternalRingElement( a, R ) );
                   
               end,
               
          );
    
    for component in NamesOfComponents( RP_General ) do
        RP.(component) := RP_General.(component);
    od;
    
    for component in NamesOfComponents( RP_Basic ) do
        RP.(component) := RP_Basic.(component);
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
