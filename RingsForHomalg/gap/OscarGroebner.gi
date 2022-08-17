# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for Groebner basis related computations in Oscar.

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for homalg rings with Groebner basis computations provided by Oscar",
        [ IsHomalgExternalRingObjectInOscarRep ],
        
  function( ext_ring_obj )
    local RP, RP_General, RP_Basic, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForOscarTools );
    
    RP_General := ShallowCopy( CommonHomalgTableForRings );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForOscarBasic );
    
#    RP_BestBasis := ShallowCopy( CommonHomalgTableForOscarBestBasis );
    
    RP_specific := rec( );
    
    for component in NamesOfComponents( RP_General ) do
        RP.(component) := RP_General.(component);
    od;
    
    for component in NamesOfComponents( RP_Basic ) do
        RP.(component) := RP_Basic.(component);
    od;
    
#todo: insert again, as soon as Singular really computes smith forms
#    if HasPrincipalIdealRing( ext_ring_obj ) and IsPrincipalIdealRing( ext_ring_obj ) then
#      for component in NamesOfComponents( RP_BestBasis ) do
#          RP.(component) := RP_BestBasis.(component);
#      od;
#    fi;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
