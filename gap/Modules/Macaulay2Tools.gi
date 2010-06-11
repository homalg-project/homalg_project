#############################################################################
##
##  Macaulay2Tools.gi           Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementations for the rings provided by Macaulay2.
##
#############################################################################

####################################
#
# global variables:
#
####################################

##
InstallValue( SheavesHomalgTableForMacaulay2Tools,
        
        rec(
               MonomialMatrix :=
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "map(", R, "^(binomial(", i, "+#(", vars, ")-1,", i, ")),", R, "^1,transpose gens((ideal(", vars, "))^", i, "))" ], "break_lists", R, HOMALG_IO.Pictograms.MonomialMatrix );
                   
                 end,
               
               Eliminate :=
                 function( rel, indets, R )
                   
                   return homalgSendBlocking( [ "transpose gens(eliminate({", indets, "},ideal(", rel, ")))" ], "break_lists", R, HOMALG_IO.Pictograms.Eliminate );
                   
                 end,
               
               Diff :=
                 function( D, N )
                   local R;
                   
                   R := HomalgRing( D );
		   
                   return homalgSendBlocking( [ "map(", R, "^", NrRows( D ) * NrRows( N ), ",", R, "^", NrColumns( D ) * NrColumns( N ), ",diff(", D, N, "))" ], HOMALG_IO.Pictograms.Diff );
                   
                 end,
               
        )
 );

## enrich the global homalg table for Macaulay2:
AddToAhomalgTable( CommonHomalgTableForMacaulay2Tools, SheavesHomalgTableForMacaulay2Tools );
