#############################################################################
##
##  Macaulay2Tools.gi         RingsForHomalg package          Daniel Robertz
##
##  Copyright 2007-2009 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the external rings provided by the ring packages
##  of the GAP implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForMacaulay2Tools,
        
        rec(
               Zero := HomalgExternalRingElement( R -> homalgPointer( homalgSendBlocking( [ R, "#0" ], HOMALG_IO.Pictograms.Zero ) ), "Macaulay2", IsZero ),
               
               One := HomalgExternalRingElement( R -> homalgPointer( homalgSendBlocking( [ R, "#1" ], HOMALG_IO.Pictograms.One ) ), "Macaulay2", IsOne ),
               
               MinusOne := HomalgExternalRingElement( R -> homalgPointer( homalgSendBlocking( [ "-", R, "#1" ], HOMALG_IO.Pictograms.MinusOne ) ), "Macaulay2", IsMinusOne ),
               
               IsZero := r -> homalgSendBlocking( [ "zero(", r, ")" ] , "need_output", HOMALG_IO.Pictograms.IsZero ) = "true",
               
               IsOne := r -> homalgSendBlocking( [ r, "==", One( r ) ] , "need_output", HOMALG_IO.Pictograms.IsOne ) = "true",
               
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "toString(", a, "-(", b, "))" ], "need_output", HOMALG_IO.Pictograms.Minus );
                   
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   
                   return homalgSendBlocking( [ "toString((", a, ")/(", u, "))"  ], "need_output", HOMALG_IO.Pictograms.DivideByUnit );
                   
                 end,
               
               IsUnit :=
                 function( R, u )
                   
                   return homalgSendBlocking( [ "isUnit(", u, ")" ], "need_output", HOMALG_IO.Pictograms.IsUnit, R ) = "true";
                   
                 end,
	       
               Sum :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "toString(", a, "+", b, ")" ], "need_output", HOMALG_IO.Pictograms.Sum );
                   
                 end,
               
               Product :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "toString((", a, ")*(", b, "))" ], "need_output", HOMALG_IO.Pictograms.Product );
                   
                 end,
               
               Gcd :=
                 function( a, b )

                   return homalgSendBlocking( [ "toString(gcd(", a, b, "))" ], "need_output", HOMALG_IO.Pictograms.Gcd );

                 end,
               
               CancelGcd :=
                 function( a, b )
                   local g, a_g, b_g;
                   
                   g := homalgSendBlocking( [ "toString(gcd(", a, b, "))" ], "need_output", HOMALG_IO.Pictograms.Gcd );
                   a_g := homalgSendBlocking( [ "(", a, ") // (", g, ")" ], HOMALG_IO.Pictograms.CancelGcd );
                   b_g := homalgSendBlocking( [ "(", b, ") // (", g, ")" ], HOMALG_IO.Pictograms.CancelGcd );
                   
                   return [ a_g, b_g ];
                   
                 end,
               
               ShallowCopy := C -> homalgSendBlocking( [ C ], HOMALG_IO.Pictograms.CopyMatrix ),
               
               CopyMatrix :=
                 function( C, R )
                   
                   return homalgSendBlocking( [ "substitute(", C, R, ")" ], R, HOMALG_IO.Pictograms.CopyMatrix );
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   local R;
		   
		   R := HomalgRing( C );
		   
                   return homalgSendBlocking( [ "map(", R, "^", NrRows( C ), R, "^", NrColumns( C ), ",0)" ], HOMALG_IO.Pictograms.ZeroMatrix );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "id_(", HomalgRing( C ), "^", NrRows( C ), ")" ], HOMALG_IO.Pictograms.IdentityMatrix );
                   
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   #return homalgSendBlocking( [ "zero(", A, "-", B, ")" ], "need_output", HOMALG_IO.Pictograms.AreEqualMatrices ) = "true";
		   
                   return homalgSendBlocking( [ A, "==", B ] , "need_output", HOMALG_IO.Pictograms.AreEqualMatrices ) = "true";
                   
                 end,
               
               Involution := M -> homalgSendBlocking( [ "Involution(", M, ")" ], HOMALG_IO.Pictograms.Involution ),
               
               CertainRows :=
                 function( M, plist )
                   #local R;
		   
		   #R := HomalgRing( M );
                   
                   plist := plist - 1;
		   
                   return homalgSendBlocking( [ M, "^{", plist, "}" ], HOMALG_IO.Pictograms.CertainRows );
		   
		   # operator '^' forgets grading!
                   #return homalgSendBlocking( [ "map(", R, "^(-(degrees target ", M, ")_{", plist, "}), source ", M, ", ", M, "^{", plist, "})" ], HOMALG_IO.Pictograms.CertainRows );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
		   plist := plist - 1;
                   return homalgSendBlocking( [ M, "_{", plist, "}" ], HOMALG_IO.Pictograms.CertainColumns );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "||", B ], HOMALG_IO.Pictograms.UnionOfRows );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "|", B ], HOMALG_IO.Pictograms.UnionOfColumns );
                   
                 end,
               
               DiagMat :=
                 function( e )
		   
                   return homalgSendBlocking( [ "fold((i,j)->i ++ j, {", e, "})" ], HomalgRing( e[1] ), HOMALG_IO.Pictograms.DiagMat );
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "**", B ], HOMALG_IO.Pictograms.KroneckerMat );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return homalgSendBlocking( [ "(", a, ")*", A ], HOMALG_IO.Pictograms.MulMat );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "+", B ], HOMALG_IO.Pictograms.AddMat );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "-", B ], HOMALG_IO.Pictograms.SubMat );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "*", B ], HOMALG_IO.Pictograms.Compose );
                   
                 end,
               
               NrRows :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "numgens(target(", C, "))" ], "need_output", HOMALG_IO.Pictograms.NrRows ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "numgens(source(", C, "))" ], "need_output", HOMALG_IO.Pictograms.NrColumns ) );
                   
                 end,
               
               Determinant :=
                 function( C )
                   
                   return homalgSendBlocking( [ "det(", C, ")" ], HOMALG_IO.Pictograms.Determinant );
                   
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "zero(", M, ")" ] , "need_output", HOMALG_IO.Pictograms.IsZeroMatrix ) = "true";
                   
                 end,
               
               IsIdentityMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsIdentityMatrix(", M, ")" ], "need_output", HOMALG_IO.Pictograms.IsIdentityMatrix ) = "true";
                   
                 end,
               
               IsDiagonalMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsDiagonalMatrix(", M, ")" ] , "need_output", HOMALG_IO.Pictograms.IsDiagonalMatrix ) = "true";
                   
                 end,
               
               ZeroRows :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroRows(", C, ")" ], "need_output", HOMALG_IO.Pictograms.ZeroRows );
                   
                   return EvalString( list_string );
                   
                 end,
               
               ZeroColumns :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroColumns(", C, ")" ], "need_output", HOMALG_IO.Pictograms.ZeroColumns );
                   
                   return EvalString( list_string );
                   
                 end,
               
               GetColumnIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositions(", M, ", {", pos_list, "})" ], "need_output", HOMALG_IO.Pictograms.GetColumnIndependentUnitPositions ) );
                   
                 end,
               
               GetRowIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositions(", M, ", {", pos_list, "})" ], "need_output", HOMALG_IO.Pictograms.GetRowIndependentUnitPositions ) );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPosition(", M, ", {", pos_list, "})" ], "need_output", HOMALG_IO.Pictograms.GetUnitPosition );
                   
                   if list_string = "fail" then
                       return fail;
                   else
                       return StringToIntList( list_string );
                   fi;
                   
                 end,
               
               PositionOfFirstNonZeroEntryPerRow :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "PositionOfFirstNonZeroEntryPerRow( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.PositionOfFirstNonZeroEntryPerRow );
                   
                   L := StringToIntList( L );
                   
                   if Length( L ) = 1 then
                       return ListWithIdenticalEntries( NrRows( M ), L[1] );
                   fi;
                   
                   return L;
                   
                 end,
               
               PositionOfFirstNonZeroEntryPerColumn :=
                 function( M )
                   local L;
                   
                   L := homalgSendBlocking( [ "PositionOfFirstNonZeroEntryPerColumn( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.PositionOfFirstNonZeroEntryPerColumn );
                   
                   L := StringToIntList( L );
                   
                   if Length( L ) = 1 then
                       return ListWithIdenticalEntries( NrColumns( M ), L[1] );
                   fi;
                   
                   return L;
                   
                 end,
               
               DivideEntryByUnit :=
                 function( M, i, j, u )
                   
                   homalgSendBlocking( [ M, " = ", M, "_{0..(", j, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {l // ", u, "} else {l})) | ", M, "_{", j, "..(numgens source ", M, ")-1}" ], "need_command", HOMALG_IO.Pictograms.DivideEntryByUnit );
                   
                 end,
               
               DivideRowByUnit :=
                 function( M, i, u, j )
                   
                   if j > 0 then
		       homalgSendBlocking( [ M, " = ", M, "^{0..(", i, "-2)} || map((ring ", M, ")^1, source ", M, ", {apply(toList(1..(numgens source ", M, ")), flatten entries ", M, "^{", i, "-1}, (k,l)->if k == ", j, " then 1_(ring ", M, ") else l // ", u, ")}) || ", M, "^{", i, "..(numgens target ", M, ")-1}" ], "need_command", HOMALG_IO.Pictograms.DivideRowByUnit );
                   else
                       homalgSendBlocking( [ M, " = ", M, "^{0..(", i, "-2)} || map((ring ", M, ")^1, source ", M, ", apply(entries ", M, "^{", i, "-1}, k->apply(k, l->l // ", u, "))) || ", M, "^{", i, "..(numgens target ", M, ")-1}" ], "need_command", HOMALG_IO.Pictograms.DivideRowByUnit );
                   fi;
		                      
                 end,
               
               DivideColumnByUnit :=
                 function( M, j, u, i )
                   
                   if i > 0 then
                       homalgSendBlocking( [ M, " = ", M, "_{0..(", j, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {1_(ring ", M, ")} else {l // ", u, "})) | ", M, "_{", j, "..(numgens source ", M, ")-1}" ], "need_command", HOMALG_IO.Pictograms.DivideColumnByUnit );
		   else
                       homalgSendBlocking( [ M, " = ", M, "_{0..(", j, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(entries ", M, "_(", j, "-1), k->{k // ", u, "})) | ", M, "_{", j, "..(numgens source ", M, ")-1}" ], "need_command", HOMALG_IO.Pictograms.DivideColumnByUnit );
		   fi;
                   
                 end,
               
               CopyRowToIdentityMatrix :=
                 function( M, i, L, j )
                   local l;
                   
                   l := Length( L );
                   
                   if l > 1 and ForAll( L, IsHomalgMatrix ) then
		       homalgSendBlocking( [ L[1], " = ", L[1], "^{0..(", j, "-2)} || map((ring ", M, ")^1, source ", M, ", {apply(toList(1..(numgens source ", M, ")), flatten entries ", M, "^{", i, "-1}, (k,l)->if k == ", j, " then 1_(ring ", M, ") else -l)}) || ", L[1], "^{", j, "..(numgens target ", L[1], ")-1}" ], "need_command", HOMALG_IO.Pictograms.CopyRowToIdentityMatrix );
		       homalgSendBlocking( [ L[2], " = ", L[2], "^{0..(", j, "-2)} || map((ring ", M, ")^1, source ", M, ", {apply(toList(1..(numgens source ", M, ")), flatten entries ", M, "^{", i, "-1}, (k,l)->if k == ", j, " then 1_(ring ", M, ") else l)}) || ", L[2], "^{", j, "..(numgens target ", L[2], ")-1}" ], "need_command", HOMALG_IO.Pictograms.CopyRowToIdentityMatrix );
                   elif l > 0 and IsHomalgMatrix( L[1] ) then
		       homalgSendBlocking( [ L[1], " = ", L[1], "^{0..(", j, "-2)} || map((ring ", M, ")^1, source ", M, ", {apply(toList(1..(numgens source ", M, ")), flatten entries ", M, "^{", i, "-1}, (k,l)->if k == ", j, " then 1_(ring ", M, ") else -l)}) || ", L[1], "^{", j, "..(numgens target ", L[1], ")-1}" ], "need_command", HOMALG_IO.Pictograms.CopyRowToIdentityMatrix );
                   elif l > 1 and IsHomalgMatrix( L[2] ) then
		       homalgSendBlocking( [ L[2], " = ", L[2], "^{0..(", j, "-2)} || map((ring ", M, ")^1, source ", M, ", {apply(toList(1..(numgens source ", M, ")), flatten entries ", M, "^{", i, "-1}, (k,l)->if k == ", j, " then 1_(ring ", M, ") else l)}) || ", L[2], "^{", j, "..(numgens target ", L[2], ")-1}" ], "need_command", HOMALG_IO.Pictograms.CopyRowToIdentityMatrix );
                   fi;
		   
                 end,
               
               CopyColumnToIdentityMatrix :=
                 function( M, j, L, i )
                   local l;
                   
                   l := Length( L );
                   
                   if l > 1 and ForAll( L, IsHomalgMatrix ) then
                       homalgSendBlocking( [ L[1], " = ", L[1], "_{0..(", i, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {1_(ring ", M, ")} else {-l})) | ", L[1], "_{", i, "..(numgens source ", L[1], ")-1}" ], "need_command", HOMALG_IO.Pictograms.CopyColumnToIdentityMatrix );
                       homalgSendBlocking( [ L[2], " = ", L[2], "_{0..(", i, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {1_(ring ", M, ")} else {l})) | ", L[2], "_{", i, "..(numgens source ", L[2], ")-1}" ], "need_command", HOMALG_IO.Pictograms.CopyColumnToIdentityMatrix );
                   elif l > 0 and IsHomalgMatrix( L[1] ) then
                       homalgSendBlocking( [ L[1], " = ", L[1], "_{0..(", i, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {1_(ring ", M, ")} else {-l})) | ", L[1], "_{", i, "..(numgens source ", L[1], ")-1}" ], "need_command", HOMALG_IO.Pictograms.CopyColumnToIdentityMatrix );
                   elif l > 1 and IsHomalgMatrix( L[2] ) then
                       homalgSendBlocking( [ L[2], " = ", L[2], "_{0..(", i, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {1_(ring ", M, ")} else {l})) | ", L[2], "_{", i, "..(numgens source ", L[2], ")-1}" ], "need_command", HOMALG_IO.Pictograms.CopyColumnToIdentityMatrix );
                   fi;
		   
                 end,
               
               SetColumnToZero :=
                 function( M, i, j )
                   
                   homalgSendBlocking( [ M, " = ", M, "_{0..(", j, "-2)} | map(target ", M, ", (ring ", M, ")^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", j, "-1), (k,l)->if k == ", i, " then {l} else {0})) | ", M, "_{", j, "..(numgens source ", M, ")-1}" ], "need_command", HOMALG_IO.Pictograms.SetColumnToZero );
                   
                 end,
               
               GetCleanRowsPositions :=
                 function( M, clean_columns )
                   local clist, list_string;
                   
		   clist := clean_columns - 1;
                   list_string := homalgSendBlocking( [ "GetCleanRowsPositions(", M, ", {", clist, "})" ], "need_output", HOMALG_IO.Pictograms.GetCleanRowsPositions );
                   
                   return StringToIntList( list_string );
                   
                 end,
               
               ConvertRowToMatrix :=
                 function( M, r, c )
                   local R;
		   
		   R := HomalgRing( M );
		   
                   return homalgSendBlocking( [ "reshape(", R, "^", r, R, "^", c, M, ")" ], HOMALG_IO.Pictograms.ConvertRowToMatrix );
                   
                 end,
               
               ConvertColumnToMatrix :=
                 function( M, r, c )
                   local R;
		   
		   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "reshape(", R, "^", r, R, "^", c, M, ")" ], HOMALG_IO.Pictograms.ConvertColumnToMatrix );
                   
                 end,
               
               ConvertMatrixToRow :=
                 function( M )
                   local R;
		   
		   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "reshape(", R, "^1,", R, "^(numgens(source(", M, "))*numgens(target(", M, ")))", M, ")" ], HOMALG_IO.Pictograms.ConvertMatrixToRow );
                   
                 end,
               
               ConvertMatrixToColumn :=
                 function( M )
                   local R;
		   
		   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "reshape(", R, "^(numgens(source(", M, "))*numgens(target(", M, "))),", R, "^1,", M, ")" ], HOMALG_IO.Pictograms.ConvertMatrixToColumn );
                   
                 end,
	       
               ## determined by CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries
               AffineDimension :=
                 function( mat )
                   
                   return Int( homalgSendBlocking( [ "dim(coker(transpose(", mat, ")))" ], "need_output", HOMALG_IO.Pictograms.AffineDimension ) );
                   
                 end,
               
               Eliminate :=
                 function( rel, indets, R )
                   
                   return homalgSendBlocking( [ "transpose gens(eliminate({", indets, "},ideal(", rel, ")))" ], "break_lists", R, HOMALG_IO.Pictograms.Eliminate );
                   
                 end,
               
        )
 );
