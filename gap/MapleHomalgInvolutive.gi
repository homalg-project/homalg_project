#############################################################################
##
##  MapleHomalgInvolutive.gi  RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the rings provided by the Maple package Involutive
##  accessed via the Maple implementation of homalg.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for homalg rings provided by the maple package Involutive",
        [ IsHomalgExternalRingObjectInMapleUsingInvolutiveRep ],
        
  function( arg )
    local RP, RP_default, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForMapleHomalgTools );
    
    RP_default := ShallowCopy( CommonHomalgTableForMapleHomalgDefault );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForMapleHomalgBestBasis );
    
    RP_specific := rec( );
    
    for component in NamesOfComponents( RP_default ) do
        RP.(component) := RP_default.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
