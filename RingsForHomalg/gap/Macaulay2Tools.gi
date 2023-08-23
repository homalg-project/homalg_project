# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the external rings provided by the ring packages
##  of the GAP implementation of homalg.

####################################
#
# global variables:
#
####################################

BindGlobal( "CommonHomalgTableForMacaulay2Tools",
        
        rec(
               Zero := HomalgExternalRingElement( R -> homalgSendBlocking( [ R, "#0" ], "Zero" ), "Macaulay2", IsZero ),
               
               One := HomalgExternalRingElement( R -> homalgSendBlocking( [ R, "#1" ], "One" ), "Macaulay2", IsOne ),
               
               MinusOne := HomalgExternalRingElement( R -> homalgSendBlocking( [ "-", R, "#1" ], "MinusOne" ), "Macaulay2", IsMinusOne ),
               
               RingElement := R -> r -> homalgSendBlocking( [ R, "#1 * (", r, ")" ], "define" ),
               
               IsZero := r -> homalgSendBlocking( [ "zero(", r, ")" ] , "need_output", "IsZero" ) = "true",
               
               IsOne := r -> homalgSendBlocking( [ r, "==", One( r ) ] , "need_output", "IsOne" ) = "true",
               
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "-(", b, ")" ], "Minus" );
                   
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   
                   return homalgSendBlocking( [ "(", a, ")*(", u, ")^-1"  ], "DivideByUnit" );
                   
                 end,
               
               IsUnit :=
                 function( R, u )
                   
                   return homalgSendBlocking( [ "isUnit(", u, ")" ], R, "need_output", "IsUnit" ) = "true";
                   
                 end,
               
               Sum :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "+(", b, ")" ], "Sum" );
                   
                 end,
               
               Product :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "(", a, ")*(", b, ")" ], "Product" );
                   
                 end,
               
               Gcd :=
                 function( a, b )

                   return homalgSendBlocking( [ "gcd(", a, b, ")" ], "Gcd" );

                 end,
               
               CancelGcd :=
                 function( a, b )
                   local a_g, b_g;
                   
                   homalgSendBlocking( [ "g=gcd(", a, b, ")" ], "need_command", "Gcd" );
                   a_g := homalgSendBlocking( [ "(", a, ") // g" ], "CancelGcd" );
                   b_g := homalgSendBlocking( [ "(", b, ") // g" ], "CancelGcd" );
                   
                   return [ a_g, b_g ];
                   
                 end,
               
               ShallowCopy := C -> homalgSendBlocking( [ C ], "CopyMatrix" ),
               
               CopyMatrix :=
                 function( C, R )
                   
                   return homalgSendBlocking( [ "substitute(", C, R, ")" ], R, "CopyMatrix" );
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return homalgSendBlocking( [ "map(", R, "^", NumberRows( C ), R, "^", NumberColumns( C ), ",0)" ], "ZeroMatrix" );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "id_(", HomalgRing( C ), "^", NumberRows( C ), ")" ], "IdentityMatrix" );
                   
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   #return homalgSendBlocking( [ "zero(", A, "-", B, ")" ], "need_output", "AreEqualMatrices" ) = "true";
                   
                   return homalgSendBlocking( [ A, "==", B ] , "need_output", "AreEqualMatrices" ) = "true";
                   
                 end,
               
               Involution := M -> homalgSendBlocking( [ "Involution(", M, ")" ], "Involution" ),
               
               TransposedMatrix := M -> homalgSendBlocking( [ "transpose(", M, ")" ], "TransposedMatrix" ),
               
               CertainRows :=
                 function( M, plist )
                   #local R;
                   
                   #R := HomalgRing( M );
                   
                   plist := plist - 1;
                   
                   return homalgSendBlocking( [ M, "^{", plist, "}" ], "CertainRows" );
                   
                   # operator '^' forgets grading!
                   #return homalgSendBlocking( [ "map(", R, "^(-(degrees target ", M, ")_{", plist, "}), source ", M, ", ", M, "^{", plist, "})" ], "CertainRows" );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   plist := plist - 1;
                   return homalgSendBlocking( [ M, "_{", plist, "}" ], "CertainColumns" );
                   
                 end,
               
               UnionOfRowsPair :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "||", B ], "UnionOfRows" );
                   
                 end,
               
               UnionOfColumnsPair :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "|", B ], "UnionOfColumns" );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   
                   return homalgSendBlocking( [ "fold((i,j)->i ++ j, {", e, "})" ], HomalgRing( e[1] ), "DiagMat" );
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "**", B ], "KroneckerMat" );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return homalgSendBlocking( [ "(", a, ")*", A ], "MulMat" );
                   
                 end,
               
               MulMatRight :=
                 function( A, a )
                   
                   return homalgSendBlocking( [ A, "*(", a, ")" ], "MulMatRight" );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "+", B ], "AddMat" );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "-", B ], "SubMat" );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "*", B ], "Compose" );
                   
                 end,
               
               NumberRows :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "numgens(target(", C, "))" ], "need_output", "NumberRows" ) );
                   
                 end,
               
               NumberColumns :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "numgens(source(", C, "))" ], "need_output", "NumberColumns" ) );
                   
                 end,
               
               Determinant :=
                 function( C )
                   
                   return homalgSendBlocking( [ "det(", C, ")" ], "Determinant" );
                   
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "zero(", M, ")" ] , "need_output", "IsZeroMatrix" ) = "true";
                   
                 end,
               
               IsIdentityMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsIdentityMatrix(", M, ")" ], "need_output", "IsIdentityMatrix" ) = "true";
                   
                 end,
               
               IsDiagonalMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsDiagonalMatrix(", M, ")" ] , "need_output", "IsDiagonalMatrix" ) = "true";
                   
                 end,
               
               ZeroRows :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroRows(", C, ")" ], "need_output", "ZeroRows" );
                   
                   return EvalString( list_string );
                   
                 end,
               
               ZeroColumns :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroColumns(", C, ")" ], "need_output", "ZeroColumns" );
                   
                   return EvalString( list_string );
                   
                 end,
               
               GetColumnIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositions(", M, ", {", pos_list, "})" ], "need_output", "GetColumnIndependentUnitPositions" ) );
                   
                 end,
               
               GetRowIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositions(", M, ", {", pos_list, "})" ], "need_output", "GetRowIndependentUnitPositions" ) );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPosition(", M, ", {", pos_list, "})" ], "need_output", "GetUnitPosition" );
                   
                   if list_string = "fail" then
                       return fail;
                   else
                       return StringToIntList( list_string );
                   fi;
                   
                 end,
               
               PositionOfFirstNonZeroEntryPerRow :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "PositionOfFirstNonZeroEntryPerRow( ", M, " )" ], "need_output", "PositionOfFirstNonZeroEntryPerRow" );
                   
                   L := StringToIntList( L );
                   
                   if Length( L ) = 1 then
                       return ListWithIdenticalEntries( NumberRows( M ), L[1] );
                   fi;
                   
                   return L;
                   
                 end,
               
               PositionOfFirstNonZeroEntryPerColumn :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "PositionOfFirstNonZeroEntryPerColumn( ", M, " )" ], "need_output", "PositionOfFirstNonZeroEntryPerColumn" );
                   
                   L := StringToIntList( L );
                   
                   if Length( L ) = 1 then
                       return ListWithIdenticalEntries( NumberColumns( M ), L[1] );
                   fi;
                   
                   return L;
                   
                 end,
               
               DivideEntryByUnit :=
                 function( M, i, j, u )
                   
                   homalgSendBlocking( [ M, " = ", M, "_{0..(", j, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {l // ", u, "} else {l})) | ", M, "_{", j, "..(numgens source ", M, ")-1}" ], "need_command", "DivideEntryByUnit" );
                   
                 end,
               
               DivideRowByUnit :=
                 function( M, i, u, j )
                   
                   if j > 0 then
                       homalgSendBlocking( [ M, " = ", M, "^{0..(", i, "-2)} || map((ring ", M, ")^1, source ", M, ", {apply(toList(1..(numgens source ", M, ")), flatten entries ", M, "^{", i, "-1}, (k,l)->if k == ", j, " then 1_(ring ", M, ") else l // ", u, ")}) || ", M, "^{", i, "..(numgens target ", M, ")-1}" ], "need_command", "DivideRowByUnit" );
                   else
                       homalgSendBlocking( [ M, " = ", M, "^{0..(", i, "-2)} || map((ring ", M, ")^1, source ", M, ", apply(entries ", M, "^{", i, "-1}, k->apply(k, l->l // ", u, "))) || ", M, "^{", i, "..(numgens target ", M, ")-1}" ], "need_command", "DivideRowByUnit" );
                   fi;
                   
                 end,
               
               DivideColumnByUnit :=
                 function( M, j, u, i )
                   
                   if i > 0 then
                       homalgSendBlocking( [ M, " = ", M, "_{0..(", j, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {1_(ring ", M, ")} else {l // ", u, "})) | ", M, "_{", j, "..(numgens source ", M, ")-1}" ], "need_command", "DivideColumnByUnit" );
                   else
                       homalgSendBlocking( [ M, " = ", M, "_{0..(", j, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(entries ", M, "_(", j, "-1), k->{k // ", u, "})) | ", M, "_{", j, "..(numgens source ", M, ")-1}" ], "need_command", "DivideColumnByUnit" );
                   fi;
                   
                 end,
               
               CopyRowToIdentityMatrix :=
                 function( M, i, L, j )
                   local l;
                   
                   l := Length( L );
                   
                   if l > 1 and ForAll( L, IsHomalgMatrix ) then
                       homalgSendBlocking( [ L[1], " = ", L[1], "^{0..(", j, "-2)} || map((ring ", M, ")^1, source ", M, ", {apply(toList(1..(numgens source ", M, ")), flatten entries ", M, "^{", i, "-1}, (k,l)->if k == ", j, " then 1_(ring ", M, ") else -l)}) || ", L[1], "^{", j, "..(numgens target ", L[1], ")-1}" ], "need_command", "CopyRowToIdentityMatrix" );
                       homalgSendBlocking( [ L[2], " = ", L[2], "^{0..(", j, "-2)} || map((ring ", M, ")^1, source ", M, ", {apply(toList(1..(numgens source ", M, ")), flatten entries ", M, "^{", i, "-1}, (k,l)->if k == ", j, " then 1_(ring ", M, ") else l)}) || ", L[2], "^{", j, "..(numgens target ", L[2], ")-1}" ], "need_command", "CopyRowToIdentityMatrix" );
                   elif l > 0 and IsHomalgMatrix( L[1] ) then
                       homalgSendBlocking( [ L[1], " = ", L[1], "^{0..(", j, "-2)} || map((ring ", M, ")^1, source ", M, ", {apply(toList(1..(numgens source ", M, ")), flatten entries ", M, "^{", i, "-1}, (k,l)->if k == ", j, " then 1_(ring ", M, ") else -l)}) || ", L[1], "^{", j, "..(numgens target ", L[1], ")-1}" ], "need_command", "CopyRowToIdentityMatrix" );
                   elif l > 1 and IsHomalgMatrix( L[2] ) then
                       homalgSendBlocking( [ L[2], " = ", L[2], "^{0..(", j, "-2)} || map((ring ", M, ")^1, source ", M, ", {apply(toList(1..(numgens source ", M, ")), flatten entries ", M, "^{", i, "-1}, (k,l)->if k == ", j, " then 1_(ring ", M, ") else l)}) || ", L[2], "^{", j, "..(numgens target ", L[2], ")-1}" ], "need_command", "CopyRowToIdentityMatrix" );
                   fi;
                   
                 end,
               
               CopyColumnToIdentityMatrix :=
                 function( M, j, L, i )
                   local l;
                   
                   l := Length( L );
                   
                   if l > 1 and ForAll( L, IsHomalgMatrix ) then
                       homalgSendBlocking( [ L[1], " = ", L[1], "_{0..(", i, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {1_(ring ", M, ")} else {-l})) | ", L[1], "_{", i, "..(numgens source ", L[1], ")-1}" ], "need_command", "CopyColumnToIdentityMatrix" );
                       homalgSendBlocking( [ L[2], " = ", L[2], "_{0..(", i, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {1_(ring ", M, ")} else {l})) | ", L[2], "_{", i, "..(numgens source ", L[2], ")-1}" ], "need_command", "CopyColumnToIdentityMatrix" );
                   elif l > 0 and IsHomalgMatrix( L[1] ) then
                       homalgSendBlocking( [ L[1], " = ", L[1], "_{0..(", i, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {1_(ring ", M, ")} else {-l})) | ", L[1], "_{", i, "..(numgens source ", L[1], ")-1}" ], "need_command", "CopyColumnToIdentityMatrix" );
                   elif l > 1 and IsHomalgMatrix( L[2] ) then
                       homalgSendBlocking( [ L[2], " = ", L[2], "_{0..(", i, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {1_(ring ", M, ")} else {l})) | ", L[2], "_{", i, "..(numgens source ", L[2], ")-1}" ], "need_command", "CopyColumnToIdentityMatrix" );
                   fi;
                   
                 end,
               
               SetColumnToZero :=
                 function( M, i, j )
                   
                   homalgSendBlocking( [ M, " = ", M, "_{0..(", j, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {l} else {0})) | ", M, "_{", j, "..(numgens source ", M, ")-1}" ], "need_command", "SetColumnToZero" );
                   
                 end,
               
               GetCleanRowsPositions :=
                 function( M, clean_columns )
                   local clist, list_string;
                   
                   clist := clean_columns - 1;
                   list_string := homalgSendBlocking( [ "GetCleanRowsPositions(", M, ", {", clist, "})" ], "need_output", "GetCleanRowsPositions" );
                   
                   return StringToIntList( list_string );
                   
                 end,
               
               ConvertRowToTransposedMatrix :=
                 function( M, r, c )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "reshape(", R, "^", r, R, "^", c, M, ")" ], "ConvertRowToMatrix" );
                   
                 end,
               
               ConvertColumnToTransposedMatrix :=
                 function( M, r, c )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "reshape(", R, "^", r, R, "^", c, M, ")" ], "ConvertColumnToMatrix" );
                   
                 end,
               
               ConvertTransposedMatrixToRow :=
                 function( M )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "reshape(", R, "^1,", R, "^(numgens(source(", M, "))*numgens(target(", M, ")))", M, ")" ], "ConvertMatrixToRow" );
                   
                 end,
               
               ConvertTransposedMatrixToColumn :=
                 function( M )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "reshape(", R, "^(numgens(source(", M, "))*numgens(target(", M, "))),", R, "^1,", M, ")" ], "ConvertMatrixToColumn" );
                   
                 end,
               
               ## determined by CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries
               AffineDimension :=
                 function( mat )
                   
                   return Int( homalgSendBlocking( [ "dim(coker(", Involution( mat ), "))" ], "need_output", "AffineDimension" ) );
                   
                 end,
               
               ## do not add CoefficientsOf(Unreduced)NumeratorOfHilbertPoincareSeries
               ## since Macaulay2 does not support Hilbert* for non-graded modules
               CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries :=
                 function( mat, weights, degrees )
                   local R, hilb, n, coeffs, positions, ldeg, hdeg;
                   
                   if Set( weights ) <> [ 1 ] then
                       Error( "the homalgTable entry CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries for Macaulay2 does not yet support weights\n" );
                   fi;
                   
                   mat := Involution( mat );
                   
                   R := HomalgRing( mat );
                   
                   hilb := homalgSendBlocking( [ "CoefficientsOfLaurentPolynomial numerator hilbertSeries coker map(", R, "^{", -degrees, "},", R, "^", NumberColumns( mat ), mat, ")" ], "break_lists", "need_output", "HilbertPoincareSeries" );
                   
                   hilb := StringToIntList( hilb );
                   
                   n := Length( hilb );
                   
                   if n = 0 then
                       return [ 0 ];
                   fi;
                   
                   Assert( 0, IsEvenInt( n ) );
                   
                   n := n / 2;
                   
                   coeffs := hilb{[ 1 .. n ]};
                   
                   positions := hilb{[ n + 1 .. 2 * n ]};
                   
                   ldeg := positions[1];
                   hdeg := positions[n];
                   
                   hilb := ListWithIdenticalEntries( hdeg - ldeg + 2, 0 );
                   
                   hilb[hdeg - ldeg + 2] := ldeg;
                   
                   hilb{positions - ldeg + 1} := coeffs;
                   
                   return hilb;
                   
                 end,
               
               Eliminate :=
                 function( rel, indets, R )
                   
                   return homalgSendBlocking( [ "transpose gens(eliminate({", indets, "},ideal(", rel, ")))" ], "break_lists", R, "Eliminate" );
                   
                 end,
               
               DegreeOfRingElement :=
                 function( r, R )
                   
                   return Int( homalgSendBlocking( [ "DegreeForHomalg(", r, ")" ], "need_output", "DegreeOfRingElement" ) );
                   
                 end,
               
               MonomialMatrix :=
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "map(", R, "^(binomial(", i, "+#(", vars, ")-1,", i, ")),", R, "^1,transpose gens((ideal(", vars, "))^", i, "))" ], "break_lists", R, "MonomialMatrix" );
                   
                 end,
               
               Diff :=
                 function( D, N )
                   local R;
                   
                   R := HomalgRing( D );
                   
                   return homalgSendBlocking( [ "map(", R, "^", NumberRows( D ) * NumberRows( N ), ",", R, "^", NumberColumns( D ) * NumberColumns( N ), ",diff(", D, N, "))" ], "Diff" );
                   
                 end,
               
        )
 );
