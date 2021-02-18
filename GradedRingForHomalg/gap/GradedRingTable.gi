# SPDX-License-Identifier: GPL-2.0-or-later
# GradedRingForHomalg: Endow Commutative Rings with an Abelian Grading
#
# Implementations
#

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( CreateHomalgTableForGradedRings,
  function( R )
    local RP;
    
    RP := rec(
              Zero := Zero( R ),
              
              One := One( R ),
              
              MinusOne := MinusOne( R ),
              );
    
    ## RP_General
    AppendToAhomalgTable( RP, CommonHomalgTableForGradedRings );
    
    ## RP_Basic
    AppendToAhomalgTable( RP, CommonHomalgTableForGradedRingsBasic );
    
    ## RP_Tools
    AppendToAhomalgTable( RP, CommonHomalgTableForGradedRingsTools );
    
    ## Objectify
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );

