# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for Groebner basis related calculations in MAGMA.

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for homalg rings with Groebner basis computations provided by MAGMA",
        [ IsHomalgExternalRingObjectInMAGMARep ],
        
  function( ext_ring_obj )
    local RP, RP_General, RP_Basic, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForMAGMATools );
    
    RP_General := ShallowCopy( CommonHomalgTableForRings );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForMAGMABasic );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForMAGMABestBasis );
    
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
