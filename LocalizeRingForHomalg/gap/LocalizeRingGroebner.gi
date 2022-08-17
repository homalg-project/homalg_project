# SPDX-License-Identifier: GPL-2.0-or-later
# LocalizeRingForHomalg: A Package for Localization of Polynomial Rings
#
# Implementations
#

##  Implementations for Groebner basis related computations of local rings.

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

