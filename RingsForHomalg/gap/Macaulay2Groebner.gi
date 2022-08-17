# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for Groebner basis related calculations in Macaulay2.

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for homalg rings with Groebner basis computations provided by Macaulay2",
        [ IsHomalgExternalRingObjectInMacaulay2Rep ],
        
  function( ext_ring_obj )
    local RP, RP_General, RP_Basic, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForMacaulay2Tools );
    
    RP_General := ShallowCopy( CommonHomalgTableForRings );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForMacaulay2Basic );
    
    #RP_BestBasis := ShallowCopy( CommonHomalgTableForMacaulay2BestBasis );
    
    RP_specific := rec( );
    
    for component in NamesOfComponents( RP_General ) do
        RP.(component) := RP_General.(component);
    od;
    
    for component in NamesOfComponents( RP_Basic ) do
        RP.(component) := RP_Basic.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
