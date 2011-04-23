#############################################################################
##
##  Macaulay2Tools.gi                            GradedRingForHomalg package
##
##  Copyright 2009-2011, Mohamed Barakat, University of Kaiserslautern
##                       Daniel Robertz, RWTH Aachen University
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
Macaulay2Macros.DegreeForHomalg := "\n\
DegreeForHomalg = r -> (\n\
  if zero r then -1 else sum degree(r)\n\
);\n\n";
    # degree(0) = -infinity in Macaulay2

##
Macaulay2Macros.Deg := "\n\
Deg = (r,weights,R) -> (\n\
  sum apply(toList(0..#weights-1), i->weights#i * degree(R_i, leadTerm r))\n\
);\n\n";
    # degree(x, 0) = -1 in Macaulay2

##
Macaulay2Macros.MultiDeg := "\n\
MultiDeg = (r,weights,R) -> (\n\
  concatenate between( \",\", apply(apply(0..#weights-1,i->Deg(r,weights#i,R)),toString))\n\
);\n\n";

##
Macaulay2Macros.DegreesOfEntries := "\n\
DegreesOfEntries = M -> (\n\
  concatenate between(\",\", apply(\n\
    flatten apply(entries M, i->apply(i, DegreeForHomalg)),\n\
      toString))\n\
);\n\n";

##
Macaulay2Macros.WeightedDegreesOfEntries := "\n\
WeightedDegreesOfEntries = (M,weights,R) -> (\n\
  concatenate between(\",\", apply(\n\
    flatten apply(entries M, i->apply(i, j->Deg(j,weights,R))),\n\
      toString))\n\
);\n\n";

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
               DegreeOfRingElement :=
                 function( r, R )
                   
                   return Int( homalgSendBlocking( [ "DegreeForHomalg(", r, ")" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                 end,
               
               WeightedDegreeOfRingElement :=
                 function( r, weights, R )
	           
                   return Int( homalgSendBlocking( [ "Deg(", r, ", {", weights, "},", R, ")" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                 end,
	       
               MultiWeightedDegreeOfRingElement :=
                 function( r, weights, R )
                   local externally_stored_weights;
                   
                   externally_stored_weights := MatrixOfWeightsOfIndeterminates( R );
                   
                   return StringToIntList( homalgSendBlocking( [ "MultiDeg(", r, externally_stored_weights, R, ")" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                 end,
               
               DegreesOfEntries :=
                 function( M )
                   local list_string, L;
                   
                     list_string := homalgSendBlocking( [ "DegreesOfEntries( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.DegreesOfEntries );
                     
                     L := StringToIntList( list_string );
                     
                     return ListToListList( L, NrRows( M ), NrColumns( M ) );
                     
                 end,
               
               WeightedDegreesOfEntries :=
                 function( M, weights )
                   local list_string, L;
                   
                     list_string := homalgSendBlocking( [ "WeightedDegreesOfEntries(", M, ", {", weights, "}, ", HomalgRing( M ), ")" ], "need_output", HOMALG_IO.Pictograms.DegreesOfEntries );
                     
                     L := StringToIntList( list_string );
                     
                     return ListToListList( L, NrRows( M ), NrColumns( M ) );
                     
                 end,
               
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
