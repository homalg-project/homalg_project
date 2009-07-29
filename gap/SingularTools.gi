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
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "matrix(ideal(", vars, ")^", i, ")" ], [ "matrix" ], R, HOMALG_IO.Pictograms.MonomialMatrix );
                   
                 end,
               
               Eliminate :=
                 function( rel, indets, R )
                   local elim;
                   
                   elim := Iterated( indets, \* );
                   
                   return homalgSendBlocking( [ "matrix(eliminate(ideal(", rel, "),", elim, "))" ], [ "matrix" ], R, HOMALG_IO.Pictograms.Eliminate );
                   
                 end,
               
        )
 );

## enrich the global homalg table for Singular:
AddToAhomalgTable( CommonHomalgTableForSingularTools, SheavesHomalgTableForSingularTools );
