# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

####################################
#
# global variables:
#
####################################

BindGlobal( "CommonHomalgTableForOscarTools",
        
        rec(
               Zero := HomalgExternalRingElement( R -> homalgSendBlocking( [ R, "(0)" ], R, "Zero" ), "Oscar", IsZero ),
               
               One := HomalgExternalRingElement( R -> homalgSendBlocking( [ R, "(1)" ], R, "One" ), "Oscar", IsOne ),
               
               MinusOne := HomalgExternalRingElement( R -> homalgSendBlocking( [ R, "(-1)" ], R, "MinusOne" ), "Oscar", IsMinusOne ),
               
               RingElement := R -> r -> homalgSendBlocking( [ R, "(", ReplacedString( r, "/", "//" ), ")" ], "define" ),
               
               IsZero := r -> homalgSendBlocking( [ "iszero(", r, ")" ], "need_output", "IsZero" ) = "true",
               
               IsOne := r -> homalgSendBlocking( [ "isone(", r, ")" ], "need_output", "IsOne" ) = "true",
               
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "-(", b, ")" ], "Minus" );
                   
                 end,
               
               DivideByUnit :=
                 function( a, u )
                   local e;
                   
                   if IsHomalgExternalRingElementRep( u ) then
                       e := homalgPointer( u );
                   else
                       e := u;
                   fi;
                   if e{[1]} = "-" then
                       #Info( InfoWarning, 1, "\033[01m\033[5;31;47mdividing by a unit starting with a minus sign:\033[0m ", e );
                       return homalgSendBlocking( [ "-(", a, ")//", e{[ 2 .. Length( e ) ]} ], "DivideByUnit" );
                   else
                       return homalgSendBlocking( [ "inv(", e, ") * ", a ], "DivideByUnit" );
                   fi;
                   
                 end,
               
               IsUnit :=
                 function( R, u )
                   
                   return homalgSendBlocking( [ "isunit( ", u, " )" ], "need_output", "IsUnit" ) = "true";
                   
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
                   local g, a_g, b_g;
                   
                   g := homalgSendBlocking( [ "gcd(", a, b, ")" ], "Gcd" );
                   a_g := homalgSendBlocking( [ "(", a, ") / (", g, ")" ], "CancelGcd" );
                   b_g := homalgSendBlocking( [ "(", b, ") / (", g, ")" ], "CancelGcd" );
                   
                   return [ a_g, b_g ];
                   
                 end,
               
               CopyElement :=
                 function( r, R )
                   
                   return homalgSendBlocking( [ R, "(", String( r ), ")" ], "CopyElement" );
                   
                 end,
               
               LaTeXString :=
                 function( poly )
                    local l;
                    
                    l := homalgSendBlocking( [ "texpoly( \"\", ", poly, ")" ], "need_display", "homalgLaTeX" );
                    
                    RemoveCharacters( l, "$" );
                    
                    return l;
                    
                end,
               
               ShallowCopy := C -> homalgSendBlocking( [ C ], "CopyMatrix" ),
               
               CopyMatrix :=
                 function( C, R )
                   local S, indetsS, indetsR, iS, iR, map, v;
                    
                   S := HomalgRing( C );
                   
                   indetsS := Indeterminates( S );
                   
                   indetsR := Indeterminates( R );
                   
                   iS := List( indetsS, String );

                   iR := List( indetsR, String );
                   
                   map := List( iS, function( x ) local pos; pos := Position( iR, x ); if pos = fail then return Zero( R ); fi; return indetsR[pos]; end );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ v, "map = Singular.AlgebraHomomorphism(", S, R, ", [", map, "])" ], "need_command", "break_lists", "define" );
                   
                   return homalgSendBlocking( [ v, "map(", C, ")" ], "CopyMatrix" );
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "ZeroMatrixForHomalg(", HomalgRing( C ), NumberColumns( C ), NumberRows( C ), ")" ], "ZeroMatrix" );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "IdentityMatrixForHomalg(", HomalgRing( C ), NumberRows( C ), ")" ], "IdentityMatrix" );
                   
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, " == ", B ], "need_output", "AreEqualMatrices" ) = "true";
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return homalgSendBlocking( [ "Involution(", M, ")" ], "Involution" );
                   
                 end,
               
               TransposedMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "transpose(", M, ")" ], "TransposedMatrix" );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   
                   if Length( plist ) > 1 and IsRangeRep( plist ) and Length( plist ) = plist[Length( plist )] - plist[1] + 1 then
                       return homalgSendBlocking( [ "CertainRows(", M, ", ", plist[1] , ":", plist[Length( plist )], ")" ], "CertainRows" );
                   fi;
                   
                   return homalgSendBlocking( [ "CertainRows(", M, ", ", plist, ")" ], "CertainRows" );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   if Length( plist ) > 1 and IsRangeRep( plist ) and Length( plist ) = plist[Length( plist )] - plist[1] + 1 then
                       return homalgSendBlocking( [ "CertainColumns(", M, ", ", plist[1] , ":", plist[Length( plist )], ")" ], "CertainColumns" );
                   fi;
                   
                   return homalgSendBlocking( [ "CertainColumns(", M, ", ", plist, ")" ], "CertainColumns" );
                   
                 end,
               
               UnionOfRows :=
                 function( L )
                   
                   return homalgSendBlocking( Concatenation( [ "UnionOfRows(" ], L, [ ")" ] ), "UnionOfRows" );
                   
                 end,
               
               UnionOfColumns :=
                 function( L )
                   
                   return homalgSendBlocking( Concatenation( [ "UnionOfColumns(" ], L, [ ")" ] ), "UnionOfColumns" );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   
                   return homalgSendBlocking( Concatenation( [ "DiagMat(" ], e, [ ")" ] ), "DiagMat" );
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "kronecker_product(", A, B, ")" ], "KroneckerMat" );
                   
                 end,
               
               DualKroneckerMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "DualKroneckerMat(", A, B, ")" ], "DualKroneckerMat" );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return homalgSendBlocking( [ "(", ReplacedString( String( a ), "/", "//" ), ")*", A ], "MulMat" );
                   
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
                   
                   return homalgSendBlocking( [ B, "*", A ], "Compose" ); ## ;-)
                   
                 end,
               
               NumberRows :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "ncols(", C, ")" ], "need_output", "NumberRows" ) );
                   
                 end,
               
               NumberColumns :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "nrows(", C, ")" ], "need_output", "NumberColumns" ) );
                   
                 end,
               
               Determinant :=
                 function( C )
                   
                   return homalgSendBlocking( [ "Determinant(", C, ")" ], "Determinant" );
                   
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "iszero(", M, ")" ], "need_output", "IsZeroMatrix" ) = "true";
                   
                 end,
               
               IsIdentityMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "isone(", M, ")" ], "need_output", "IsIdentityMatrix" ) = "true";
                   
                 end,
               
               IsDiagonalMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsDiagonalMatrix(", M, ")" ], "need_output", "IsDiagonalMatrix" ) = "true";
                   
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
                   local pos;
                   
                   pos := homalgSendBlocking( [ "GetColumnIndependentUnitPositions(", M, pos_list, ")" ], "need_output", "GetColumnIndependentUnitPositions" );
                   
                   if pos{[ 1 .. 2 ]} = "An" then
                       pos := pos{[ 4 .. Length( pos ) ]};
                   fi;
                   
                   return StringToDoubleIntList( pos );
                   
                 end,
               
               GetRowIndependentUnitPositions :=
                 function( M, pos_list )
                   local pos;
                   
                   pos := homalgSendBlocking( [ "GetRowIndependentUnitPositions(", M, pos_list, ")" ], "need_output", "GetRowIndependentUnitPositions" );
                   
                   if pos{[ 1 .. 2 ]} = "An" then
                       pos := pos{[ 4 .. Length( pos ) ]};
                   fi;
                   
                   return StringToDoubleIntList( pos );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPosition(", M, pos_list, ")" ], "need_output", "GetUnitPosition" );
                   
                   if list_string = "false" then
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
                   
                   homalgSendBlocking( [ M, "[", j, i, "] =", M, "[", j, i, "]/", u ], "need_command", "DivideEntryByUnit" );
                   
                 end,
               
               DivideRowByUnit :=
                 function( M, i, u, j )
                   local v;
                   
                   v := homalgStream( HomalgRing( M ) )!.variable_name;
                   
                   homalgSendBlocking( [ v, "i=", i, ";", v, "j=", j, ";for(", v, "k=1;", v, "k<=", NumberColumns( M ), ";", v, "k=", v, "k+1){", M, "[", v, "k,", v, "i]=", M, "[", v, "k,", v, "i]/", u, ";};if(", v, "j>0){", M, "[", v, "j,", v, "i]=1;}" ], "need_command", "DivideRowByUnit" );
                   
                 end,
               
               DivideColumnByUnit :=
                 function( M, j, u, i )
                   local v;
                   
                   v := homalgStream( HomalgRing( M ) )!.variable_name;
                   
                   homalgSendBlocking( [ v, "j=", j, ";", v, "i=", i, ";for(", v, "k=1;", v, "k<=", NumberRows( M ), ";", v, "k=", v, "k+1){", M, "[", v, "j,", v, "k]=", M, "[", v, "j,", v, "k]/", u, ";};if(", v, "i>0){", M, "[", v, "j,", v, "i]=1;}" ], "need_command", "DivideColumnByUnit" );
                   
                 end,
               
               CopyRowToIdentityMatrix :=
                 function( M, i, L, j )
                   local v, l;
                   
                   v := homalgStream( HomalgRing( M ) )!.variable_name;
                   
                   l := Length( L );
                   
                   if l > 1 and ForAll( L, IsHomalgMatrix ) then
                       homalgSendBlocking( [ v, "i=", i, ";", v, "j=", j, ";for(", v, "k=1;", v, "k<=", NumberColumns( M ), ";", v, "k=", v, "k+1){", L[1], "[", v, "k,", v, "j]=-", M, "[", v, "k,", v, "i];", L[2], "[", v, "k,", v, "j]=", M, "[", v, "k,", v, "i];", "};", L[1], "[", v, "j,", v, "j]=1;", L[2], "[", v, "j,", v, "j]=1" ], "need_command", "CopyRowToIdentityMatrix" );
                   elif l > 0 and IsHomalgMatrix( L[1] ) then
                       homalgSendBlocking( [ v, "i=", i, ";", v, "j=", j, ";for(", v, "k=1;", v, "k<=", NumberColumns( M ), ";", v, "k=", v, "k+1){", L[1], "[", v, "k,", v, "j]=-", M, "[", v, "k,", v, "i];};", L[1], "[", v, "j,", v, "j]=1;" ], "need_command", "CopyRowToIdentityMatrix" );
                   elif l > 1 and IsHomalgMatrix( L[2] ) then
                       homalgSendBlocking( [ v, "i=", i, ";", v, "j=", j, ";for(", v, "k=1;", v, "k<=", NumberColumns( M ), ";", v, "k=", v, "k+1){", L[2], "[", v, "k,", v, "j]=", M, "[", v, "k,", v, "i];", "};", L[2], "[", v, "j,", v, "j]=1" ], "need_command", "CopyRowToIdentityMatrix" );
                   fi;
                   
                 end,
               
               CopyColumnToIdentityMatrix :=
                 function( M, j, L, i )
                   local v, l;
                   
                   v := homalgStream( HomalgRing( M ) )!.variable_name;
                   
                   l := Length( L );
                   
                   if l > 1 and ForAll( L, IsHomalgMatrix ) then
                       homalgSendBlocking( [ v, "j=", j, ";", v, "i=", i, ";for(", v, "k=1;", v, "k<=", NumberRows( M ), ";", v, "k=", v, "k+1){", L[1], "[", v, "i,", v, "k]=-", M, "[", v, "j,", v, "k];", L[2], "[", v, "i,", v, "k]=", M, "[", v, "j,", v, "k];", "};", L[1], "[", v, "i,", v, "i]=1;", L[2], "[", v, "i,", v, "i]=1" ], "need_command", "CopyColumnToIdentityMatrix" );
                   elif l > 0 and IsHomalgMatrix( L[1] ) then
                       homalgSendBlocking( [ v, "j=", j, ";", v, "i=", i, ";for(", v, "k=1;", v, "k<=", NumberRows( M ), ";", v, "k=", v, "k+1){", L[1], "[", v, "i,", v, "k]=-", M, "[", v, "j,", v, "k];};", L[1], "[", v, "i,", v, "i]=1;" ], "need_command", "CopyColumnToIdentityMatrix" );
                   elif l > 1 and IsHomalgMatrix( L[2] ) then
                       homalgSendBlocking( [ v, "j=", j, ";", v, "i=", i, ";for(", v, "k=1;", v, "k<=", NumberRows( M ), ";", v, "k=", v, "k+1){", L[2], "[", v, "i,", v, "k]=", M, "[", v, "j,", v, "k];", "};", L[2], "[", v, "i,", v, "i]=1" ], "need_command", "CopyColumnToIdentityMatrix" );
                   fi;
                   
                 end,
               
               SetColumnToZero :=
                 function( M, i, j )
                   local v;
                   
                   v := homalgStream( HomalgRing( M ) )!.variable_name;
                   
                   homalgSendBlocking( [ v, "i=", i, ";", v, "j=", j, ";for(", v, "k=1;", v, "k<", v, "i;", v, "k=", v, "k+1){", M, "[", v, "j,", v, "k]=0;};for(", v, "k=", v, "i+1;", v, "k<=", NumberRows( M ), ";", v, "k=", v, "k+1){", M, "[", v, "j,", v, "k]=0;}" ], "need_command", "SetColumnToZero" );
                   
                 end,
               
               GetCleanRowsPositions :=
                 function( M, clean_columns )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "GetCleanRowsPositions(", M, ", list (", clean_columns, "))" ], "need_output", "GetCleanRowsPositions" );
                   
                   return StringToIntList( list_string );
                   
                 end,
               
               ConvertMatrixToRow :=
                 function( M )
                   
                   return homalgSendBlocking( [ "ConvertMatrixToRow(", M, ")" ], "ConvertMatrixToRow" );
                   
                 end,
               
               ConvertRowToMatrix :=
                 function( M, r, c )
                   
                   return homalgSendBlocking( [ "ConvertRowToMatrix(", M, r, c, ")" ], "ConvertRowToMatrix" );
                   
                 end,
               
               ## determined by CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries
               AffineDimension :=
                 function( mat )
                   
                   if ZeroColumns( mat ) <> [ ] then
                       if not ( IsZero( mat ) and NumberRows( mat ) = 1 and NumberColumns( mat ) = 1 ) then
                           Error( "Singular (<= 3-1-3) does not handle nontrivial free direct summands correctly\n" );
                       fi;
                       ## the only case of a free direct summand we are allowed to send to Singular (<= 3-1-3)
                       return Int( homalgSendBlocking( [ "Singular.dimension(Singular.std(Singular.Module(", mat, ")))" ], "need_output", "AffineDimension" ) );
                   fi;
                   
                   return Int( homalgSendBlocking( [ "Dimension(", mat, ")" ], "need_output", "AffineDimension" ) );
                   
                 end,
               
               CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries :=
                 function( mat )
                   local hilb;
                   
                   if ZeroColumns( mat ) <> [ ] then
                       if not ( IsZero( mat ) and NumberRows( mat ) = 1 and NumberColumns( mat ) = 1 ) then
                           Error( "Singular (<= 3-1-3) does not handle nontrivial free direct summands correctly\n" );
                       fi;
                       ## the only case of a free direct summand we allowed to send to Singular (<= 3-1-3)
                       hilb := homalgSendBlocking( [ "hilb(std(", mat, "),1)" ], "need_output", "HilbertPoincareSeries" );
                   else
                       hilb := homalgSendBlocking( [ "hilb(", mat, ",1)" ], "need_output", "HilbertPoincareSeries" );
                   fi;
                   
                   hilb := StringToIntList( hilb );
                   
                   if hilb = [ 0, 0 ] then
                       return [ ];
                   fi;
                   
                   return hilb{[ 1 .. Length( hilb ) - 1 ]};
                   
                 end,
               
               ### commented out since Singular (<= 3-1-3) does not handle nontrivial free direct summands correctly;
               ## determined by CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries
               #XCoefficientsOfNumeratorOfHilbertPoincareSeries :=
               #  function( mat )
               #    local hilb;
               #    
               #    if ZeroColumns( mat ) <> [ ] and
               #       ## the only case of a free direct summand we can to send to Singular (<= 3-1-3)
               #       not ( IsZero( mat ) and NumberRows( mat ) = 1 and NumberColumns( mat ) = 1 ) then
               #        Error( "Singular (<= 3-1-3) does not handle nontrivial free direct summands correctly\n" );
               #    fi;
               #    
               #    hilb := homalgSendBlocking( [ "hilb(std(", mat, "),2)" ], "need_output", "HilbertPoincareSeries" );
               #    
               #    hilb := StringToIntList( hilb );
               #    
               #    if hilb = [ 0, 0 ] then
               #        return [ ];
               #    fi;
               #    
               #    return hilb{[ 1 .. Length( hilb ) - 1 ]};
               #    
               #  end,
               
               CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries :=
                 function( mat, weights, degrees )
                   local R, v, hilb;
                   
                   R := HomalgRing( mat );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   if ZeroColumns( mat ) <> [ ] and
                      ## the only case of a free direct summand we allowed to send to Singular (<= 3-1-3)
                      not ( IsZero( mat ) and NumberRows( mat ) = 1 and NumberColumns( mat ) = 1 ) then
                       Error( "Singular (<= 3-1-3) does not handle nontrivial free direct summands correctly\n" );
                   fi;
                   
                   hilb := homalgSendBlocking( [ "CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries(", mat, ", intvec(", weights,"), intvec(", degrees, "))" ], "need_output", "HilbertPoincareSeries" );
                   
                   hilb := StringToIntList( hilb );
                   
                   if hilb = [ 0, 0 ] then
                       return [ 0 ];
                   fi;
                   
                   return hilb;
                   
                 end,
               
               MaxDimensionalRadicalSubobject :=
                 function( mat )
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only maximal dimensional radical subobjects of one-column matrices is supported\n" );
                   fi;
                   
                   return homalgSendBlocking( [ "matrix(equiRadical(", mat, "))" ], "MaxDimensionalRadicalSubobject" );
                   
                 end,
               
               RadicalSubobject :=
                 function( mat )
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only radical of one-column matrices is supported\n" );
                   fi;
                   
                   return homalgSendBlocking( [ "RadicalSubobject(", mat, ")" ], "RadicalSubobject" );
                   
                 end,
               
               RadicalSubobject_Z :=
                 function( mat )
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only radical of one-column matrices is supported\n" );
                   fi;
                   
                   return homalgSendBlocking( [ "RadicalSubobject_Z(", mat, ")" ], "RadicalSubobject" );
                   
                 end,
               
               RadicalDecomposition :=
                 function( mat )
                   local R, v, c;
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only primary decomposition of one-column matrices is supported\n" );
                   fi;
                   
                   R := HomalgRing( mat );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ "list ", v, "l=RadicalDecomposition(", mat, ")" ], "need_command", "RadicalDecomposition" );
                   
                   c := Int( homalgSendBlocking( [ "size(", v, "l)" ], "need_output", R, "RadicalDecomposition" ) );
                   
                   return
                     List( [ 1 .. c ],
                           function( i )
                             local prime;
                             
                             prime := HomalgVoidMatrix( "unkown_number_of_rows", 1, R );
                             
                             homalgSendBlocking( [ "matrix ", prime, "[1][size(", v, "l[", i, "])]=", v, "l[", i, "]" ], "need_command", "RadicalDecomposition" );
                             
                             return prime;
                             
                           end
                         );
                   
                 end,
               
               RadicalDecomposition_Z :=
                 function( mat )
                   local R, v, c;
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only primary decomposition of one-column matrices is supported\n" );
                   fi;
                   
                   R := HomalgRing( mat );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ "list ", v, "l=RadicalDecomposition_Z(", mat, ")" ], "need_command", "RadicalDecomposition" );
                   
                   c := Int( homalgSendBlocking( [ "size(", v, "l)" ], "need_output", R, "RadicalDecomposition" ) );
                   
                   return
                     List( [ 1 .. c ],
                           function( i )
                             local prime;
                             
                             prime := HomalgVoidMatrix( "unkown_number_of_rows", 1, R );
                             
                             homalgSendBlocking( [ "matrix ", prime, "[1][size(", v, "l[", i, "])]=", v, "l[", i, "]" ], "need_command", "RadicalDecomposition" );
                             
                             return prime;
                             
                           end
                         );
                   
                 end,
               
               MaxDimensionalSubobject :=
                 function( mat )
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only maximal dimensional subobjects of one-column matrices is supported\n" );
                   fi;
                   
                   return homalgSendBlocking( [ "matrix(equidimMax(", mat, "))" ], "MaxDimensionalSubobject" );
                   
                 end,
               
               EquiDimensionalDecomposition :=
                 function( mat )
                   local R, v, c;
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only primary decomposition of one-column matrices is supported\n" );
                   fi;
                   
                   R := HomalgRing( mat );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ "list ", v, "l=equidim(", mat, ")" ], "need_command", "RadicalDecomposition" );
                   
                   c := Int( homalgSendBlocking( [ "size(", v, "l)" ], "need_output", R, "RadicalDecomposition" ) );
                   
                   return
                     List( [ 1 .. c ],
                           function( i )
                             local prime;
                             
                             prime := HomalgVoidMatrix( "unkown_number_of_rows", 1, R );
                             
                             homalgSendBlocking( [ "matrix ", prime, "[1][size(", v, "l[", i, "])]=", v, "l[", i, "]" ], "need_command", "RadicalDecomposition" );
                             
                             return prime;
                             
                           end
                         );
                   
                 end,
               
               PrimaryDecomposition :=
                 function( mat )
                   local R, v, c;
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only primary decomposition of one-column matrices is supported\n" );
                   fi;
                   
                   R := HomalgRing( mat );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ "list ", v, "l=PrimaryDecomposition(", mat, ")" ], "need_command", "PrimaryDecomposition" );
                   
                   c := Int( homalgSendBlocking( [ "size(", v, "l)" ], "need_output", R, "PrimaryDecomposition" ) );
                   
                   return
                     List( [ 1 .. c ],
                           function( i )
                             local primary, prime;
                             
                             primary := HomalgVoidMatrix( "unkown_number_of_rows", 1, R );
                             prime := HomalgVoidMatrix( "unkown_number_of_rows", 1, R );
                             
                             homalgSendBlocking( [ "matrix ", primary, "[1][size(", v, "l[", i, "][1])]=", v, "l[", i, "][1]" ], "need_command", "PrimaryDecomposition" );
                             homalgSendBlocking( [ "matrix ", prime, "[1][size(", v, "l[", i, "][2])]=", v, "l[", i, "][2]" ], "need_command", "PrimaryDecomposition" );
                             
                             return [ primary, prime ];
                             
                           end
                         );
                   
                 end,
               
               PrimaryDecomposition_Z :=
                 function( mat )
                   local R, v, c;
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only primary decomposition of one-column matrices is supported\n" );
                   fi;
                   
                   R := HomalgRing( mat );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ "list ", v, "l=PrimaryDecomposition_Z(", mat, ")" ], "need_command", "PrimaryDecomposition" );
                   
                   c := Int( homalgSendBlocking( [ "size(", v, "l)" ], "need_output", R, "PrimaryDecomposition" ) );
                   
                   return
                     List( [ 1 .. c ],
                           function( i )
                             local primary, prime;
                             
                             primary := HomalgVoidMatrix( "unkown_number_of_rows", 1, R );
                             prime := HomalgVoidMatrix( "unkown_number_of_rows", 1, R );
                             
                             homalgSendBlocking( [ "matrix ", primary, "[1][size(", v, "l[", i, "][1])]=", v, "l[", i, "][1]" ], "need_command", "PrimaryDecomposition" );
                             homalgSendBlocking( [ "matrix ", prime, "[1][size(", v, "l[", i, "][2])]=", v, "l[", i, "][2]" ], "need_command", "PrimaryDecomposition" );
                             
                             return [ primary, prime ];
                             
                           end
                         );
                   
                 end,
               
               Eliminate :=
                 function( rel, indets, R )
                   local v;
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ v, "elim = ", indets ], "need_command", R, "define" );
                   
                   return homalgSendBlocking( [ "MatrixForHomalg(Singular.eliminate(Singular.Module(MatrixForHomalg(", R, Length( rel ), 1, ", [", rel, "])),", v, "elim...))" ], "break_lists", "Eliminate" );
                   
                 end,
               
               Coefficients :=
                 function( poly, var )
                   local R, v, monoms, coeffs;
                   
                   R := HomalgRing( poly );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   if not var = Indeterminates( R ) then
                       Error( "the list ", Indeterminates( R ), " is different from the list ", var, " of variables defining the monomials\n" );
                   fi;
                   
                   var := Product( var );
                   
                   monoms := homalgSendBlocking( [ "collect(monomials(", poly, "))" ], "Coefficients" );
                   monoms := homalgSendBlocking( [ "MatrixForHomalg(", R, ", 1, length(", monoms, "), ", monoms, ")" ], "Coefficients" );
                   coeffs := homalgSendBlocking( [ "collect(coefficients(", poly, "))" ], "Coefficients" );
                   coeffs := homalgSendBlocking( [ "MatrixForHomalg(", R, ", 1, length(", coeffs , "), ", coeffs, ")" ], "Coefficients" );
                   
                   return [ monoms, coeffs ];
                   
                 end,
               
               CoefficientsWithGivenMonomials :=
                 function( M, monomials )
                   
                   return homalgSendBlocking( [ "coefficients(", M, ", ", monomials, ")" ], "Coefficients" );
                   
                 end,
               
               IndicatorMatrixOfNonZeroEntries :=
                 function( mat )
                   local l;
                   
                   l := StringToIntList( homalgSendBlocking( [ "IndicatorMatrixOfNonZeroEntries(", mat, ")" ], "need_output", "IndicatorMatrixOfNonZeroEntries" ) );
                   
                   return ListToListList( l, NumberRows( mat ), NumberColumns( mat ) );
                   
                 end,
               
               DegreeOfRingElement :=
                 function( r, R )
                   
                   return Int( homalgSendBlocking( [ "total_degree( ", r, " )" ], "need_output", "DegreeOfRingElement" ) );
                   
                 end,
               
               CoefficientsOfUnivariatePolynomial :=
                 function( r, var )
                   
                   return homalgSendBlocking( [ "coefficients( ", r, var, " )" ], "Coefficients" );
                   
                 end,
               
               LeadingModule :=
                 function( mat )
                   
                   return homalgSendBlocking( [ "matrix(lead(module(", mat, ")))" ], "LeadingModule" );
                   
                 end,
               
               MaximalDegreePart :=
                 function( r, weights )
                   
                   return homalgSendBlocking( [ "MaximalDegreePart( ", r, ", intvec(", weights,") )" ], "need_output", "MaximalDegreePart" );
                   
                 end,
               
               MonomialMatrix :=
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "MatrixForHomalg(Ideal(", R, ", [", vars, "])^", i, ")" ], "break_lists", "MonomialMatrix" );
                   
                 end,
               
               MatrixOfSymbols :=
                 function( mat )
                   
                   return homalgSendBlocking( [ "MatrixOfSymbols(", mat, ")" ], "MatrixOfSymbols" );
                   
                 end,
               
               MatrixOfSymbols_workaround :=
                 function( mat )
                   
                   return homalgSendBlocking( [ "MatrixOfSymbols_workaround(", mat, ")" ], "MatrixOfSymbols" );
                   
                 end,
               
               Diff :=
                 function( D, N )
                   
                   return homalgSendBlocking( [ "Diff(", D, N, ")" ], "Diff" );
                   
                 end,
               
               Pullback :=
                 function( phi, M )
                   
                   if not IsBound( phi!.RingMap ) then
                       phi!.RingMap :=
                         homalgSendBlocking( [ "Singular.AlgebraHomomorphism(", Source( phi ), Range( phi ), ", [", ImagesOfRingMap( phi ), "])" ], "break_lists", "define" );
                   fi;
                   
                   return homalgSendBlocking( [ phi!.RingMap, "(", M, ")" ], "Pullback" );
                   
                 end,
               
               RandomPol :=
                 function( arg )
                   local R;
                   
                   R := arg[1];
                   
                   return homalgSendBlocking( [ "sparsepoly(", arg{[ 2 .. Length( arg ) ]}, ")" ], R, "RandomPol" );
                   
                 end,
               
               Evaluate :=
                 function( p, L )
                     
                   # Remember here the list L is of the form var1, val1, var2, val2, ...
                   return homalgSendBlocking( [ "subst(", p, L, ")" ], [ "poly" ], "Evaluate" );
                   
                 end,
               
               EvaluateMatrix :=
                 function( M, L )
                   
                   # Remember here the list L is of the form var1, val1, var2, val2, ...
                   return homalgSendBlocking( [ "EvaluateMatrix(", M, L, ")" ], "Evaluate" );
                   
                 end,
               
               NumeratorAndDenominatorOfPolynomial :=
                 function( p )
                   local R, v, numer, denom;
                   
                   R := HomalgRing( p );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ "list ", v, "l=NumeratorAndDenominatorOfPolynomial(", p, ")" ], "need_command", "Numerator" );
                   
                   numer := homalgSendBlocking( [ v, "l[1]" ], [ "poly" ], R, "Numerator" );
                   denom := homalgSendBlocking( [ v, "l[2]" ], [ "poly" ], R, "Numerator" );
                   
                   numer := HomalgExternalRingElement( numer, R );
                   denom := HomalgExternalRingElement( denom, R );
                   
                   return [ numer, denom ];
                   
                 end,
               
               NumeratorAndDenominatorOfRational :=
                 function( p )
                   local R, v, numer, denom;
                   
                   R := HomalgRing( p );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ "list ", v, "l=NumeratorAndDenominatorOfRational(", p, ")" ], "need_command", "Numerator" );
                   
                   numer := homalgSendBlocking( [ v, "l[1]" ], [ "poly" ], R, "Numerator" );
                   denom := homalgSendBlocking( [ v, "l[2]" ], [ "poly" ], R, "Numerator" );
                   
                   numer := HomalgExternalRingElement( numer, R );
                   denom := HomalgExternalRingElement( denom, R );
                   
                   return [ numer, denom ];
                   
                 end,
               
               Inequalities :=
                 function( R )
                   local v, l;
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ "list ", v, "l=system(\"denom_list\")" ], R, "need_command", "Inequalities" );
                   
                   l := Int( homalgSendBlocking( [ "size(", v, "l)" ], R, "need_output", "Inequalities" ) );
                   
                   l := List( [ 1 .. l ], i -> homalgSendBlocking( [ v, "l[", i, "]" ], [ "poly" ], R, "Inequalities" ) );
                   
                   return List( l, a -> HomalgExternalRingElement( a, R ) );
                   
               end,
               
               MaximalIndependentSet :=
                 function( I )
                   local R, indets, indep;
                   
                   R := HomalgRing( I );
                   indets := Indeterminates( R );
                   
                   indep := homalgSendBlocking( [ "indepSet(ideal(", I, "))" ], "need_output", "MaximalIndependentSet" );
                   indep := StringToIntList( indep );
                   
                   return indets{Positions( indep, 1 )};
                   
               end,
               
               PolynomialExponents :=
                 function( poly )
                    local ring, return_string, nr_indets;
                    
                    ring := HomalgRing( poly );
                    
                    return_string := homalgSendBlocking( [ "string(PolynomialExponentsAndCoefficients(", poly, ")[1])" ], ring, "need_output", "Numerator" );
                    
                    nr_indets := Length( Indeterminates( ring ) );
                    
                    return_string := StringToIntList( return_string );
                    
                    return ListToListList( return_string, Length( return_string )/nr_indets, nr_indets );
                    
                end,
                
                PolynomialCoefficients :=
                 function( poly )
                    local ring;
                    
                    ring := HomalgRing( poly );
                    
                    return homalgSendBlocking( [ "string(PolynomialExponentsAndCoefficients(", poly, ")[2])" ], ring, "need_output", "Numerator" );
                    
                end,
               
        )
 );
