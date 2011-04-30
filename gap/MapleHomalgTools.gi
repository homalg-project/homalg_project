#############################################################################
##
##  MapleHomalgTools.gi                          GradedRingForHomalg package
##
##  Copyright 2009-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for the rings provided by the Maple implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

##
InstallValue( GradedRingMacrosForMaple,
        rec(
            
    _CAS_name := "Maple",
    
    _Identifier := "GradedRingForHomalg",
    
    DegreesOfEntries := "\n\
DegreesOfEntries := proc(M)\n\
  local m;\n\
  m := convert(M,listlist);\n\
  m := map(op,m);\n\
  m := map(degree,m);\n\
  m := map(a->if a = -infinity then -1 else a fi,m);\n\
  RETURN(m);\n\
end:\n\n",

    )

);

##
UpdateMacrosOfCAS( GradedRingMacrosForMaple, MapleMacros );
UpdateMacrosOfLaunchedCASs( GradedRingMacrosForMaple );

##
InstallValue( GradedRingTableForMapleHomalgTools,
        
        rec(
               DegreeOfRingElement :=
                 function( r, R )
                   local deg;
                   
                   deg := Int( homalgSendBlocking( [ "degree( ", r, " )" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                   if deg <> fail then
                       return deg;
                   fi;
                   
                   return -1;
                   
                 end,
               
               WeightedDegreeOfRingElement :=
                 function( r, weights, R )
                   local deg, var;
                   
                   if Set( weights ) <> [ 0, 1 ] then	## there is no direct way to compute the weighted degree in Maple
                       TryNextMethod( );
                   fi;
                   
                   var := Indeterminates( R );
                   
                   var := var{Filtered( [ 1 .. Length( var ) ], p -> weights[p] = 1 )};
                   
                   deg := Int( homalgSendBlocking( [ "degree(", r, var, ")" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                   if deg <> fail then
                       return deg;
                   fi;
                   
                   return -1;
                   
                 end,
               
               DegreesOfEntries :=
                 function( M )
                   local R, list_string, L;
                   
                   R := HomalgRing( M );
                   
                   list_string := homalgSendBlocking( [ "DegreesOfEntries(`homalg/ReduceRingElements`(", M, R, "))" ], "need_output", HOMALG_IO.Pictograms.DegreesOfEntries );
                   
                   L :=  StringToIntList( list_string );
                   
                   return ListToListList( L, NrRows( M ), NrColumns( M ) );
                   
                 end,
               
               MonomialMatrix :=
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "`homalg/MonomialMatrix`(", i, vars, R, ")" ], HOMALG_IO.Pictograms.MonomialMatrix );
                   
                 end,
               
        )
 );

## enrich the global and the created homalg tables for MapleHomalg:
AppendToAhomalgTable( CommonHomalgTableForMapleHomalgTools, GradedRingTableForMapleHomalgTools );
AppendTohomalgTablesOfCreatedExternalRings( GradedRingTableForMapleHomalgTools, IsHomalgExternalRingInMapleRep );
