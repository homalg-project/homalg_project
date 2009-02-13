#############################################################################
##
##  LocalRingGroebner.gi    LocalizeRingForHomalg package    Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for Groebner basis related computations of local rings.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( CreateHomalgTableForLocalizedRings,
        "for polynomial homalg rings with Groebner basis computations",
        [ IsHomalgRing and IsFreePolynomialRing ],
        
  function( globalR )
    local globalRP, RP, RP_General, RP_Basic, RP_specific, component;
    
    globalRP := homalgTable( globalR );
    
    RP := ShallowCopy( CommonHomalgTableForLocalizedRingsTools );
    
    RP_General := ShallowCopy( CommonHomalgTableForLocalizedRings );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForLocalizedRingsBasic );
    
    RP_specific := rec (
                        Zero := globalRP!.Zero,

                        One := globalRP!.One,

                        MinusOne := globalRP!.MinusOne,
                        );
    
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

