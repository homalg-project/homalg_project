#############################################################################
##
##  MAGMATools.gi               Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementations for the rings provided by MAGMA.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( SheavesHomalgTableForMAGMATools,
        
        rec(
               MonomialMatrix :=
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "Matrix(1,MonomialsOfDegree(", R, i, ",{", R, ".i : i in [ 1 .. Rank(", R, ")]} diff {", vars, "}))" ], "break_lists", HOMALG_IO.Pictograms.MonomialMatrix );
                   
                 end,
               
        )
 );

## enrich the global homalg table for MAGMA:
AddToAhomalgTable( CommonHomalgTableForMAGMATools, SheavesHomalgTableForMAGMATools );
