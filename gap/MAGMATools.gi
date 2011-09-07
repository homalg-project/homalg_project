#############################################################################
##
##  MAGMATools.gi             RingsForHomalg package        Markus Kirschmer
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the rings provided by MAGMA.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForMAGMATools,
        
        rec(
               Zero := HomalgExternalRingElement( R -> homalgSendBlocking( [ "Zero(", R, ")" ], "need_output", HOMALG_IO.Pictograms.Zero ), "MAGMA", IsZero ),
               
               One := HomalgExternalRingElement( R -> homalgSendBlocking( [ "One(", R, ")" ], "need_output", HOMALG_IO.Pictograms.One ), "MAGMA", IsOne ),
               
               MinusOne := HomalgExternalRingElement( R -> homalgSendBlocking( [ "-One(", R, ")" ], "need_output", HOMALG_IO.Pictograms.MinusOne ), "MAGMA", IsMinusOne ),
               
               IsZero := r -> homalgSendBlocking( [ "IsZero(", r, ")" ] , "need_output", HOMALG_IO.Pictograms.IsZero ) = "true",
               
               IsOne := r -> homalgSendBlocking( [ "IsOne(", r, ")" ] , "need_output", HOMALG_IO.Pictograms.IsOne ) = "true",
               
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "-(", b, ")" ], "need_output", HOMALG_IO.Pictograms.Minus );
                   
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   
                   return homalgSendBlocking( [ "(", a, ")/(", u, ")"  ], "need_output", HOMALG_IO.Pictograms.DivideByUnit );
                   
                 end,
               
               IsUnit :=
                 function( R, u )
                   
                   return homalgSendBlocking( [ "IsUnit(", R, "!",  u, ")" ], "need_output", HOMALG_IO.Pictograms.IsUnit ) = "true";
                   
                 end,
               
               Sum :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "+", b ], "need_output", HOMALG_IO.Pictograms.Sum );
                   
                 end,
               
               Product :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "(", a, ")*(", b, ")" ], "need_output", HOMALG_IO.Pictograms.Product );
                   
                 end,
               
               Gcd :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "GreatestCommonDivisor(", a, b, ")" ], HOMALG_IO.Pictograms.CancelGcd );
                   
                 end,
               
               CancelGcd :=
                 function( a, b )
                   local a_g, b_g;
                   
                   homalgSendBlocking( [ "g:=GreatestCommonDivisor(", a, b, ")" ], "need_command", HOMALG_IO.Pictograms.Gcd );
                   a_g := homalgSendBlocking( [ "(", a, ") div g" ], HOMALG_IO.Pictograms.CancelGcd );
                   b_g := homalgSendBlocking( [ "(", b, ") div g" ], HOMALG_IO.Pictograms.CancelGcd );
                   
                   return [ a_g, b_g ];
                   
                 end,
               
               ShallowCopy := C -> homalgSendBlocking( [ C ], HOMALG_IO.Pictograms.CopyMatrix ),
               
               CopyMatrix :=
                 function( C, R )

                   return homalgSendBlocking( [ "imap(", C, R, ")" ], HOMALG_IO.Pictograms.CopyMatrix );

                 end,

               
               ZeroMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "ZeroMatrix(", HomalgRing( C ), NrRows( C ), NrColumns( C ), ")" ], HOMALG_IO.Pictograms.ZeroMatrix );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "ScalarMatrix(", HomalgRing( C ), NrRows( C ), ",1)" ], HOMALG_IO.Pictograms.IdentityMatrix );
                   
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, " eq ",  B ] , "need_output", HOMALG_IO.Pictograms.AreEqualMatrices ) = "true";
                   
                 end,
               
               Involution := M -> homalgSendBlocking( [ "Transpose(", M, ")" ], HOMALG_IO.Pictograms.Involution ),
               
               CertainRows :=
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "Matrix(", M, "[ \\", plist, "])" ], HOMALG_IO.Pictograms.CertainRows );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "Transpose(Matrix(Transpose(", M, ")[ \\",plist, "]))" ], HOMALG_IO.Pictograms.CertainColumns );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "VerticalJoin(", A, B, ")" ], HOMALG_IO.Pictograms.UnionOfRows );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "HorizontalJoin(", A, B, ")" ], HOMALG_IO.Pictograms.UnionOfColumns );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := Concatenation( [ "DiagonalJoin(<" ], e, [ ">)" ] );
                   
                   return homalgSendBlocking( f, HOMALG_IO.Pictograms.DiagMat );
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "TensorProduct(", A, B, ")" ], HOMALG_IO.Pictograms.KroneckerMat );
                   
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
                   
                   return StringToInt( homalgSendBlocking( [ "NumberOfRows(", C, ")" ], "need_output", HOMALG_IO.Pictograms.NrRows ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "NumberOfColumns(", C, ")" ], "need_output", HOMALG_IO.Pictograms.NrColumns ) );
                   
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsZero(", M, ")" ] , "need_output", HOMALG_IO.Pictograms.IsZeroMatrix ) = "true";
                   
                 end,
               
               IsIdentityMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsOne(", M, ")" ] , "need_output", HOMALG_IO.Pictograms.IsIdentityMatrix ) = "true";
                   
                 end,
               
               IsDiagonalMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsDiagonalMatrix(", M, ")" ] , "need_output", HOMALG_IO.Pictograms.IsDiagonalMatrix ) = "true";
                   
                 end,
               
               ZeroRows :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroRows(", C, ")" ], "need_output", HOMALG_IO.Pictograms.ZeroRows );
                   
                   return StringToIntList( list_string );
                   
                 end,
               
               ZeroColumns :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroColumns(", C, ")" ], "need_output", HOMALG_IO.Pictograms.ZeroColumns );
                   
                   return StringToIntList( list_string );
                   
                 end,
               
               GetColumnIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositions(", M, pos_list, ")" ], "need_output", HOMALG_IO.Pictograms.GetColumnIndependentUnitPositions ) );
                   
                 end,
               
               GetRowIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositions(", M, pos_list, ")" ], "need_output", HOMALG_IO.Pictograms.GetRowIndependentUnitPositions ) );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPosition(", M, pos_list, ")" ], "need_output", HOMALG_IO.Pictograms.GetUnitPosition );
                   
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
               
               DivideRowByUnit :=
                 function( M, i, u, j )
                   
                   homalgSendBlocking( [ "DivideRowByUnit(~", M, i, u, j, ")" ], "need_command", HOMALG_IO.Pictograms.DivideRowByUnit );
                   
                 end,
               
               DivideColumnByUnit :=
                 function( M, j, u, i )
                   
                   homalgSendBlocking( [ "DivideColumnByUnit(~", M, j, u, i, ")" ], "need_command", HOMALG_IO.Pictograms.DivideColumnByUnit );
                   
                 end,
               
               CopyRowToIdentityMatrix :=
                 function( M, i, L, j )
                   local l;
                   
                   l := Length( L );
                   
                   if l > 1 and ForAll( L, IsHomalgMatrix ) then
                       homalgSendBlocking( [ "CopyRowToIdentityMatrix2(", M, i, ",~", L[1], ",~", L[2], j, ")" ], "need_command", HOMALG_IO.Pictograms.CopyRowToIdentityMatrix );
                   elif l > 0 and IsHomalgMatrix( L[1] ) then
                       homalgSendBlocking( [ "CopyRowToIdentityMatrix(", M, i, ",~", L[1], j, -1, ")" ], "need_command", HOMALG_IO.Pictograms.CopyRowToIdentityMatrix );
                   elif l > 1 and IsHomalgMatrix( L[2] ) then
                       homalgSendBlocking( [ "CopyRowToIdentityMatrix(", M, i, ",~", L[2], j, 1, ")" ], "need_command", HOMALG_IO.Pictograms.CopyRowToIdentityMatrix );
                   fi;
                   
                 end,
               
               CopyColumnToIdentityMatrix :=
                 function( M, j, L, i )
                   local l;
                   
                   l := Length( L );
                   
                   if l > 1 and ForAll( L, IsHomalgMatrix ) then
                       homalgSendBlocking( [ "CopyColumnToIdentityMatrix2(", M, j, ",~", L[1], ",~", L[2], i, ")" ], "need_command", HOMALG_IO.Pictograms.CopyColumnToIdentityMatrix );
                   elif l > 0 and IsHomalgMatrix( L[1] ) then
                       homalgSendBlocking( [ "CopyColumnToIdentityMatrix(", M, j, ",~", L[1], i, -1, ")" ], "need_command", HOMALG_IO.Pictograms.CopyColumnToIdentityMatrix );
                   elif l > 1 and IsHomalgMatrix( L[2] ) then
                       homalgSendBlocking( [ "CopyColumnToIdentityMatrix(", M, j, ",~", L[2], i, 1, ")" ], "need_command", HOMALG_IO.Pictograms.CopyColumnToIdentityMatrix );
                   fi;
                   
                 end,
               
               SetColumnToZero :=
                 function( M, i, j )
                   
                   homalgSendBlocking( [ "SetColumnToZero(~", M, i, j, ")" ], "need_command", HOMALG_IO.Pictograms.SetColumnToZero );
                   
                 end,
               
               GetCleanRowsPositions :=
                 function( M, clean_columns )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "GetCleanRowsPositions(", M, clean_columns, ")" ], "need_output", HOMALG_IO.Pictograms.GetCleanRowsPositions );
                   
                   return StringToIntList( list_string );
                   
                 end,
               
               ## do not add CoefficientsOf(Unreduced)NumeratorOfHilbertPoincareSeries
               ## since MAGMA does not support Hilbert* for non-graded modules
               CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries :=
                 function( mat, weights, degrees )
                   local R, v, hilb;
                   
                   if Set( weights ) <> [ 1 ] then
                       Error( "the homalgTable entry CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries for MAGMA does not yet support weights\n" );
                   fi;
                   
                   R := HomalgRing( mat );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   hilb := homalgSendBlocking( [ v, "numer,", v, "ldeg:=", "HilbertNumerator(quo<GradedModule(", R, ",[", degrees, "])|RowSequence(", mat, ")>); Append(Coefficients(", v, "numer),-", v, "ldeg)" ], "break_lists", "need_output", HOMALG_IO.Pictograms.HilbertPoincareSeries );
                   
                   return StringToIntList( hilb );
                   
                 end,
               
               Eliminate :=
                 function( rel, indets, R )
                   local elim;
                   
                   elim := Difference( Indeterminates( R ), indets );
                   
                   return homalgSendBlocking( [ "Transpose(Matrix([GroebnerBasis(EliminationIdeal(ideal<", R, "|", rel, ">,{", elim, "}))]))" ], R, "break_lists", HOMALG_IO.Pictograms.Eliminate );
                   
                 end,
               
        )
 );
