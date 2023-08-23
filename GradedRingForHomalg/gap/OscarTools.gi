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
InstallValue( GradedRingMacrosForOscar,
        rec(
            
    _CAS_name := "Oscar",
    
    _Identifier := "GradedRingForHomalg",
    
    Degree := """
function Degree(pol, weights)
    if iszero(pol)
        return -1
    end
    exponents = collect(exponent_vectors(pol))
    l = length(weights)
    f = e -> sum(i->e[i] * weights[i], 1:l)
    d = map(f, exponents)
    max(d...)
end
""",

    
    )

);

##
UpdateMacrosOfCAS( GradedRingMacrosForOscar, OscarMacros );
UpdateMacrosOfLaunchedCASs( GradedRingMacrosForOscar );

##
InstallValue( GradedRingTableForOscarTools,
        
        rec(
               WeightedDegreeOfRingElement :=
                 function( r, weights, R )
                   
                   return Int( homalgSendBlocking( [ "Degree(", r, ", ", weights, ")" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                 end,
               
               MultiWeightedDegreeOfRingElement :=
                 function( r, weights, R )
                   
                   if IsList( weights ) then
                       
                       weights := MatrixOfWeightsOfIndeterminates( R, weights );
                       
                   fi;
                   
                   return StringToIntList( homalgSendBlocking( [ "MultiDeg(", r, weights, ")" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                 end,
               
               DegreesOfEntries :=
                 function( M )
                   local list_string, L;
                   
                   list_string := homalgSendBlocking( [ "DegreesOfEntries( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.DegreesOfEntries );
                   
                   L :=  StringToIntList( list_string );
                   
                   return ListToListList( L, NumberRows( M ), NumberColumns( M ) );
                   
                 end,
               
               WeightedDegreesOfEntries :=
                 function( M, weights )
                   local list_string, L;
                   
                     list_string := homalgSendBlocking( [ "WeightedDegreesOfEntries(", M, ",intvec(", weights, "))" ], "need_output", HOMALG_IO.Pictograms.DegreesOfEntries );
                     
                     L :=  StringToIntList( list_string );
                     
                     return ListToListList( L, NumberRows( M ), NumberColumns( M ) );
                     
                 end,
                 
#                MultiWeightedDegreesOfEntries :=
#                  function( M, weights, R )
#                    local nr_rows, nr_cols, i, j, deg_mat;
#                    
#                    nr_rows := NumberRows( M );
#                    nr_cols := NumberColumns( M );
#                    
#                    deg_mat := NullMat( nr_rows, nr_cols );
#                    
#                    for i in [ 1 .. nr_rows ] do
#                        for j in [ 1 .. nr_cols ] do
#                            deg_mat[ i ][ j ] := StringToIntList( homalgSendBlocking( [ "MultiDegOfMatrixEntry(", M, weights, j, i, ")" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
#                         od;
#                     od;
#                     
#                     return deg_mat;
#                     
#                 end,
               
               NonTrivialDegreePerRowWithColPosition :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "NonTrivialDegreePerRowWithColPosition( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerRow );
                   
                   L := StringToIntList( L );
                   
                   return ListToListList( L, 2, NumberRows( M ) );
                   
                 end,
               
               NonTrivialWeightedDegreePerRowWithColPosition :=
                 function( M, weights )
                   local L;
                   
                   L := homalgSendBlocking( [ "NonTrivialWeightedDegreePerRowWithColPosition(", M, ",intvec(", weights, "))" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerRow );
                   
                   L := StringToIntList( L );
                   
                   return ListToListList( L, 2, NumberRows( M ) );
                   
                 end,
               
               NonTrivialDegreePerColumnWithRowPosition :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "NonTrivialDegreePerColumnWithRowPosition( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerColumn );
                   
                   L := StringToIntList( L );
                   
                   return ListToListList( L, 2, NumberColumns( M ) );
                   
                 end,
               
               NonTrivialWeightedDegreePerColumnWithRowPosition :=
                 function( M, weights )
                   local L;
                   
                   L := homalgSendBlocking( [ "NonTrivialWeightedDegreePerColumnWithRowPosition(", M, ",intvec(", weights, "))" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerColumn );
                   
                   L := StringToIntList( L );
                   
                   return ListToListList( L, 2, NumberColumns( M ) );
                   
                 end,
               
               LinearSyzygiesGeneratorsOfRows :=
                 function( M )
                   local N;
                   
                   N := HomalgVoidMatrix(
                                "unknown_number_of_rows",
                                NumberRows( M ),
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
                                NumberColumns( M ),
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
               
        )
 );

## enrich the global and the created homalg tables for Oscar:
AppendToAhomalgTable( CommonHomalgTableForOscarTools, GradedRingTableForOscarTools );
AppendTohomalgTablesOfCreatedExternalRings( GradedRingTableForOscarTools, IsHomalgExternalRingInOscarRep );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MatrixOfWeightsOfIndeterminates,
        "for external rings in Oscar",
        [ IsHomalgExternalRingInOscarRep, IsList ],
        
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
    
    ext_obj := homalgSendBlocking( [ "CreateListListOfIntegers(", weights, ",", m, n, ")"  ], R, HOMALG_IO.Pictograms.CreateList );
    
    ## CAUTION: ext_obj is not a pointer to a matrix in Oscar but to an intvec;
    ## use with care
    return HomalgMatrix( ext_obj, m, n, R );
    
end );

##
InstallMethod( AreLinearSyzygiesAvailable,
        "for homalg rings in Oscar",
        [ IsHomalgExternalRingInOscarRep and IsExteriorRing ],
        
  function( R )
    
    return homalgSendBlocking( "isdefined(Base, LinSyzForHomalgExterior)",
               "need_output", R, HOMALG_IO.Pictograms.initialize ) = "true";
    
end );
