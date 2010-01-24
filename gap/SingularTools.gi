#############################################################################
##
##  SingularTools.gi            Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
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
SingularMacros.Diff := "\n\
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
}\n\n";

SingularMacros.PrimaryDecomposition := "\n\
proc PrimaryDecomposition (matrix m)\n\
{\n\
  return(primdecSY(m))\n\
}\n\n";

##
InstallValue( SheavesHomalgTableForSingularTools,
        
        rec(
               MonomialMatrix :=
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "matrix(ideal(", vars, ")^", i, ")" ], [ "matrix" ], R, HOMALG_IO.Pictograms.MonomialMatrix );
                   
                 end,
               
               Eliminate :=
                 function( rel, indets, R )
                   local elim;
                   
                   elim := Iterated( indets, \* );
                   
                   return homalgSendBlocking( [ "matrix(eliminate(ideal(", rel, "),", elim, "))" ], [ "matrix" ], R, HOMALG_IO.Pictograms.Eliminate );
                   
                 end,
               
               Diff :=
                 function( D, N )
                   
                   return homalgSendBlocking( [ "Diff(", D, N, ")" ], [ "matrix" ], HOMALG_IO.Pictograms.Diff );
                   
                 end,
               
               AffineDimension :=
                 function( M )
                   local mat;
                   
                   mat := MatrixOfRelations( M );
                   
                   ## Singular specific:
                   if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
                       mat := Involution( mat );
                   fi;
                   
                   return Int( homalgSendBlocking( [ "dim(std(", mat, "))" ], "need_output", HOMALG_IO.Pictograms.AffineDimension ) );
                   
                 end,
               
               AffineDegree :=
                 function( M )
                   local mat, hilb;
                   
                   mat := MatrixOfRelations( M );
                   
                   ## Singular specific:
                   if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
                       mat := Involution( mat );
                   fi;
                   
                   hilb := homalgSendBlocking( [ "hilb(std(", mat, "),2)" ], "need_output", HOMALG_IO.Pictograms.AffineDegree );
                   
                   hilb := StringToIntList( hilb );
                   
                   return Iterated( hilb{[ 1 .. Length( hilb ) - 1 ]}, SUM );
                   
                 end,
               
               ConstantTermOfHilbertPolynomial :=
                 function( M )
                   local d, mat, hilb;
                   
                   d := AffineDimension( M );
                   
                   if d <= 0 then
                       return 0;
                   fi;
                   
                   mat := MatrixOfRelations( M );
                   
                   ## Singular specific:
                   if IsHomalgRightObjectOrMorphismOfRightObjects( M ) then
                       mat := Involution( mat );
                   fi;
                   
                   hilb := homalgSendBlocking( [ "hilb(std(", mat, "),2)" ], "need_output", HOMALG_IO.Pictograms.ConstantTermOfHilbertPolynomial );
                   
                   hilb := StringToIntList( hilb );
                   
                   hilb := List( [ 0 .. Length( hilb ) - 2 ], k -> hilb[k+1] * Binomial( d - 1 - k, d - 1 ) );
                   
                   return Iterated( hilb, SUM );
                   
                 end,
               
               PrimaryDecomposition :=
                 function( M )
                   local degrees, graded, mat, left, R, v, c, primary_decomposition;
                   
                   degrees := DegreesOfGenerators( M );
                   
                   graded := IsList( degrees ) and degrees <> [ ];
                   
                   left := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
                   
                   mat := MatrixOfRelations( M );
                   
                   ## Singular specific:
                   if not left then
                       mat := Involution( mat );
                   fi;
                   
                   R := HomalgRing( M );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ "list ", v, "l=PrimaryDecomposition(", mat, ")" ], "need_command", HOMALG_IO.Pictograms.PrimaryDecomposition );
                   
                   c := Int( homalgSendBlocking( [ "size(", v, "l)" ], "need_output", R, HOMALG_IO.Pictograms.PrimaryDecomposition ) );
                   
                   primary_decomposition :=
                     List( [ 1 .. c ],
                           function( i )
                             local primary, prime;
                             
                             primary := HomalgVoidMatrix( R );
                             prime := HomalgVoidMatrix( R );
                             
                             homalgSendBlocking( [ "matrix ", primary, "[1][size(", v, "l[", i, "][1])]=", v, "l[", i, "][1]" ], "need_output", HOMALG_IO.Pictograms.PrimaryDecomposition );
                             homalgSendBlocking( [ "matrix ", prime, "[1][size(", v, "l[", i, "][2])]=", v, "l[", i, "][2]" ], "need_output", HOMALG_IO.Pictograms.PrimaryDecomposition );
                             
                             if left then
                                 if graded then
                                     primary := GradedLeftSubmodule( primary );
                                     prime := GradedLeftSubmodule( prime );
                                 else
                                     primary := LeftSubmodule( primary );
                                     prime := LeftSubmodule( prime );
                                 fi;
                             else
                                 primary := Involution( primary );
                                 prime := Involution( prime );
                                 if graded then
                                     primary := GradedRightSubmodule( primary );
                                     prime := GradedRightSubmodule( prime );
                                 else
                                     primary := RightSubmodule( primary );
                                     prime := RightSubmodule( prime );
                                 fi;
                             fi;
                             
                             return [ primary, prime ];
                             
                           end
                         );
                   
                   return primary_decomposition;
                   
                 end,
               
        )
 );

## enrich the global homalg table for Singular:
AddToAhomalgTable( CommonHomalgTableForSingularTools, SheavesHomalgTableForSingularTools );
