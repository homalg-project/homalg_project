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
    
    DegreeOfRingElement := "\n\
// a work around of a bug noticed by Markus L.-H. in the 64bit Magma V2.17-2\n\
if Degree(PolynomialRing(Rationals(),2)!0) eq 0 then\n\
Deg:= function(r,R)\n\
  a := R!r;\n\
  if a eq 0 then return -1; end if; return Degree(a);\n\
end function;\n\
else\n\
Deg:= function(r,R)\n\
  return Degree(R!r);\n\
end function;\n\
end if;\n\n",
    
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

    )

);

##
UpdateMacrosOfCAS( GradedRingMacrosForMAGMA, MAGMAMacros );
UpdateMacrosOfLaunchedCASs( GradedRingMacrosForMAGMA );

##
InstallValue( GradedRingTableForMAGMATools,
        
        rec(
               DegreeOfRingElement :=
                 function( r, R )
                   
                   return Int( homalgSendBlocking( [ "Deg(", r, R, ")" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                 end,
               
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
               
               MonomialMatrix :=
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "Matrix(1,MonomialsOfDegree(", R, i, ",{", R, ".i : i in [ 1 .. Rank(", R, ")]} diff {", vars, "}))" ], "break_lists", HOMALG_IO.Pictograms.MonomialMatrix );
                   
                 end,
               
        )
 );

## enrich the global and the created homalg tables for MAGMA:
AppendToAhomalgTable( CommonHomalgTableForMAGMATools, GradedRingTableForMAGMATools );
AppendTohomalgTablesOfCreatedExternalRings( GradedRingTableForMAGMATools, IsHomalgExternalRingInMAGMARep );
