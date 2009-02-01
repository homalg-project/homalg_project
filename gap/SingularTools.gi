#############################################################################
##
##  SingularTools.gi            Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementations for the rings provided by Singular.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( SheavesHomalgTableForSingularTools,
        
        rec(
               MonomialMatrix :=
                 function( i, R )
                   
                   return homalgSendBlocking( [ "matrix(maxideal(", i, "))" ], [ "matrix" ], R, HOMALG_IO.Pictograms.MonomialMatrix );
                   
                 end,
               
               
        )
 );

## enrich the global homalg table for Singular:
AddToAhomalgTable( CommonHomalgTableForSingularTools, SheavesHomalgTableForSingularTools );
