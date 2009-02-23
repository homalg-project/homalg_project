#############################################################################
##
##  MapleHomalgTools.gi         Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementations for the rings provided by the Maple implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( SheavesHomalgTableForMapleHomalgTools,
        
        rec(
               MonomialMatrix :=
                 function( i, R )
                   
                   return homalgSendBlocking( [ "`homalg/MonomialMatrix`(", i, R, ")" ], HOMALG_IO.Pictograms.MonomialMatrix );
                   
                 end,
               
        )
 );

## enrich the global homalg table for MapleHomalg:
AddToAhomalgTable( CommonHomalgTableForMapleHomalgTools, SheavesHomalgTableForMapleHomalgTools );
