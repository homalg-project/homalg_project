#############################################################################
##
##  SingularGroebner          RingsForHomalg package          Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for Grobner Basis calculations in Singular            
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for homalg rings with Groebner Basis calculations provided by Singular",
        [ IsHomalgExternalRingObjectInSingularRep ],
        
  function( arg )
    local RP, RP_default, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForSingularTools );
    
    RP_default := ShallowCopy( CommonHomalgTableForSingularDefault );
    
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
