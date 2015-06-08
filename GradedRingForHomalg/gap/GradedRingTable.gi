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

