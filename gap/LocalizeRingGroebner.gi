#############################################################################
##
##  LocalizeRingGroebner.gi                    LocalizeRingForHomalg package
##
##  Copyright 2009-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
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
        [ IsHomalgRing and IsCommutative ],
        
  function( globalR )
    local RP, RP_General, RP_Basic, RP_Reduction, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForLocalizedRingsTools );
    
    RP_General := ShallowCopy( CommonHomalgTableForLocalizedRings );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForLocalizedRingsBasic );
    
    RP_Reduction := ShallowCopy( HomalgTableReductionMethodsForLocalizedRingsBasic );
    
    RP_specific := rec (

                        Zero := Zero( globalR ),

                        One := One( globalR ),

                        MinusOne := MinusOne( globalR ),
                        );
    
    for component in NamesOfComponents( RP_General ) do
        RP.(component) := RP_General.(component);
    od;
    
    for component in NamesOfComponents( RP_Basic ) do
        RP.(component) := RP_Basic.(component);
    od;
    
    for component in NamesOfComponents( RP_Reduction ) do
        RP.(component) := RP_Reduction.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );

