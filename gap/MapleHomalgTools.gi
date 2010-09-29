#############################################################################
##
##  MapleHomalgTools.gi         Graded package              Mohamed Barakat
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

InstallValue( GradedRingTableForMapleHomalgTools,
        
        rec(
               MonomialMatrix :=
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "`homalg/MonomialMatrix`(", i, vars, R, ")" ], HOMALG_IO.Pictograms.MonomialMatrix );
                   
                 end,
               
               Eliminate :=
                 function( rel, indets, R )
                   
                   return homalgSendBlocking( [ R, "[-1][matrix](map(a->[a],convert(eliminate({", rel, "},{", indets, "})[2],list)))" ], "break_lists", HOMALG_IO.Pictograms.Eliminate );
                   
                 end,
               
        )
 );

## enrich the global homalg table for MapleHomalg:
AddToAhomalgTable( CommonHomalgTableForMapleHomalgTools, GradedRingTableForMapleHomalgTools );
