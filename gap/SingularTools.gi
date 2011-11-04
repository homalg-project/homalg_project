#############################################################################
##
##  SingularTools.gi                             GradedRingForHomalg package
##
##  Copyright 2009-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for the rings provided by Singular.
##
#############################################################################

####################################
#
# global variables:
#
####################################

##
InstallValue( GradedRingMacrosForSingular,
        rec(
            
    _CAS_name := "Singular",
    
    _Identifier := "GradedRingForHomalg",
    
    Deg := "\n\
// start: a workaround for a bug in the 64 bit versions of Singular 3-0-4\n\
if ( defined( basering ) == 1 )\n\
{\n\
  def homalg_variable_basering = basering;\n\
}\n\
ring r;\n\
if ( deg(0,(1,1,1)) > 0 )\n\
{ proc Deg (pol,weights)\n\
  {\n\
    if ( pol == 0 )\n\
    {\n\
      return(deg(0));\n\
    }\n\
    return(deg(pol,weights));\n\
  }\n\
}\n\
else\n\
{ proc Deg (pol,weights)\n\
  {\n\
    return(deg(pol,weights));\n\
  }\n\
}\n\
kill r;\n\
if ( defined( homalg_variable_basering ) == 1 )\n\
{\n\
  setring homalg_variable_basering;\n\
}\n\
// end: a workaround for a bug in the 64 bit versions of Singular 3-0-4\n\
\n\n",
    
    MultiDeg := "\n\
proc MultiDeg (pol,weights)\n\
{\n\
  int mul=size(weights);\n\
  intmat m[1][mul];\n\
  for (int i=1; i<=mul; i++)\n\
  {\n\
    m[1,i]=Deg(pol,weights[i]);\n\
  }\n\
  return(m);\n\
}\n\n",
    
    DegreesOfEntries := "\n\
proc DegreesOfEntries (matrix M)\n\
{\n\
  intmat m[ncols(M)][nrows(M)];\n\
  for (int i=1; i<=ncols(M); i++)\n\
  {\n\
    for (int j=1; j<=nrows(M); j++)\n\
    {\n\
      m[i,j] = deg(M[j,i]);\n\
    }\n\
  }\n\
  return(m);\n\
}\n\n",
    
    WeightedDegreesOfEntries := "\n\
proc WeightedDegreesOfEntries (matrix M, weights)\n\
{\n\
  intmat m[ncols(M)][nrows(M)];\n\
  for (int i=1; i<=ncols(M); i++)\n\
  {\n\
    for (int j=1; j<=nrows(M); j++)\n\
    {\n\
      m[i,j] = Deg(M[j,i],weights);\n\
    }\n\
  }\n\
  return(m);\n\
}\n\n",
        
    NonTrivialDegreePerRowWithColPosition := "\n\
proc NonTrivialDegreePerRowWithColPosition(matrix M)\n\
{\n\
  intmat m[2][ncols(M)];\n\
  poly e;\n\
  for (int i=1; i<=ncols(M); i++)\n\
  {\n\
    for (int j=1; j<=nrows(M); j++)\n\
    {\n\
      e = M[j,i];\n\
      if ( e <> 0 ) { m[1,i] = deg(e); m[2,i] = j; break; }\n\
    }\n\
  }\n\
  return(m);\n\
}\n\n",
    
    NonTrivialWeightedDegreePerRowWithColPosition := "\n\
proc NonTrivialWeightedDegreePerRowWithColPosition(matrix M, weights)\n\
{\n\
  intmat m[2][ncols(M)];\n\
  poly e;\n\
  for (int i=1; i<=ncols(M); i++)\n\
  {\n\
    for (int j=1; j<=nrows(M); j++)\n\
    {\n\
      e = M[j,i];\n\
      if ( e <> 0 ) { m[1,i] = Deg(e,weights); m[2,i] = j; break; }\n\
    }\n\
  }\n\
  return(m);\n\
}\n\n",
    
    NonTrivialDegreePerColumnWithRowPosition := "\n\
proc NonTrivialDegreePerColumnWithRowPosition (matrix M)\n\
{\n\
  intmat m[2][nrows(M)];\n\
  poly e;\n\
  for (int j=1; j<=nrows(M); j++)\n\
  {\n\
    for (int i=1; i<=ncols(M); i++)\n\
    {\n\
      e = M[j,i];\n\
      if ( e <> 0 ) { m[1,j] = deg(e); m[2,j] = i; break; }\n\
    }\n\
  }\n\
  return(m);\n\
}\n\n",
    
    NonTrivialWeightedDegreePerColumnWithRowPosition := "\n\
proc NonTrivialWeightedDegreePerColumnWithRowPosition (matrix M, weights)\n\
{\n\
  intmat m[2][nrows(M)];\n\
  poly e;\n\
  for (int j=1; j<=nrows(M); j++)\n\
  {\n\
    for (int i=1; i<=ncols(M); i++)\n\
    {\n\
      e = M[j,i];\n\
      if ( e <> 0 ) { m[1,j] = Deg(e,weights); m[2,j] = i; break; }\n\
    }\n\
  }\n\
  return(m);\n\
}\n\n",
    
    Diff := "\n\
proc Diff (matrix m, matrix n) // following the Macaulay2 convention \n\
{\n\
  int f = nrows(m);\n\
  int p = ncols(m);\n\
  int g = nrows(n);\n\
  int q = ncols(n);\n\
  matrix h[f*g][p*q]=0;\n\
  for (int i=1; i<=f; i=i+1)\n\
    {\n\
    for (int j=1; j<=g; j=j+1)\n\
      {\n\
      for (int k=1; k<=p; k=k+1)\n\
        {\n\
        for (int l=1; l<=q; l=l+1)\n\
          {\n\
            h[g*(i-1)+j,q*(k-1)+l] = diff( ideal(m[i,k]), ideal(n[j,l]) )[1,1];\n\
          }\n\
        }\n\
      }\n\
    }\n\
  return(h)\n\
}\n\n",
    
    LinSyzForHomalg := "\n\
proc LinSyzForHomalg(matrix m)\n\
{\n\
  def save=degBound;\n\
  degBound=1; // it will be a disaster if degBound=0 below is not reached\n\
  def r = res(m,2);\n\
  degBound=save; // puh ... \n\
  return(r[2]);\n\
}\n\n",
    
    LinearSyzygiesGeneratorsOfRows := "\n\
if ( defined(LinSyzForHomalg) == 1 )\n\
{ proc LinearSyzygiesGeneratorsOfRows(m)\n\
  {\n\
    return(LinSyzForHomalg(m))\n\
  }\n\
}\n\
\n\n",
    
    LinearSyzygiesGeneratorsOfColumns := "\n\
if ( defined(LinSyzForHomalg) == 1 )\n\
{ proc LinearSyzygiesGeneratorsOfColumns(m)\n\
  {\n\
    return(Involution(LinSyzForHomalg(Involution(m))));\n\
  }\n\
}\n\
\n\n",
    
    CheckLinExtSyz := "\n\
// start: check degBound in SCA:\n\
if ( defined( basering ) == 1 )\n\
{\n\
  def homalg_variable_basering = basering;\n\
}\n\
ring homalg_Exterior_1 = 0,(e0,e1),dp;\n\
def homalg_Exterior_2 = superCommutative_ForHomalg(1);\n\
setring homalg_Exterior_2;\n\
option(redTail);short=0;\n\
matrix homalg_Exterior_3[3][2] = e0,0,e1,e0,0,e1;\n\
matrix homalg_Exterior_4=LinSyzForHomalg(homalg_Exterior_3);\n\
if (ncols(homalg_Exterior_4) == 1 && homalg_Exterior_4[1,1] <> 0 && homalg_Exterior_4[2,1] <> 0)\n\
{\n\
  def LinSyzForHomalgExterior = 1;\n\
}\n\
kill homalg_Exterior_4; kill homalg_Exterior_3; kill homalg_Exterior_2; kill homalg_Exterior_1;\n\
if ( defined( homalg_variable_basering ) == 1 )\n\
{\n\
  setring homalg_variable_basering;\n\
}\n\
// end: check degBound in SCA.\n\
\n\n",
    
    )

);

