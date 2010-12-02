#############################################################################
##
##  Macaulay2Tools.gi       GradedRingForHomalg package      Mohamed Barakat
##                                                            Daniel Robertz
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##  Copyright 2007-2009, Daniel Robertz, RWTH Aachen University
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
Macaulay2Macros.NonTrivialDegreePerRow := "\n\
NonTrivialDegreePerRow = M -> ( local n,p;\n\
  n = numgens(source M)-1;\n\
  concatenate between(\",\", apply(\n\
    for r in entries(M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {sum degree r#j} );\n\
      if p == {} then 0 else p#0\n\
    ), toString))\n\
)\n\n";

##
Macaulay2Macros.NonTrivialWeightedDegreePerRow := "\n\
NonTrivialWeightedDegreePerRow = (M,weights,R) -> ( local n,p;\n\
  n = numgens(source M)-1;\n\
  concatenate between(\",\", apply(\n\
    for r in entries(M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {Deg(r#j,weights,R)} );\n\
      if p == {} then 0 else p#0\n\
    ), toString))\n\
)\n\n";

##
Macaulay2Macros.NonTrivialDegreePerRowWithColPosition := "\n\
NonTrivialDegreePerRowWithColPosition = M -> ( local n,p;\n\
  n = numgens(source M)-1;\n\
  concatenate({\"[\"} | between(\",\",\n\
    for r in entries(M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {concatenate({\"[\", toString(sum degree r#j), \",\", toString(j+1), \"]\"})} );\n\
      if p == {} then \"[0,0]\" else p#0\n\
    )) | {\"]\"})\n\
)\n\n";

##
Macaulay2Macros.NonTrivialWeightedDegreePerRowWithColPosition := "\n\
NonTrivialWeightedDegreePerRowWithColPosition = (M,weights,R) -> ( local n,p;\n\
  n = numgens(source M)-1;\n\
  concatenate({\"[\"} | between(\",\",\n\
    for r in entries(M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {concatenate({\"[\", toString(Deg(r#j,weights,R)), \",\", toString(j+1), \"]\"})} );\n\
      if p == {} then \"[0,0]\" else p#0\n\
    )) | {\"]\"})\n\
)\n\n";

##
Macaulay2Macros.NonTrivialDegreePerColumn := "\n\
NonTrivialDegreePerColumn = M -> ( local n,p;\n\
  n = numgens(target M)-1;\n\
  concatenate between(\",\", apply(\n\
    for r in entries(transpose M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {sum degree r#j} );\n\
      if p == {} then 0 else p#0\n\
    ), toString))\n\
)\n\n";

##
Macaulay2Macros.NonTrivialWeightedDegreePerColumn := "\n\
NonTrivialWeightedDegreePerColumn = (M,weights,R) -> ( local n,p;\n\
  n = numgens(target M)-1;\n\
  concatenate between(\",\", apply(\n\
    for r in entries(transpose M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {Deg(r#j,weights,R)} );\n\
      if p == {} then 0 else p#0\n\
    ), toString))\n\
)\n\n";

##
Macaulay2Macros.NonTrivialDegreePerColumnWithRowPosition := "\n\
NonTrivialDegreePerColumnWithRowPosition = M -> ( local n,p;\n\
  n = numgens(target M)-1;\n\
  concatenate({\"[\"} | between(\",\",\n\
    for r in entries(transpose M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {concatenate({\"[\", toString(sum degree r#j), \",\", toString(j+1), \"]\"})} );\n\
      if p == {} then \"[0,0]\" else p#0\n\
    )) | {\"]\"})\n\
)\n\n";

##
Macaulay2Macros.NonTrivialWeightedDegreePerColumnWithRowPosition := "\n\
NonTrivialWeightedDegreePerColumnWithRowPosition = (M,weights,R) -> ( local n,p;\n\
  n = numgens(target M)-1;\n\
  concatenate({\"[\"} | between(\",\",\n\
    for r in entries(transpose M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {concatenate({\"[\", toString(Deg(r#j,weights,R)), \",\", toString(j+1), \"]\"})} );\n\
      if p == {} then \"[0,0]\" else p#0\n\
    )) | {\"]\"})\n\
)\n\n";

##
InstallValue( GradedRingTableForMacaulay2Tools,
        
        rec(
               NonTrivialDegreePerRow :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "NonTrivialDegreePerRow( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerRow );
                   
                   return StringToIntList( L );
                   
                 end,
               
               NonTrivialWeightedDegreePerRow :=
                 function( M, weights )
                   local L;
                   
                   L := homalgSendBlocking( [ "NonTrivialWeightedDegreePerRow(", M, ", {", weights, "}, ", HomalgRing( M ), ")" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerRow );
                   
                   return StringToIntList( L );
                   
                 end,
               
               NonTrivialDegreePerRowWithColPosition :=
                 function( M )
                   
                   return TransposedMat( EvalString( homalgSendBlocking( [ "NonTrivialDegreePerRowWithColPosition( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerRow ) ) );
                   
                 end,
               
               NonTrivialWeightedDegreePerRowWithColPosition :=
                 function( M, weights )
                   
                   return TransposedMat( EvalString( homalgSendBlocking( [ "NonTrivialWeightedDegreePerRowWithColPosition(", M, ", {", weights, "}, ", HomalgRing( M ), ")" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerRow ) ) );
                   
                 end,
               
               NonTrivialDegreePerColumn :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "NonTrivialDegreePerColumn( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerColumn );
                   
                   return StringToIntList( L );
                   
                 end,
               
               NonTrivialWeightedDegreePerColumn :=
                 function( M, weights )
                   local L;
                   
                   L := homalgSendBlocking( [ "NonTrivialWeightedDegreePerColumn(", M, ", {", weights, "}, ", HomalgRing( M ), ")" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerColumn );
                   
                   return StringToIntList( L );
                   
                 end,
               
               NonTrivialDegreePerColumnWithRowPosition :=
                 function( M )
                   
                   return TransposedMat( EvalString( homalgSendBlocking( [ "NonTrivialDegreePerColumnWithRowPosition( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerColumn ) ) );
                   
                 end,
               
               NonTrivialWeightedDegreePerColumnWithRowPosition :=
                 function( M, weights )
                   
                   return TransposedMat( EvalString( homalgSendBlocking( [ "NonTrivialWeightedDegreePerColumnWithRowPosition(", M, ", {", weights, "}, ", HomalgRing( M ), ")" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerColumn ) ) );
                   
                 end,
               
               MonomialMatrix :=
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "map(", R, "^(binomial(", i, "+#(", vars, ")-1,", i, ")),", R, "^1,transpose gens((ideal(", vars, "))^", i, "))" ], "break_lists", R, HOMALG_IO.Pictograms.MonomialMatrix );
                   
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
AddToAhomalgTable( CommonHomalgTableForMacaulay2Tools, GradedRingTableForMacaulay2Tools );
