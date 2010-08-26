#############################################################################
##
##  GradedRingTable.gi      GradedRingForHomalg package      Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for graded rings.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( CreateHomalgTableForGradedRings,
  function( R )
    local RP, RP_General, RP_Basic, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForGradedRingsTools );
    
    RP_General := ShallowCopy( CommonHomalgTableForGradedRings );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForGradedRingsBasic );
    
    RP_specific := rec (

                        Zero := Zero( R ),

                        One := One( R ),

                        MinusOne := MinusOne( R ),
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

