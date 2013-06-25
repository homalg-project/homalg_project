#############################################################################
##
##  LocalizeRingAtPrime.gi                     LocalizeRingForHomalg package
##
##  Copyright 2013, Mohamed Barakat, University of Kaiserslautern
##                  Vinay Wagh, Indian Institute of Technology Guwahati
##
##  Implementations for localization at prime ideals
##
#############################################################################

## Numerator
HOMALG_IO.Pictograms.Numerator := "num";

## Denominator
HOMALG_IO.Pictograms.Denominator := "den";

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( CreateHomalgTableForLocalizedRingsAtPrimeIdeals,
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
    AppendToAhomalgTable( RP, CommonHomalgTableForLocalizedRingsAtPrimeIdeals );
    
    ## RP_Tools
    AppendToAhomalgTable( RP, CommonHomalgTableForLocalizedRingsAtPrimeIdealsTools );
    
    AppendToAhomalgTable( RP, CommonHomalgTableForHomalgFakeLocalRing );
    
    ## Objectify
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
