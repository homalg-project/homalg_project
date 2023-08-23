# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the rings provided by MAGMA.

####################################
#
# global variables:
#
####################################

BindGlobal( "CommonHomalgTableForMAGMATools",
        
        rec(
               Zero := HomalgExternalRingElement( R -> homalgSendBlocking( [ "Zero(", R, ")" ], "Zero" ), "MAGMA", IsZero ),
               
               One := HomalgExternalRingElement( R -> homalgSendBlocking( [ "One(", R, ")" ], "One" ), "MAGMA", IsOne ),
               
               MinusOne := HomalgExternalRingElement( R -> homalgSendBlocking( [ "-One(", R, ")" ], "MinusOne" ), "MAGMA", IsMinusOne ),
               
               RingElement := R -> r -> homalgSendBlocking( [ R, "!(", r, ")" ], "define" ),
               
               IsZero := r -> homalgSendBlocking( [ "IsZero(", r, ")" ] , "need_output", "IsZero" ) = "true",
               
               IsOne := r -> homalgSendBlocking( [ "IsOne(", r, ")" ] , "need_output", "IsOne" ) = "true",
               
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "-(", b, ")" ], "Minus" );
                   
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   
                   return homalgSendBlocking( [ "(", a, ")/(", u, ")"  ], "DivideByUnit" );
                   
                 end,
               
               IsUnit :=
                 function( R, u )
                   
                   return homalgSendBlocking( [ "IsUnit(", R, "!",  u, ")" ], "need_output", "IsUnit" ) = "true";
                   
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
                   
                   return homalgSendBlocking( [ "GreatestCommonDivisor(", a, b, ")" ], "CancelGcd" );
                   
                 end,
               
               CancelGcd :=
                 function( a, b )
                   local a_g, b_g;
                   
                   homalgSendBlocking( [ "g:=GreatestCommonDivisor(", a, b, ")" ], "need_command", "Gcd" );
                   a_g := homalgSendBlocking( [ "(", a, ") div g" ], "CancelGcd" );
                   b_g := homalgSendBlocking( [ "(", b, ") div g" ], "CancelGcd" );
                   
                   return [ a_g, b_g ];
                   
                 end,
               
               # CopyElement :=
               #   function( r, R )
                   
               #     return homalgSendBlocking( [ R, "!", r ], HomalgRing( r ), "CopyElement" );
                   
               #   end,
               
               ShallowCopy := C -> homalgSendBlocking( [ C ], "CopyMatrix" ),
               
               CopyMatrix :=
                 function( C, R )
                   local S;
                   
                   S := HomalgRing( C );
                   
                   if HasRelativeIndeterminatesOfPolynomialRing( R ) and
                      HasCoefficientsRing( S ) and
                      HasIsFieldForHomalg( CoefficientsRing( S ) ) and IsFieldForHomalg( CoefficientsRing( S ) ) then
                       return Eval( ConvertHomalgMatrixViaFile( C, R ) );
                   fi;
                   
                   return homalgSendBlocking( [ "imap(", C, R, ")" ], "CopyMatrix" );
                   
                 end,

               
               ZeroMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "ZeroMatrix(", HomalgRing( C ), NumberRows( C ), NumberColumns( C ), ")" ], "ZeroMatrix" );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "ScalarMatrix(", HomalgRing( C ), NumberRows( C ), ",1)" ], "IdentityMatrix" );
                   
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, " eq ",  B ] , "need_output", "AreEqualMatrices" ) = "true";
                   
                 end,
               
               Involution := M -> homalgSendBlocking( [ "Transpose(", M, ")" ], "Involution" ),
               
               TransposedMatrix := M -> homalgSendBlocking( [ "Transpose(", M, ")" ], "TransposedMatrix" ),
               
               CertainRows :=
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "Matrix(", M, "[ \\", plist, "])" ], "CertainRows" );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "Transpose(Matrix(Transpose(", M, ")[ \\",plist, "]))" ], "CertainColumns" );
                   
                 end,
               
               UnionOfRowsPair :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "VerticalJoin(", A, B, ")" ], "UnionOfRows" );
                   
                 end,
               
               UnionOfColumnsPair :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "HorizontalJoin(", A, B, ")" ], "UnionOfColumns" );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := Concatenation( [ "DiagonalJoin(<" ], e, [ ">)" ] );
                   
                   return homalgSendBlocking( f, "DiagMat" );
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "TensorProduct(", A, B, ")" ], "KroneckerMat" );
                   
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
                   
                   return StringToInt( homalgSendBlocking( [ "NumberOfRows(", C, ")" ], "need_output", "NumberRows" ) );
                   
                 end,
               
               NumberColumns :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "NumberOfColumns(", C, ")" ], "need_output", "NumberColumns" ) );
                   
                 end,
               
               Determinant :=
                 function( C )
                   
                   return homalgSendBlocking( [ "Determinant(", C, ")" ], "Determinant" );
                   
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsZero(", M, ")" ] , "need_output", "IsZeroMatrix" ) = "true";
                   
                 end,
               
               IsIdentityMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsOne(", M, ")" ] , "need_output", "IsIdentityMatrix" ) = "true";
                   
                 end,
               
               IsDiagonalMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsDiagonalMatrix(", M, ")" ] , "need_output", "IsDiagonalMatrix" ) = "true";
                   
                 end,
               
               ZeroRows :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroRows(", C, ")" ], "need_output", "ZeroRows" );
                   
                   return StringToIntList( list_string );
                   
                 end,
               
               ZeroColumns :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroColumns(", C, ")" ], "need_output", "ZeroColumns" );
                   
                   return StringToIntList( list_string );
                   
                 end,
               
               GetColumnIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositions(", M, pos_list, ")" ], "need_output", "GetColumnIndependentUnitPositions" ) );
                   
                 end,
               
               GetRowIndependentUnitPositions :=
                 function( M, pos_list )
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositions(", M, pos_list, ")" ], "need_output", "GetRowIndependentUnitPositions" ) );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPosition(", M, pos_list, ")" ], "need_output", "GetUnitPosition" );
                   
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
               
               DivideRowByUnit :=
                 function( M, i, u, j )
                   
                   homalgSendBlocking( [ "DivideRowByUnit(~", M, i, u, j, ")" ], "need_command", "DivideRowByUnit" );
                   
                 end,
               
               DivideColumnByUnit :=
                 function( M, j, u, i )
                   
                   homalgSendBlocking( [ "DivideColumnByUnit(~", M, j, u, i, ")" ], "need_command", "DivideColumnByUnit" );
                   
                 end,
               
               CopyRowToIdentityMatrix :=
                 function( M, i, L, j )
                   local l;
                   
                   l := Length( L );
                   
                   if l > 1 and ForAll( L, IsHomalgMatrix ) then
                       homalgSendBlocking( [ "CopyRowToIdentityMatrix2(", M, i, ",~", L[1], ",~", L[2], j, ")" ], "need_command", "CopyRowToIdentityMatrix" );
                   elif l > 0 and IsHomalgMatrix( L[1] ) then
                       homalgSendBlocking( [ "CopyRowToIdentityMatrix(", M, i, ",~", L[1], j, -1, ")" ], "need_command", "CopyRowToIdentityMatrix" );
                   elif l > 1 and IsHomalgMatrix( L[2] ) then
                       homalgSendBlocking( [ "CopyRowToIdentityMatrix(", M, i, ",~", L[2], j, 1, ")" ], "need_command", "CopyRowToIdentityMatrix" );
                   fi;
                   
                 end,
               
               CopyColumnToIdentityMatrix :=
                 function( M, j, L, i )
                   local l;
                   
                   l := Length( L );
                   
                   if l > 1 and ForAll( L, IsHomalgMatrix ) then
                       homalgSendBlocking( [ "CopyColumnToIdentityMatrix2(", M, j, ",~", L[1], ",~", L[2], i, ")" ], "need_command", "CopyColumnToIdentityMatrix" );
                   elif l > 0 and IsHomalgMatrix( L[1] ) then
                       homalgSendBlocking( [ "CopyColumnToIdentityMatrix(", M, j, ",~", L[1], i, -1, ")" ], "need_command", "CopyColumnToIdentityMatrix" );
                   elif l > 1 and IsHomalgMatrix( L[2] ) then
                       homalgSendBlocking( [ "CopyColumnToIdentityMatrix(", M, j, ",~", L[2], i, 1, ")" ], "need_command", "CopyColumnToIdentityMatrix" );
                   fi;
                   
                 end,
               
               SetColumnToZero :=
                 function( M, i, j )
                   
                   homalgSendBlocking( [ "SetColumnToZero(~", M, i, j, ")" ], "need_command", "SetColumnToZero" );
                   
                 end,
               
               ConvertRowToMatrix :=
                 function( M, r, c )
                   
                   return homalgSendBlocking( [ "ConvertRowToMatrix(", M, r, c, HomalgRing( M ), ")" ], "ConvertRowToMatrix" );
                   
                 end,
               
               GetCleanRowsPositions :=
                 function( M, clean_columns )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "GetCleanRowsPositions(", M, clean_columns, ")" ], "need_output", "GetCleanRowsPositions" );
                   
                   return StringToIntList( list_string );
                   
                 end,
               
               AffineDimensionOfIdeal :=
                 function( mat )
                   local R, v;
                   
                   R := HomalgRing ( mat );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   mat := EntriesOfHomalgMatrix( mat );
                   
                   return Int( homalgSendBlocking( [ v, "d := Dimension(ideal<", R, "|", mat, ">); ", v, "d" ], "break_lists", "need_output", "AffineDimension" ) );
                   
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
                   
                   hilb := homalgSendBlocking( [ v, "numer,", v, "ldeg:=", "HilbertNumerator(quo<GradedModule(", R, ",[", degrees, "])|RowSequence(", mat, ")>); Append(Coefficients(", v, "numer),-", v, "ldeg)" ], "break_lists", "need_output", "HilbertPoincareSeries" );
                   
                   return StringToIntList( hilb );
                   
                 end,
               
               RadicalSubobject :=
                 function( mat )
                   local R;
                   
                   R := HomalgRing( mat );
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only radical of one-column matrices is supported\n" );
                   fi;
                   
                   mat := EntriesOfHomalgMatrix( mat );
                   
                   return homalgSendBlocking( [ "Transpose(Matrix([GroebnerBasis(Radical(ideal<", R, "|", mat, ">))]))" ], "RadicalSubobject" );
                   
                 end,
               
               IsPrime :=
                 function( mat )
                   local R;
                   
                   R := HomalgRing( mat );
                   
                   mat := EntriesOfHomalgMatrix( mat );
                   
                   return homalgSendBlocking( [ "IsPrime(ideal<", R, "|", mat, ">)" ], "need_output", "break_lists", "PrimaryDecomposition" ) = "true";
                   
                 end,
               
               PrimaryDecomposition :=
                 function( mat )
                   local R, v, c;
                   
                   R := HomalgRing( mat );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   mat := EntriesOfHomalgMatrix( mat );
                   
                   homalgSendBlocking( [ v, "Q, ", v, "P := PrimaryDecomposition(ideal<", R, "|", mat, ">)" ], "need_command", "break_lists", "PrimaryDecomposition" );
                   homalgSendBlocking( [ v, "Q := [ GroebnerBasis( x ) : x in ", v, "Q ]" ], R, "need_command", "PrimaryDecomposition" );
                   homalgSendBlocking( [ v, "P := [ GroebnerBasis( x ) : x in ", v, "P ]" ], R, "need_command", "PrimaryDecomposition" );
                   
                   c := Int( homalgSendBlocking( [ "#", v, "Q" ], "need_output", R, "PrimaryDecomposition" ) );
                   
                   return
                     List( [ 1 .. c ],
                           function( i )
                             local primary, prime;
                             
                             primary := HomalgVoidMatrix( "unkown_number_of_rows", 1, R );
                             prime := HomalgVoidMatrix( "unkown_number_of_rows", 1, R );
                             
                             homalgSendBlocking( [ primary, " := Matrix(", R, ", #(", v, "Q[", i, "]), 1, ", v, "Q[", i, "] )" ], "need_command", "PrimaryDecomposition" );
                             homalgSendBlocking( [ prime, " := Matrix(", R, ", #(", v, "P[", i, "]), 1, ", v, "P[", i, "] )" ], "need_command", "PrimaryDecomposition" );
                             
                             return [ primary, prime ];
                             
                           end
                         );
                   
                 end,
               
               RadicalDecomposition :=
                 function( mat )
                   local R, v, c;
                   
                   R := HomalgRing( mat );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   mat := EntriesOfHomalgMatrix( mat );
                   
                   homalgSendBlocking( [ v, "P := RadicalDecomposition(ideal<", R, "|", mat, ">)" ], "need_command", "break_lists", "PrimaryDecomposition" );
                   homalgSendBlocking( [ v, "P := [ GroebnerBasis( x ) : x in ", v, "P ]" ], R, "need_command", "PrimaryDecomposition" );
                   
                   c := Int( homalgSendBlocking( [ "#", v, "P" ], "need_output", R, "PrimaryDecomposition" ) );
                   
                   return
                     List( [ 1 .. c ],
                           function( i )
                             local prime;
                             
                             prime := HomalgVoidMatrix( "unkown_number_of_rows", 1, R );
                             
                             homalgSendBlocking( [ prime, " := Matrix(", R, ", #(", v, "P[", i, "]), 1, ", v, "P[", i, "] )" ], "need_command", "PrimaryDecomposition" );
                             
                             return prime;
                             
                           end
                         );
                   
                 end,
               
               Eliminate :=
                 function( rel, indets, R )
                   local elim;
                   
                   elim := Difference( Indeterminates( R ), indets );
                   
                   return homalgSendBlocking( [ "Transpose(Matrix([GroebnerBasis(EliminationIdeal(ideal<", R, "|", rel, ">,{", elim, "}))]))" ], "break_lists", "Eliminate" );
                   
                 end,
               
               Coefficients :=
                 function( poly, var )
                   local R, y, vars, coeffs, d;
                   
                   R := HomalgRing( poly );
                   
                   if HasRelativeIndeterminatesOfPolynomialRing( R ) then
                       y := RelativeIndeterminatesOfPolynomialRing( R );
                       if y <> var then
                           Error( "the list of given variables does not coincide with the list of relative indeterminates\n" );
                       elif Length( y ) > 1 then
                           Error( "this table entry can only handle univariate polynomial rings over some base ring\n" );
                       fi;
                       y := y[1];
                       
                       vars := homalgSendBlocking( [ "Reverse(MonomialsUnivariate(", poly, y, "))" ], R, "Coefficients" );
                       coeffs := homalgSendBlocking( [ "Reverse(Coefficients(", poly, y, "))" ], R, "Coefficients" );
                       
                   else
                       
                       vars := homalgSendBlocking( [ "Monomials(", poly, ")" ], R, "Coefficients" );
                       coeffs := homalgSendBlocking( [ "Coefficients(", poly, ")" ], R, "Coefficients" );
                       
                   fi;
                   
                   d := Int( homalgSendBlocking( [ "#", coeffs ], "need_output", R, "Coefficients" ) );
                   
                   homalgSendBlocking( [ coeffs, ":=Matrix(", R, d, 1, coeffs, ")" ], "need_command", R, "Coefficients" );
                   
                   coeffs := HomalgMatrix( coeffs, d, 1, R );
                   
                   d := NonZeroRows( coeffs );
                   
                   coeffs := Eval( CertainRows( coeffs, d ) );
                   
                   homalgSendBlocking( [ vars, ":=Matrix(", R, Length( d ), 1, vars, ")" ], "need_command", R, "Coefficients" );
                   
                   return [ vars, coeffs ];
                   
                 end,
               
               DegreeOfRingElement :=
                 function( r, R )
                   local y;
                   
                   if HasRelativeIndeterminatesOfPolynomialRing( R ) then
                       y := RelativeIndeterminatesOfPolynomialRing( R );
                       if Length( y ) > 1 then
                           Error( "this table entry can only handle univariate polynomial rings over some base ring\n" );
                       fi;
                       y := y[1];
                       
                       return Int( homalgSendBlocking( [ "Deg2(", r, R, y, ")" ], "need_output", "DegreeOfRingElement" ) );
                   fi;
                   
                   return Int( homalgSendBlocking( [ "Deg(", r, R, ")" ], "need_output", "DegreeOfRingElement" ) );
                   
                 end,
               
               CoefficientsOfUnivariatePolynomial :=
                 function( r, var )
                   local R, y, coeffs, d;
                   
                   R := HomalgRing( r );
                   
                   if HasRelativeIndeterminatesOfPolynomialRing( R ) then
                       y := RelativeIndeterminatesOfPolynomialRing( R );
                       if y <> [ var ] then
                           Error( "the list of given variables does not coincide with the list of relative indeterminates\n" );
                       elif Length( y ) > 1 then
                           Error( "this table entry can only handle univariate polynomial rings over some base ring\n" );
                       fi;
                       y := y[1];
                   else
                       y := var;
                   fi;
                   
                   coeffs := homalgSendBlocking( [ "Coefficients(", r, y, ")" ], R, "Coefficients" );
                   
                   d := Int( homalgSendBlocking( [ "#", coeffs ], "need_output", R, "Coefficients" ) );
                   
                   homalgSendBlocking( [ coeffs, ":=Matrix(", R, 1, d, coeffs, ")" ], "need_command", R, "Coefficients" );
                   
                   return coeffs;
                   
                 end,
               
               LeadingIdeal :=
                 function( mat )
                   local R;
                   
                   R := HomalgRing( mat );
                   
                   return homalgSendBlocking( [ "Transpose(Matrix([GroebnerBasis(LeadingMonomialIdeal(ideal<", R, "|", EntriesOfHomalgMatrix( mat ), ">))]))" ], "break_lists", "LeadingModule" );
                   
                 end,
               
               
               MonomialMatrix :=
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "Matrix(1,MonomialsOfDegree(", R, i, ",{", R, ".i : i in [ 1 .. Rank(", R, ")]} diff {", vars, "}))" ], "break_lists", "MonomialMatrix" );
                   
                 end,
               
               Diff :=
                 function( D, N )
                   
                   return homalgSendBlocking( [ "Diff(", D, N, ")" ], "Diff" );
                   
                 end,
               
               Pullback :=
                 function( phi, M )
                   
                   if not IsBound( phi!.RingMap ) then
                       phi!.RingMap :=
                         homalgSendBlocking( [ "hom< ", Source( phi ), " -> ", Range( phi ), " | ", ImagesOfRingMap( phi ), " >" ], Range( phi ), "break_lists", "define" );
                   fi;
                   
                   Eval( M ); ## the following line might reset Range( phi ) to HomalgRing( M ) in order to evaluate the (eventually lazy) matrix M -> error
                   
                   return homalgSendBlocking( [ "ChangeRing(", M, phi!.RingMap, ")" ], Range( phi ), "Pullback" );
                   
                 end,
               
               Evaluate :=
                 function( p, L )
                   
                   if Length( L ) > 2 then
                       Error( "MAGMA only supports Evaluate( p, var1, val1, var2, val2, ...)\n" );
                   fi;
                   
                   return homalgSendBlocking( [ "Evaluate(", p, L, ")" ], "break_lists", "Evaluate" );
                   
                 end,
               
               NumeratorAndDenominatorOfPolynomial :=
                 function( p )
                   local R, numer, denom;
                   
                   R := HomalgRing( p );
                   
                   #numer := homalgSendBlocking( [ "Numerator(", p, ")" ], R, "Numerator" );
                   denom := homalgSendBlocking( [ "Denominator(", p, ")" ], R, "Numerator" );
                   
                   #numer := HomalgExternalRingElement( numer, R );
                   denom := HomalgExternalRingElement( denom, R );
                   
                   numer := p * denom;
                   
                   return [ numer, denom ];
                   
                 end,
               
        )
 );
