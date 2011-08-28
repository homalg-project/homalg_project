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

    WeightedDegreesOfEntries := "\n\
WeightedDegreesOfEntries := proc(M, var)\n\
  local m;\n\
  m := convert(M,listlist);\n\
  m := map(op,m);\n\
  m := map(r->degree(r,var),m);\n\
  m := map(a->if a = -infinity then -1 else a fi,m);\n\
  RETURN(m);\n\
end:\n\n",

    NonTrivialDegreePerRowWithColPosition := "\n\
NonTrivialDegreePerRowWithColPosition := proc(M,r,c)\n\
  local m,i,j,e;\n\
  m := [0$2*r];\n\
  for i in [$1..r] do\n\
    for j in [$1..c] do\n\
      e := M[i,j];\n\
      if e <> 0 then\n\
        m[i] := degree(e); m[r+i] := j; break;\n\
      fi;\n\
    od;\n\
  od;\n\
  RETURN(m);\n\
end:\n\n",
    
    NonTrivialWeightedDegreePerRowWithColPosition := "\n\
NonTrivialWeightedDegreePerRowWithColPosition := proc(M,r,c,var)\n\
  local m,i,j,e;\n\
  m := [0$2*r];\n\
  for i in [$1..r] do\n\
    for j in [$1..c] do\n\
      e := M[i,j];\n\
      if e <> 0 then\n\
        m[i] := degree(e,var); m[r+i] := j; break;\n\
      fi;\n\
    od;\n\
  od;\n\
  RETURN(m);\n\
end:\n\n",
    
    NonTrivialDegreePerColumnWithRowPosition := "\n\
NonTrivialDegreePerColumnWithRowPosition := proc(M,r,c)\n\
  local m,i,j,e;\n\
  m := [0$2*c];\n\
  for j in [$1..c] do\n\
    for i in [$1..r] do\n\
      e := M[i,j];\n\
      if e <> 0 then\n\
        m[j] := degree(e); m[c+j] := i; break;\n\
      fi;\n\
    od;\n\
  od;\n\
  RETURN(m);\n\
end:\n\n",
    
    NonTrivialWeightedDegreePerColumnWithRowPosition := "\n\
NonTrivialWeightedDegreePerColumnWithRowPosition := proc(M,r,c,var)\n\
  local m,i,j,e;\n\
  m := [0$2*c];\n\
  for j in [$1..c] do\n\
    for i in [$1..r] do\n\
      e := M[i,j];\n\
      if e <> 0 then\n\
        m[j] := degree(e,var); m[c+j] := i; break;\n\
      fi;\n\
    od;\n\
  od;\n\
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
                   
                   if Set( weights ) <> [ 0, 1 ] then
                       Error( "there is no direct way to compute the weighted degree in Maple\n" );
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
               
               WeightedDegreesOfEntries :=
                 function( M, weights )
                   local R, var, list_string, L;
                   
                   if Set( weights ) <> [ 0, 1 ] then
                       Error( "there is no direct way to compute the weighted degree in Maple\n" );
                   fi;
                   
                   R := HomalgRing( M );
                   
                   var := Indeterminates( R );
                   
                   var := var{Filtered( [ 1 .. Length( var ) ], p -> weights[p] = 1 )};
                   
                   list_string := homalgSendBlocking( [ "WeightedDegreesOfEntries(`homalg/ReduceRingElements`(", M, R, "),", var, ")" ], "need_output", HOMALG_IO.Pictograms.DegreesOfEntries );
                   
                   L :=  StringToIntList( list_string );
                   
                   return ListToListList( L, NrRows( M ), NrColumns( M ) );
                   
                 end,
               
               NonTrivialDegreePerRowWithColPosition :=
                 function( M )
                   local R, L;
                   
                   R := HomalgRing( M );
                   
                   L := homalgSendBlocking( [ "NonTrivialDegreePerRowWithColPosition(`homalg/ReduceRingElements`(", M, R, "),", NrRows( M ), NrColumns( M ), ")" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerRow );
                   
                   L := StringToIntList( L );
                   
                   return ListToListList( L, 2, NrRows( M ) );
                   
                 end,
               
               NonTrivialWeightedDegreePerRowWithColPosition :=
                 function( M, weights )
                   local R, var, L;
                   
                   if Set( weights ) <> [ 0, 1 ] then
                       Error( "there is no direct way to compute the weighted degree in Maple\n" );
                   fi;
                   
                   R := HomalgRing( M );
                   
                   var := Indeterminates( R );
                   
                   var := var{Filtered( [ 1 .. Length( var ) ], p -> weights[p] = 1 )};
                   
                   L := homalgSendBlocking( [ "NonTrivialWeightedDegreePerRowWithColPosition(`homalg/ReduceRingElements`(", M, R, "),", NrRows( M ), NrColumns( M ), var, ")" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerRow );
                   
                   L := StringToIntList( L );
                   
                   return ListToListList( L, 2, NrRows( M ) );
                   
                 end,
               
               NonTrivialDegreePerColumnWithRowPosition :=
                 function( M )
                   local R, L;
                   
                   R := HomalgRing( M );
                   
                   L := homalgSendBlocking( [ "NonTrivialDegreePerColumnWithRowPosition(`homalg/ReduceRingElements`(", M, R, "),", NrRows( M ), NrColumns( M ), ")" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerColumn );
                   
                   L := StringToIntList( L );
                   
                   return ListToListList( L, 2, NrColumns( M ) );
                   
                 end,
               
               NonTrivialWeightedDegreePerColumnWithRowPosition :=
                 function( M, weights )
                   local R, L, var;
                   
                   if Set( weights ) <> [ 0, 1 ] then
                       Error( "there is no direct way to compute the weighted degree in Maple\n" );
                   fi;
                   
                   R := HomalgRing( M );
                   
                   var := Indeterminates( R );
                   
                   var := var{Filtered( [ 1 .. Length( var ) ], p -> weights[p] = 1 )};
                   
                   L := homalgSendBlocking( [ "NonTrivialWeightedDegreePerColumnWithRowPosition(`homalg/ReduceRingElements`(", M, R, "),", NrRows( M ), NrColumns( M ), var, ")" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerColumn );
                   
                   L := StringToIntList( L );
                   
                   return ListToListList( L, 2, NrColumns( M ) );
                   
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
