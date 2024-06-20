# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the rings provided by Singular.

####################################
#
# global variables:
#
####################################

BindGlobal( "CommonHomalgTableForSingularTools",
        
        rec(
               Zero := HomalgExternalRingElement( R -> homalgSendBlocking( [ "0" ], [ "number" ], R, "Zero" ), "Singular", IsZero ),
               
               One := HomalgExternalRingElement( R -> homalgSendBlocking( [ "1" ], [ "number" ], R, "One" ), "Singular", IsOne ),
               
               MinusOne := HomalgExternalRingElement( R -> homalgSendBlocking( [ "-1" ], [ "number" ], R, "MinusOne" ), "Singular", IsMinusOne ),
               
               RingElement := R -> r -> homalgSendBlocking( [ r ], [ "poly" ], R, "define" ),
               
               IsZero := r -> homalgSendBlocking( [ r, "==0" ] , "need_output", "IsZero" ) = "1",
               
               IsOne := r -> homalgSendBlocking( [ r, "==1" ] , "need_output", "IsOne" ) = "1",
               
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "-(", b, ")" ], [ "def" ], "Minus" );
                   
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
                       return homalgSendBlocking( [ "-poly(", a, ")/", e{[ 2..Length( e ) ]} ], [ "def" ], "DivideByUnit" );
                   else
                       return homalgSendBlocking( [ "poly(", a, ")/", e ], [ "def" ], "DivideByUnit" );
                   fi;
                   
                 end,
               
               IsUnit := #FIXME: just for polynomial rings(?)
                 function( R, u )
                   
                   return homalgSendBlocking( [ "deg( ", u, " )" ], "need_output", "IsUnit" ) = "0";
                   
                 end,
               
               IsUnit_Z := #FIXME: just for polynomial rings(?)
                 function( R, u )
                   
                   return homalgSendBlocking( [ "( ", u, " == 1 || ", u, " == -1 )" ], "need_output", "IsUnit" ) = "1";
                   
                 end,
               
               Sum :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "+(", b, ")" ], [ "def" ], "Sum" );
                   
                 end,
               
               Product :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "(", a, ")*(", b, ")" ], [ "def" ], "Product" );
                   
                 end,
               
               Gcd :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "gcd(", a, b, ")" ], [ "def" ], "Gcd" );
                   
                 end,
               
               CancelGcd :=
                 function( a, b )
                   local g, a_g, b_g;
                   
                   g := homalgSendBlocking( [ "gcd(", a, b, ")" ], [ "def" ], "Gcd" );
                   a_g := homalgSendBlocking( [ "poly(", a, ") / (", g, ")" ], [ "def" ], "CancelGcd" );
                   b_g := homalgSendBlocking( [ "poly(", b, ") / (", g, ")" ], [ "def" ], "CancelGcd" );
                   
                   return [ a_g, b_g ];
                   
                 end,
               
               CopyElement :=
                 function( r, R )
                   
                   return homalgSendBlocking( [ "imap(", HomalgRing( r ), r, ")" ], [ "poly" ], R, "CopyElement" );
                   
                 end,
               
               LaTeXString :=
                 function( poly )
                    local l;
                    
                    l := homalgSendBlocking( [ "texpoly( \"\", ", poly, ")" ], "need_display", "homalgLaTeX" );
                    
                    RemoveCharacters( l, "$" );
                    
                    return l;
                    
                end,
               
               ShallowCopy := C -> homalgSendBlocking( [ C ], [ "matrix" ], "CopyMatrix" ),
               
               CopyMatrix :=
                 function( C, R )
                   
                   return homalgSendBlocking( [ "imap(", HomalgRing( C ), C, ")" ], [ "matrix" ], R, "CopyMatrix" );
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "0" ] , [ "matrix" ] , [ "[", NumberColumns( C ), "][", NumberRows( C ), "]" ], C, "ZeroMatrix" );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "unitmat(", NumberRows(C), ")" ] , [ "matrix" ] , [ "[", NumberRows(C), "][", NumberRows(C), "]"], C, "IdentityMatrix" );
                   
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "==", B ] , "need_output", "AreEqualMatrices" ) = "1";
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return homalgSendBlocking( [ "Involution(", M, ")" ], [ "matrix" ], "Involution" );
                   
                 end,
               
               TransposedMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "transpose(", M, ")" ], [ "matrix" ], "TransposedMatrix" );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   
                   if Length( plist ) > 1 and IsRangeRep( plist ) and Length( plist ) = AbsInt( plist[Length( plist )] - plist[1] ) + 1 then
                       return homalgSendBlocking( [ "submat(", M, ",1..", NumberColumns( M ), ",", plist[1] , "..", plist[Length( plist )], ")" ], [ "matrix" ], "CertainRows" );
                   fi;
                   
                   return homalgSendBlocking( [ "submat(", M, ",1..", NumberColumns( M ), ",intvec(", plist, "))" ], [ "matrix" ], "CertainRows" );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   if Length( plist ) > 1 and IsRangeRep( plist ) and Length( plist ) = AbsInt( plist[Length( plist )] - plist[1] ) + 1 then
                       return homalgSendBlocking( [ "submat(", M, ",", plist[1] , "..", plist[Length( plist )], ",1..", NumberRows( M ), ")" ], [ "matrix" ], "CertainColumns" );
                   fi;
                   
                   return homalgSendBlocking( [ "submat(", M, ",intvec(", plist, "),1..", NumberRows( M ), ")" ], [ "matrix" ], "CertainColumns" );
                   
                 end,
               
               UnionOfRows :=
                 function( L )
                   local f;
                   
                   f := Concatenation( [ "concat(" ], L, [ ")" ] );
                   
                   return homalgSendBlocking( f, [ "matrix" ], [ "[", NumberColumns(L[1]), "][", Sum( List( L, NumberRows ) ), "]" ], "UnionOfRows" );
                   
                 end,
               
               UnionOfColumns :=
                 function( L )
                   
                   return homalgSendBlocking( L, [ "matrix" ], [ "[", Sum( List( L, NumberColumns ) ), "][", NumberRows(L[1]), "]" ], "UnionOfColumns" );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := Concatenation( [ "dsum(" ], e, [ ")" ] );
                   
                   return homalgSendBlocking( f, [ "matrix" ], [ "[", Sum( List( e, NumberColumns ) ), "][", Sum( List( e, NumberRows ) ), "]" ], "DiagMat" );
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "tensor(", A, B, ")" ], [ "matrix" ], [ "[", NumberColumns( A ) * NumberColumns( B ), "][", NumberRows( A ) * NumberRows( B ), "]" ], "KroneckerMat" );
                   
                 end,
               
               DualKroneckerMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "DualKroneckerMat(", A, B, ")" ], [ "matrix" ], [ "[", NumberColumns( A ) * NumberColumns( B ), "][", NumberRows( A ) * NumberRows( B ), "]" ], "DualKroneckerMat" );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return homalgSendBlocking( [ "(", a, ")*", A ], [ "matrix" ], "MulMat" );
                   
                 end,
               
               MulMatRight :=
                 function( A, a )
                   
                   return homalgSendBlocking( [ A, "*(", a, ")" ], [ "matrix" ], "MulMatRight" );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "+", B ], [ "matrix" ], "AddMat" );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "-", B ], [ "matrix" ], "SubMat" );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ B, "*", A ], [ "matrix" ], "Compose" ); ## ;-)
                   
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
                   
                   return homalgSendBlocking( [ "det(", C, ")" ], [ "def" ], "Determinant" );
                   
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsZeroMatrix(", M, ")" ], "need_output", "IsZeroMatrix" ) = "1";
                   
                 end,
               
               IsIdentityMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsIdentityMatrix(", M, ")" ], "need_output", "IsIdentityMatrix" ) = "1";
                   
                 end,
               
               IsDiagonalMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsDiagonalMatrix(", M, ")" ], "need_output", "IsDiagonalMatrix" ) = "1";
                   
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
                   local list;
                   
                   if pos_list = [ ] then
                       list := [ 0 ];
                   else
                       Error( "a non-empty second argument is not supported in Singular yet: ", pos_list, "\n" );
                       list := pos_list;
                   fi;
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositions(", M, ", list (", list, "))" ], "need_output", "GetColumnIndependentUnitPositions" ) );
                   
                 end,
               
               GetColumnIndependentUnitPositions_Z :=
                 function( M, pos_list )
                   local list;
                   
                   if pos_list = [ ] then
                       list := [ 0 ];
                   else
                       Error( "a non-empty second argument is not supported in Singular yet: ", pos_list, "\n" );
                       list := pos_list;
                   fi;
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositions_Z(", M, ", list (", list, "))" ], "need_output", "GetColumnIndependentUnitPositions" ) );
                   
                 end,
               
               GetRowIndependentUnitPositions :=
                 function( M, pos_list )
                   local list;
                   
                   if pos_list = [ ] then
                       list := [ 0 ];
                   else
                       Error( "a non-empty second argument is not supported in Singular yet: ", pos_list, "\n" );
                       list := pos_list;
                   fi;
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositions(", M, ", list (", list, "))" ], "need_output", "GetRowIndependentUnitPositions" ) );
                   
                 end,
               
               GetRowIndependentUnitPositions_Z :=
                 function( M, pos_list )
                   local list;
                   
                   if pos_list = [ ] then
                       list := [ 0 ];
                   else
                       Error( "a non-empty second argument is not supported in Singular yet: ", pos_list, "\n" );
                       list := pos_list;
                   fi;
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositions_Z(", M, ", list (", list, "))" ], "need_output", "GetRowIndependentUnitPositions" ) );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local list, list_string;
                   
                   if pos_list = [ ] then
                       list := [ 0 ];
                   else
                       list := pos_list;
                   fi;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPosition(", M, ", list (", list, "))" ], "need_output", "GetUnitPosition" );
                   
                   if list_string = "fail" then
                       return fail;
                   else
                       return StringToIntList( list_string );
                   fi;
                   
                 end,
               
               GetUnitPosition_Z :=
                 function( M, pos_list )
                   local list, list_string;
                   
                   if pos_list = [ ] then
                       list := [ 0 ];
                   else
                       list := pos_list;
                   fi;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPosition_Z(", M, ", list (", list, "))" ], "need_output", "GetUnitPosition" );
                   
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
                   
                   return homalgSendBlocking( [ "ConvertMatrixToRow(", M, ")" ], [ "matrix" ], "ConvertMatrixToRow" );
                   
                 end,
               
               ConvertRowToMatrix :=
                 function( M, r, c )
                   
                   return homalgSendBlocking( [ "ConvertRowToMatrix(", M, r, c, ")" ], [ "matrix" ], "ConvertRowToMatrix" );
                   
                 end,
               
               ## determined by CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries
               AffineDimension :=
                 function( mat )
                   
                   if ZeroColumns( mat ) <> [ ] then
                       if not ( IsZero( mat ) and NumberRows( mat ) = 1 and NumberColumns( mat ) = 1 ) then
                           Error( "Singular (<= 3-1-3) does not handle nontrivial free direct summands correctly\n" );
                       fi;
                       ## the only case of a free direct summand we are allowed to send to Singular (<= 3-1-3)
                       return Int( homalgSendBlocking( [ "dim(std(", mat, "))" ], "need_output", "AffineDimension" ) );
                   fi;
                   
                   return Int( homalgSendBlocking( [ "dim(", mat, ")" ], "need_output", "AffineDimension" ) );
                   
                 end,
               
               CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries :=
                 function( mat )
                   local hilb;
                   
                   if ZeroColumns( mat ) <> [ ] then
                       if not ( IsZero( mat ) and NumberRows( mat ) = 1 and NumberColumns( mat ) = 1 ) then
                           Error( "Singular (<= 3-1-3) does not handle nontrivial free direct summands correctly\n" );
                       fi;
                       ## the only case of a free direct summand we allowed to send to Singular (<= 3-1-3)
                       hilb := homalgSendBlocking( [ "string(hilb(std(", mat, "),1))" ], "need_output", "HilbertPoincareSeries" );
                   else
                       hilb := homalgSendBlocking( [ "string(hilb(", mat, ",1))" ], "need_output", "HilbertPoincareSeries" );
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
                   
                   return homalgSendBlocking( [ "matrix(equiRadical(", mat, "))" ], [ "matrix" ], "MaxDimensionalRadicalSubobject" );
                   
                 end,
               
               RadicalSubobject :=
                 function( mat )
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only radical of one-column matrices is supported\n" );
                   fi;
                   
                   return homalgSendBlocking( [ "RadicalSubobject(", mat, ")" ], [ "matrix" ], "RadicalSubobject" );
                   
                 end,
               
               RadicalSubobject_Z :=
                 function( mat )
                   
                   if not NumberColumns( mat ) = 1 then
                       Error( "only radical of one-column matrices is supported\n" );
                   fi;
                   
                   return homalgSendBlocking( [ "RadicalSubobject_Z(", mat, ")" ], [ "matrix" ], "RadicalSubobject" );
                   
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
                   
                   return homalgSendBlocking( [ "matrix(equidimMax(", mat, "))" ], [ "matrix" ], "MaxDimensionalSubobject" );
                   
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
                   local elim;
                   
                   elim := Product( indets );
                   
                   return homalgSendBlocking( [ "matrix(eliminate(ideal(", rel, "),", elim, "))" ], [ "matrix" ], R, "Eliminate" );
                   
                 end,
               
               Coefficients :=
                 function( poly, var )
                   local R, v, vars, coeffs;
                   
                   R := HomalgRing( poly );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   var := Product( var );
                   
                   homalgSendBlocking( [ "matrix ", v, "m = coef(", poly, var, ")" ], "need_command", "Coefficients" );
                   vars :=homalgSendBlocking( [ "submat(", v, "m,1..1,1..ncols(", v, "m))" ], [ "matrix" ], R, "Coefficients" );
                   coeffs := homalgSendBlocking( [ "submat(", v, "m,2..2,1..ncols(", v, "m))" ], [ "matrix" ], R, "Coefficients" );
                   
                   return [ vars, coeffs ];
                   
                 end,
               
               CoefficientsMatrix :=
                 function( matrix, var )
                   local R, v, vars, coeffs;
                   
                   R := HomalgRing( matrix );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   var := Product( var );
                   
                   homalgSendBlocking( [ "matrix ", v, "m = coef(ideal(", matrix, "),", var, ")" ], "need_command", "Coefficients" );
                   vars := homalgSendBlocking( [ "submat(", v, "m,1..1,1..ncols(", v, "m))" ], [ "matrix" ], R, "Coefficients" );
                   coeffs := homalgSendBlocking( [ "submat(", v, "m,2..nrows(", v,"m),1..ncols(", v, "m))" ], [ "matrix" ], R, "Coefficients" );
                   
                   return [ vars, coeffs ];
                   
                 end,
               
               CoefficientsWithGivenMonomials :=
                 function( M, monomials )
                   
                   return homalgSendBlocking( [ "coeffs(", M, ", ", monomials, ")" ], [ "matrix" ], "Coefficients" );
                   
                 end,
               
               IndicatorMatrixOfNonZeroEntries :=
                 function( mat )
                   local l;
                   
                   l := StringToIntList( homalgSendBlocking( [ "IndicatorMatrixOfNonZeroEntries(", mat, ")" ], "need_output", "IndicatorMatrixOfNonZeroEntries" ) );
                   
                   return ListToListList( l, NumberRows( mat ), NumberColumns( mat ) );
                   
                 end,
               
               DegreeOfRingElement :=
                 function( r, R )
                   
                   return Int( homalgSendBlocking( [ "deg( ", r, " )" ], "need_output", "DegreeOfRingElement" ) );
                   
                 end,
               
               CoefficientsOfUnivariatePolynomial :=
                 function( r, var )
                   
                   return homalgSendBlocking( [ "coeffs( ", r, var, " )" ], [ "matrix" ], "Coefficients" );
                   
                 end,
               
               LeadingModule :=
                 function( mat )
                   
                   return homalgSendBlocking( [ "matrix(lead(module(", mat, ")))" ], [ "matrix" ], "LeadingModule" );
                   
                 end,
               
               MaximalDegreePart :=
                 function( r, weights )
                   
                   return homalgSendBlocking( [ "MaximalDegreePart( ", r, ", intvec(", weights,") )" ], "need_output", "MaximalDegreePart" );
                   
                 end,
               
               MonomialMatrix :=
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "matrix(ideal(", vars, ")^", i, ")" ], [ "matrix" ], R, "MonomialMatrix" );
                   
                 end,
               
               MatrixOfSymbols :=
                 function( mat )
                   
                   return homalgSendBlocking( [ "MatrixOfSymbols(", mat, ")" ], [ "matrix" ], "MatrixOfSymbols" );
                   
                 end,
               
               MatrixOfSymbols_workaround :=
                 function( mat )
                   
                   return homalgSendBlocking( [ "MatrixOfSymbols_workaround(", mat, ")" ], [ "matrix" ], "MatrixOfSymbols" );
                   
                 end,
               
               Diff :=
                 function( D, N )
                   
                   return homalgSendBlocking( [ "Diff(", D, N, ")" ], [ "matrix" ], "Diff" );
                   
                 end,
               
               Pullback :=
                 function( phi, M )
                   
                   if not IsBound( phi!.RingMap ) then
                       phi!.RingMap :=
                         homalgSendBlocking( [ Source( phi ), ImagesOfRingMap( phi ) ], [ "map" ], Range( phi ), "define" );
                   fi;
                   
                   Eval( M ); ## the following line might reset Range( phi ) to HomalgRing( M ) in order to evaluate the (eventually lazy) matrix M -> error
                   
                   return homalgSendBlocking( [ phi!.RingMap, "(", M, ")" ], [ "matrix" ], Range( phi ), "Pullback" );
                   
                 end,
               
               RandomPol :=
                 function( R, args... )
                   
                   return homalgSendBlocking( [ "sparsepoly(", args, ")" ], [ "def" ], R, "RandomPol" );
                   
                 end,
               
               RandomMat :=
                 function( R, r, c, args... )
                   local tmp;
                   
                   if Length( args ) >= 2 then
                       
                       # The 3rd and 4th argument of sparsematrix correspond to the 2nd and 1st argument of sparsepoly above, i.e. are swapped.
                       # To keep the interface consistent, we swap the corresponding entries of args here.
                       args := ShallowCopy( args );
                       tmp := args[2];
                       args[2] := args[1];
                       args[1] := tmp;
                       
                   fi;
                   
                   return homalgSendBlocking( [ "sparsematrix(", Concatenation( [ c, r ], args ), ")" ], [ "def" ], R, "RandomMat" );
                   
                 end,
               
               Evaluate :=
                 function( p, L )
                     
                   # Remember here the list L is of the form var1, val1, var2, val2, ...
                   return homalgSendBlocking( [ "subst(", p, L, ")" ], [ "poly" ], "Evaluate" );
                   
                 end,
               
               EvaluateMatrix :=
                 function( M, L )
                   
                   # Remember here the list L is of the form var1, val1, var2, val2, ...
                   return homalgSendBlocking( [ "EvaluateMatrix(", M, L, ")" ], [ "matrix" ], "Evaluate" );
                   
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