##
UpdateMacrosOfCAS( GradedRingMacrosForSingular, SingularMacros );
UpdateMacrosOfLaunchedCASs( GradedRingMacrosForSingular );

##
InstallValue( GradedRingTableForSingularTools,
        
        rec(
               DegreeOfRingElement :=
                 function( r, R )
                   
                   return Int( homalgSendBlocking( [ "deg( ", r, " )" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                 end,
               
               WeightedDegreeOfRingElement :=
                 function( r, weights, R )
                   
                   return Int( homalgSendBlocking( [ "deg( ", r, ",intvec(", weights, "))" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                 end,
               
               MultiWeightedDegreeOfRingElement :=
                 function( r, weights, R )
                   
                   return StringToIntList( homalgSendBlocking( [ "MultiDeg(", r, weights, ")" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                 end,
               
               DegreesOfEntries :=
                 function( M )
                   local list_string, L;
                   
                   list_string := homalgSendBlocking( [ "DegreesOfEntries( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.DegreesOfEntries );
                   
                   L :=  StringToIntList( list_string );
                   
                   return ListToListList( L, NrRows( M ), NrColumns( M ) );
                   
                 end,
               
               WeightedDegreesOfEntries :=
                 function( M, weights )
                   local list_string, L;
                   
                     list_string := homalgSendBlocking( [ "WeightedDegreesOfEntries(", M, ",", weights, ")" ], "need_output", HOMALG_IO.Pictograms.DegreesOfEntries );
                     
                     L :=  StringToIntList( list_string );
                     
                     return ListToListList( L, NrRows( M ), NrColumns( M ) );
                     
                 end,
               
               NonTrivialDegreePerRowWithColPosition :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "NonTrivialDegreePerRowWithColPosition( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerRow );
                   
                   L := StringToIntList( L );
                   
                   return ListToListList( L, 2, NrRows( M ) );
                   
                 end,
               
               NonTrivialWeightedDegreePerRowWithColPosition :=
                 function( M, weights )
                   local L;
                   
                   L := homalgSendBlocking( [ "NonTrivialWeightedDegreePerRowWithColPosition(", M, ",intvec(", weights, "))" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerRow );
                   
                   L := StringToIntList( L );
                   
                   return ListToListList( L, 2, NrRows( M ) );
                   
                 end,
               
               NonTrivialDegreePerColumnWithRowPosition :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "NonTrivialDegreePerColumnWithRowPosition( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerColumn );
                   
                   L := StringToIntList( L );
                   
                   return ListToListList( L, 2, NrColumns( M ) );
                   
                 end,
               
               NonTrivialWeightedDegreePerColumnWithRowPosition :=
                 function( M, weights )
                   local L;
                   
                   L := homalgSendBlocking( [ "NonTrivialWeightedDegreePerColumnWithRowPosition(", M, ",intvec(", weights, "))" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerColumn );
                   
                   L := StringToIntList( L );
                   
                   return ListToListList( L, 2, NrColumns( M ) );
                   
                 end,
               
               LinearSyzygiesGeneratorsOfRows :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix(
                                "unknown_number_of_rows",
                                NrRows( M ),
                                HomalgRing( M )
                                );
                   
                   homalgSendBlocking(
                           [ "matrix ", N, " = LinearSyzygiesGeneratorsOfRows(", M, ")" ],
                           "need_command",
                           HOMALG_IO.Pictograms.LinearSyzygiesGenerators
                           );
                   
                   return N;
                   
                 end,
               
               LinearSyzygiesGeneratorsOfColumns :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix(
                                NrColumns( M ),
                                "unknown_number_of_columns",
                                HomalgRing( M )
                                );
                   
                   homalgSendBlocking(
                           [ "matrix ", N, " = LinearSyzygiesGeneratorsOfColumns(", M, ")" ],
                           "need_command",
                           HOMALG_IO.Pictograms.LinearSyzygiesGenerators
                           );
                   
                   return N;
                   
                 end,
               
               MonomialMatrix :=
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "matrix(ideal(", vars, ")^", i, ")" ], [ "matrix" ], R, HOMALG_IO.Pictograms.MonomialMatrix );
                   
                 end,
               
               Diff :=
                 function( D, N )
                   
                   return homalgSendBlocking( [ "Diff(", D, N, ")" ], [ "matrix" ], HOMALG_IO.Pictograms.Diff );
                   
                 end,
               
        )
 );

## enrich the global and the created homalg tables for Singular:
AppendToAhomalgTable( CommonHomalgTableForSingularTools, GradedRingTableForSingularTools );
AppendTohomalgTablesOfCreatedExternalRings( GradedRingTableForSingularTools, IsHomalgExternalRingInSingularRep );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MatrixOfWeightsOfIndeterminates,
        "for external rings in Singular",
        [ IsHomalgExternalRingInSingularRep, IsList ],
        
  function( R, weights )
    local n, m, ext_obj;
    
    if IsHomalgElement( weights[1] ) then
        
        weights := List( weights, UnderlyingListOfRingElements );
        
    fi;
    
    n := Length( weights );
    
    if n > 0 then
        m := Length( weights[1] );
        weights := Flat( TransposedMat( weights ) );
    else
        m := 1;
    fi;
    
    ext_obj := homalgSendBlocking( [ "CreateListListOfIntegers(intvec(", weights, "),", m, n, ")"  ], [ "list" ], R, HOMALG_IO.Pictograms.CreateList );
    
    ## CAUTION: ext_obj does not a pointer on a matrix in Singular
    ## but on an intvec; use with care
    return HomalgMatrix( ext_obj, m, n, R );
    
end );

##
InstallMethod( AreLinearSyzygiesAvailable,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep and IsExteriorRing ],
        
  function( R )
    
    return homalgSendBlocking( "defined(LinSyzForHomalgExterior)",
               "need_output", R, HOMALG_IO.Pictograms.initialize ) = "1";
    
end );
