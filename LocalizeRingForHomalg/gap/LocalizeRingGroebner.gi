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
    local RP;
    
    RP := rec(
              Zero := Zero( globalR ),
              
              One := One( globalR ),
              
              MinusOne := MinusOne( globalR ),
              );
    
    ## RP_General
    AppendToAhomalgTable( RP, CommonHomalgTableForLocalizedRings );
    
    ## RP_Basic
    AppendToAhomalgTable( RP, CommonHomalgTableForLocalizedRingsBasic );
    
    ## RP_Reduction
    AppendToAhomalgTable( RP, HomalgTableReductionMethodsForLocalizedRingsBasic );
    
    ## RP_Tools
    AppendToAhomalgTable( RP, CommonHomalgTableForLocalizedRingsTools );
    
    ## Objectify
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );

