# SPDX-License-Identifier: GPL-2.0-or-later
# GradedRingForHomalg: Endow Commutative Rings with an Abelian Grading
#
# Implementations
#

####################################
#
# global variables:
#
####################################

##
InstallValue( GradedRingMacrosForMacaulay2,
        rec(
            
    _CAS_name := "Macaulay2",
    
    _Identifier := "GradedRingForHomalg",
    
    Deg := "\n\
Deg = (r,weights,R) -> (\n\
  if zero r then -1 else sum apply(toList(0..#weights-1), i->weights#i * degree(R_i, leadTerm r))\n\
);\n\n",
    # degree(x, 0) = -1 in Macaulay2
    
    MultiDeg := "\n\
MultiDeg = (r,weights,R) -> (\n\
  concatenate between( \",\", apply(apply(0..#weights-1,i->Deg(r,weights#i,R)),toString))\n\
);\n\n",
    
    DegreesOfEntries := "\n\
DegreesOfEntries = M -> (\n\
  concatenate between(\",\", apply(\n\
    flatten apply(entries M, i->apply(i, DegreeForHomalg)),\n\
      toString))\n\
);\n\n",
    
    WeightedDegreesOfEntries := "\n\
WeightedDegreesOfEntries = (M,weights,R) -> (\n\
  concatenate between(\",\", apply(\n\
    flatten apply(entries M, i->apply(i, j->Deg(j,weights,R))),\n\
      toString))\n\
);\n\n",
    
    NonTrivialDegreePerRowWithColPosition := "\n\
NonTrivialDegreePerRowWithColPosition = M -> ( local n,p;\n\
  n = numgens(source M)-1;\n\
  concatenate({\"[\"} | between(\",\",\n\
    for r in entries(M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {concatenate({\"[\", toString(sum degree r#j), \",\", toString(j+1), \"]\"})} );\n\
      if p == {} then \"[0,0]\" else p#0\n\
    )) | {\"]\"})\n\
)\n\n",
    
    NonTrivialWeightedDegreePerRowWithColPosition := "\n\
NonTrivialWeightedDegreePerRowWithColPosition = (M,weights,R) -> ( local n,p;\n\
  n = numgens(source M)-1;\n\
  concatenate({\"[\"} | between(\",\",\n\
    for r in entries(M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {concatenate({\"[\", toString(Deg(r#j,weights,R)), \",\", toString(j+1), \"]\"})} );\n\
      if p == {} then \"[0,0]\" else p#0\n\
    )) | {\"]\"})\n\
)\n\n",
    
    NonTrivialDegreePerColumnWithRowPosition := "\n\
NonTrivialDegreePerColumnWithRowPosition = M -> ( local n,p;\n\
  n = numgens(target M)-1;\n\
  concatenate({\"[\"} | between(\",\",\n\
    for r in entries(transpose M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {concatenate({\"[\", toString(sum degree r#j), \",\", toString(j+1), \"]\"})} );\n\
      if p == {} then \"[0,0]\" else p#0\n\
    )) | {\"]\"})\n\
)\n\n",
    
    NonTrivialWeightedDegreePerColumnWithRowPosition := "\n\
NonTrivialWeightedDegreePerColumnWithRowPosition = (M,weights,R) -> ( local n,p;\n\
  n = numgens(target M)-1;\n\
  concatenate({\"[\"} | between(\",\",\n\
    for r in entries(transpose M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {concatenate({\"[\", toString(Deg(r#j,weights,R)), \",\", toString(j+1), \"]\"})} );\n\
      if p == {} then \"[0,0]\" else p#0\n\
    )) | {\"]\"})\n\
)\n\n",

    LinearSyzygiesGeneratorsOfRows := "\n\
LinearSyzygiesGeneratorsOfRows = M -> Involution(LinearSyzygiesGeneratorsOfColumns(Involution(M)));\n\n",
    
    0_LinearSyzygiesGeneratorsOfColumns := "\n\
LinearSyzygiesGeneratorsOfColumns = M -> (\n\
  local R,S;\n\
  R = ring M;\n\
  m = map(R^(numgens target M), numgens source M, entries(M));\n\
  S = res(coker m,DegreeLimit=>2,LengthLimit=>2);\n\
  S = S.dd_2;\n\
  map(R^(numgens target S), R^(numgens source S), S)\n\
);\n\n",
    
    CheckLinExtSyz := "\n\
-- start: check DegreeLimit for exterior algebras:\n\
homalgExterior1 = QQ[e0,e1,SkewCommutative => true]\n\
homalgExterior2 = map(homalgExterior1^3,homalgExterior1^2, pack(2, { e0, 0, e1, e0, 0, e1 }))\n\
homalgExterior3 = LinearSyzygiesGeneratorsOfColumns(homalgExterior2)\n\
if numgens source homalgExterior3 == 1 and homalgExterior3 != 0 then LinSyzForHomalgExterior = true else LinSyzForHomalgExterior = false\n\
-- end: check DegreeLimit for exterior algebras.\n\
\n\n",
    
    )

);

##
UpdateMacrosOfCAS( GradedRingMacrosForMacaulay2, Macaulay2Macros );
UpdateMacrosOfLaunchedCASs( GradedRingMacrosForMacaulay2 );

##
InstallValue( GradedRingTableForMacaulay2Tools,
        
        rec(
               WeightedDegreeOfRingElement :=
                 function( r, weights, R )
                   
                   return Int( homalgSendBlocking( [ "Deg(", r, ", {", weights, "},", R, ")" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                 end,
               
               MultiWeightedDegreeOfRingElement :=
                 function( r, weights, R )
                   
                   return StringToIntList( homalgSendBlocking( [ "MultiDeg(", r, weights, R, ")" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                 end,
               
               DegreesOfEntries :=
                 function( M )
                   local list_string, L;
                   
                     list_string := homalgSendBlocking( [ "DegreesOfEntries( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.DegreesOfEntries );
                     
                     L := StringToIntList( list_string );
                     
                     return ListToListList( L, NumberRows( M ), NumberColumns( M ) );
                     
                 end,
               
               WeightedDegreesOfEntries :=
                 function( M, weights )
                   local list_string, L;
                   
                     list_string := homalgSendBlocking( [ "WeightedDegreesOfEntries(", M, ", {", weights, "}, ", HomalgRing( M ), ")" ], "need_output", HOMALG_IO.Pictograms.DegreesOfEntries );
                     
                     L := StringToIntList( list_string );
                     
                     return ListToListList( L, NumberRows( M ), NumberColumns( M ) );
                     
                 end,
               
               NonTrivialDegreePerRowWithColPosition :=
                 function( M )
                   
                   return TransposedMat( EvalString( homalgSendBlocking( [ "NonTrivialDegreePerRowWithColPosition( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerRow ) ) );
                   
                 end,
               
               NonTrivialWeightedDegreePerRowWithColPosition :=
                 function( M, weights )
                   
                   return TransposedMat( EvalString( homalgSendBlocking( [ "NonTrivialWeightedDegreePerRowWithColPosition(", M, ", {", weights, "}, ", HomalgRing( M ), ")" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerRow ) ) );
                   
                 end,
               
               NonTrivialDegreePerColumnWithRowPosition :=
                 function( M )
                   
                   return TransposedMat( EvalString( homalgSendBlocking( [ "NonTrivialDegreePerColumnWithRowPosition( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerColumn ) ) );
                   
                 end,
               
               NonTrivialWeightedDegreePerColumnWithRowPosition :=
                 function( M, weights )
                   
                   return TransposedMat( EvalString( homalgSendBlocking( [ "NonTrivialWeightedDegreePerColumnWithRowPosition(", M, ", {", weights, "}, ", HomalgRing( M ), ")" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerColumn ) ) );
                   
                 end,
               
               LinearSyzygiesGeneratorsOfRows :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NumberRows( M ), HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " = LinearSyzygiesGeneratorsOfRows(", M, ")" ], "need_command", HOMALG_IO.Pictograms.LinearSyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
               LinearSyzygiesGeneratorsOfColumns :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix( NumberColumns( M ), "unknown_number_of_columns", HomalgRing( M ) );
                   
                   homalgSendBlocking( [ N, " = LinearSyzygiesGeneratorsOfColumns(", M, ")" ], "need_command", HOMALG_IO.Pictograms.LinearSyzygiesGenerators );
                   
                   return N;
                   
                 end,
               
        )
 );

## enrich the global and the created homalg tables for Macaulay2:
AppendToAhomalgTable( CommonHomalgTableForMacaulay2Tools, GradedRingTableForMacaulay2Tools );
AppendTohomalgTablesOfCreatedExternalRings( GradedRingTableForMacaulay2Tools, IsHomalgExternalRingInMacaulay2Rep );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MatrixOfWeightsOfIndeterminates,
        "for external rings in Macaulay2",
        [ IsHomalgExternalRingInMacaulay2Rep, IsList ],
        
  function( R, weights )
    local n, m, ext_obj;
    
    if IsHomalgElement( weights[1] ) then
        
        ## this should be handled with care, as it will eventually fail if the module is not over the ring of integers
        weights := List( weights, UnderlyingListOfRingElementsInCurrentPresentation );
        
    fi;
    
    n := Length( weights );
    
    if n > 0 and IsList( weights[1] ) then
        m := Length( weights[1] );
        weights := Flat( TransposedMat( weights ) );
    else
        m := 1;
    fi;
    
    ext_obj := homalgSendBlocking( [ "pack(", n, ",{", weights, "})"  ], "break_lists", R, HOMALG_IO.Pictograms.CreateList );
    
    return HomalgMatrix( ext_obj, m, n, R );
    
end );

##
InstallMethod( AreLinearSyzygiesAvailable,
        "for homalg rings in Macaulay2",
        [ IsHomalgExternalRingInMacaulay2Rep and IsExteriorRing ],
        
  function( R )
    
    return homalgSendBlocking( "LinSyzForHomalgExterior",
               "need_output", R, HOMALG_IO.Pictograms.initialize ) = "true";
    
end );
