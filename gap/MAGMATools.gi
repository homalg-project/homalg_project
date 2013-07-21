#############################################################################
##
##  MAGMATools.gi                                GradedRingForHomalg package
##
##  Copyright 2009-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Kirschmer, RWTH-Aachen University
##
##  Implementations for the rings provided by MAGMA.
##
#############################################################################

####################################
#
# global variables:
#
####################################

##
InstallValue( GradedRingMacrosForMAGMA,
        rec(
            
    _CAS_name := "MAGMA",
    
    _Identifier := "GradedRingForHomalg",
    
    NonTrivialDegreePerRowWithColPosition := "\n\
NonTrivialDegreePerRowWithColPosition := function(M)\n\
  X:= [];\n\
  Y:= [];\n\
  for i in [1..Nrows(M)] do\n\
    d:= Depth(M[i]);\n\
    if d eq 0 then\n\
      Append(~X, 0);\n\
      Append(~Y, 0);\n\
    else\n\
      Append(~X, Degree(M[i,d]));\n\
      Append(~Y, d);\n\
    end if;\n\
  end for;\n\
  return X cat Y;\n\
end function;\n\n",
    
    NonTrivialDegreePerColumnWithRowPosition := "\n\
NonTrivialDegreePerColumnWithRowPosition := function(M)\n\
  X:= [];\n\
  Y:= [];\n\
  m:= Nrows(M);\n\
  for j in [1..Ncols(M)] do\n\
    if exists(i){ i: i in [1..m] | not IsZero(M[i,j]) } then\n\
      Append(~X, Degree(M[i,j]));\n\
      Append(~Y, i);\n\
    else\n\
      Append(~X, 0);\n\
      Append(~Y, 0);\n\
    end if;\n\
  end for;\n\
  return X cat Y;\n\
end function;\n\n",

    ("!Diff") := "\n\
// liefert f nach g. Reihenfolge ist der Parameter in Magma-Konvention (alles andere ist sehr komisch)\n\
function mydiff(f,g)\n\
  P:= Parent(f);\n\
  assert not IsZero(g) and Parent(g) eq P;\n\
  C, M:= CoefficientsAndMonomials(g);\n\
  return &+ [ C[j] * &* [ P | Derivative(f, e[i], i) : i in [1..#e] | e[i] ne 0 ] where e:= Exponents(M[j]) : j in [1..#C] ];\n\
end function;\n\n",
    
    Diff := "\n\
// Frei nach dem GAP-Handbuch:\n\
// If D is a f × p-matrix and N is a g × q-matrix then H=Diff(D,N) is an fg × pq-matrix whose entry H[g*(i-1)+j,q*(k-1)+l] is the\n\
// result of differentiating N[j,l] by the differential operator corresponding to D[i,k]. (Here we follow the Macaulay2 convention.)\n\
function Diff(D, N)\n\
  return Matrix( Ncols(D) * Ncols(N), [ mydiff(N[j,l], D[i,k]) : l in [1..Ncols(N)], k in [1..Ncols(D)] , j in [1..Nrows(N)], i in [1..Nrows(D)] ] );\n\
end function;\n\n",
    
    )

);

##
UpdateMacrosOfCAS( GradedRingMacrosForMAGMA, MAGMAMacros );
UpdateMacrosOfLaunchedCASs( GradedRingMacrosForMAGMA );

##
InstallValue( GradedRingTableForMAGMATools,
        
        rec(
               NonTrivialDegreePerRowWithColPosition :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "NonTrivialDegreePerRowWithColPosition( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.NonTrivialDegreePerRow );
                   
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
               Diff :=
                 function( D, N )
                   
                   return homalgSendBlocking( [ "Diff(", D, N, ")" ], HOMALG_IO.Pictograms.Diff );
                   
                 end,
               
        )
 );

## enrich the global and the created homalg tables for MAGMA:
AppendToAhomalgTable( CommonHomalgTableForMAGMATools, GradedRingTableForMAGMATools );
AppendTohomalgTablesOfCreatedExternalRings( GradedRingTableForMAGMATools, IsHomalgExternalRingInMAGMARep );
