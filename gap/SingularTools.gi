#############################################################################
##
##  SingularTools.gi          RingsForHomalg package  Markus Lange-Hegermann
##                                                            Simon Goertzen
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the rings provided by Singular.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForSingularTools,
        
        rec(
               Zero := HomalgExternalRingElement( R -> homalgSendBlocking( [ "0" ], [ "number" ], R, HOMALG_IO.Pictograms.Zero ), "Singular", IsZero ),
               
               One := HomalgExternalRingElement( R -> homalgSendBlocking( [ "1" ], [ "number" ], R, HOMALG_IO.Pictograms.One ), "Singular", IsOne ),
               
               MinusOne := HomalgExternalRingElement( R -> homalgSendBlocking( [ "-1" ], [ "number" ], R, HOMALG_IO.Pictograms.MinusOne ), "Singular", IsMinusOne ),
               
               RingElement := R -> r -> homalgSendBlocking( [ r ], [ "poly" ], R, HOMALG_IO.Pictograms.define ),
               
               IsZero := r -> homalgSendBlocking( [ r, "==0" ] , "need_output", HOMALG_IO.Pictograms.IsZero ) = "1",
               
               IsOne := r -> homalgSendBlocking( [ r, "==1" ] , "need_output", HOMALG_IO.Pictograms.IsOne ) = "1",
               
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "-(", b, ")" ], [ "def" ], HOMALG_IO.Pictograms.Minus );
                   
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
                       return homalgSendBlocking( [ "-poly(", a, ")/", e{[ 2..Length( e ) ]} ], [ "def" ], HOMALG_IO.Pictograms.DivideByUnit );
                   else
                       return homalgSendBlocking( [ "poly(", a, ")/", e ], [ "def" ], HOMALG_IO.Pictograms.DivideByUnit );
                   fi;
                   
                 end,
               
               IsUnit := #FIXME: just for polynomial rings(?)
                 function( R, u )
                   
                   return homalgSendBlocking( [ "deg( ", u, " )" ], "need_output", HOMALG_IO.Pictograms.IsUnit ) = "0";
                   
                 end,
               
               IsUnit_Z := #FIXME: just for polynomial rings(?)
                 function( R, u )
                   
                   return homalgSendBlocking( [ "( ", u, " == 1 || ", u, " == -1 )" ], "need_output", HOMALG_IO.Pictograms.IsUnit ) = "0";
                   
                 end,
               
               Sum :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, "+(", b, ")" ], [ "def" ], HOMALG_IO.Pictograms.Sum );
                   
                 end,
               
               Product :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "(", a, ")*(", b, ")" ], [ "def" ], HOMALG_IO.Pictograms.Product );
                   
                 end,
               
               Gcd :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ "gcd(", a, b, ")" ], [ "def" ], HOMALG_IO.Pictograms.Gcd );
                   
                 end,
               
               CancelGcd :=
                 function( a, b )
                   local g, a_g, b_g;
                   
                   g := homalgSendBlocking( [ "gcd(", a, b, ")" ], [ "def" ], HOMALG_IO.Pictograms.Gcd );
                   a_g := homalgSendBlocking( [ "poly(", a, ") / (", g, ")" ], [ "def" ], HOMALG_IO.Pictograms.CancelGcd );
                   b_g := homalgSendBlocking( [ "poly(", b, ") / (", g, ")" ], [ "def" ], HOMALG_IO.Pictograms.CancelGcd );
                   
                   return [ a_g, b_g ];
                   
                 end,
               
               CopyElement :=
                 function( r, R )
                   
                   return homalgSendBlocking( [ "imap(", HomalgRing( r ), r, ")" ], [ "poly" ], R, HOMALG_IO.Pictograms.CopyElement );
                   
                 end,
               
               ShallowCopy := C -> homalgSendBlocking( [ C ], [ "matrix" ], HOMALG_IO.Pictograms.CopyMatrix ),
               
               CopyMatrix :=
                 function( C, R )
                   
                   return homalgSendBlocking( [ "imap(", HomalgRing( C ), C, ")" ], [ "matrix" ], R, HOMALG_IO.Pictograms.CopyMatrix );
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "0" ] , [ "matrix" ] , [ "[", NrColumns( C ), "][", NrRows( C ), "]" ], C, HOMALG_IO.Pictograms.ZeroMatrix );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "unitmat(", NrRows(C), ")" ] , [ "matrix" ] , [ "[", NrRows(C), "][", NrRows(C), "]"], C, HOMALG_IO.Pictograms.IdentityMatrix );
                   
                 end,
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "==", B ] , "need_output", HOMALG_IO.Pictograms.AreEqualMatrices ) = "1";
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return homalgSendBlocking( [ "Involution(", M, ")" ], [ "matrix" ], HOMALG_IO.Pictograms.Involution );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "submat(", M, ",1..", NrColumns( M ), ",intvec(", plist, "))" ], [ "matrix" ], HOMALG_IO.Pictograms.CertainRows );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "submat(", M, ",intvec(", plist, "),1..", NrRows( M ), ")" ], [ "matrix" ], HOMALG_IO.Pictograms.CertainColumns );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "concat(", A, B, ")" ], [ "matrix" ], [ "[", NrColumns(A), "][", NrRows(A) + NrRows(B), "]" ], HOMALG_IO.Pictograms.UnionOfRows );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, B ], [ "matrix" ], [ "[", NrColumns(A) + NrColumns(B), "][", NrRows(A), "]" ], HOMALG_IO.Pictograms.UnionOfColumns );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := Concatenation( [ "dsum(" ], e, [ ")" ] );
                   
                   return homalgSendBlocking( f, [ "matrix" ], [ "[", Sum( List( e, NrColumns ) ), "][", Sum( List( e, NrRows ) ), "]" ], HOMALG_IO.Pictograms.DiagMat );
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "tensor(", A, B, ")" ], [ "matrix" ], [ "[", NrColumns( A ) * NrColumns( B ), "][", NrRows( A ) * NrRows( B ), "]" ], HOMALG_IO.Pictograms.KroneckerMat );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return homalgSendBlocking( [ A, "*(", a, ")" ], [ "matrix" ], HOMALG_IO.Pictograms.MulMat );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "+", B ], [ "matrix" ], HOMALG_IO.Pictograms.AddMat );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "-", B ], [ "matrix" ], HOMALG_IO.Pictograms.SubMat );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ B, "*", A ], [ "matrix" ], HOMALG_IO.Pictograms.Compose ); ## ;-)
                   
                 end,
               
               NrRows :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "ncols(", C, ")" ], "need_output", HOMALG_IO.Pictograms.NrRows ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "nrows(", C, ")" ], "need_output", HOMALG_IO.Pictograms.NrColumns ) );
                   
                 end,
               
               Determinant :=
                 function( C )
                   
                   return homalgSendBlocking( [ "det(", C, ")" ], [ "def" ], HOMALG_IO.Pictograms.Determinant );
                   
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsZeroMatrix(", M, ")" ], "need_output", HOMALG_IO.Pictograms.IsZeroMatrix ) = "1";
                   
                 end,
               
               IsIdentityMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsIdentityMatrix(", M, ")" ], "need_output", HOMALG_IO.Pictograms.IsIdentityMatrix ) = "1";
                   
                 end,
               
               IsDiagonalMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsDiagonalMatrix(", M, ")" ], "need_output", HOMALG_IO.Pictograms.IsDiagonalMatrix ) = "1";
                   
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
                   local list;
                   
                   if pos_list = [ ] then
                       list := [ 0 ];
                   else
                       Error( "a non-empty second argument is not supported in Singular yet: ", pos_list, "\n" );
                       list := pos_list;
                   fi;
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositions(", M, ", list (", list, "))" ], "need_output", HOMALG_IO.Pictograms.GetColumnIndependentUnitPositions ) );
                   
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
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositions_Z(", M, ", list (", list, "))" ], "need_output", HOMALG_IO.Pictograms.GetColumnIndependentUnitPositions ) );
                   
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
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositions(", M, ", list (", list, "))" ], "need_output", HOMALG_IO.Pictograms.GetRowIndependentUnitPositions ) );
                   
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
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositions_Z(", M, ", list (", list, "))" ], "need_output", HOMALG_IO.Pictograms.GetRowIndependentUnitPositions ) );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local list, list_string;
                   
                   if pos_list = [ ] then
                       list := [ 0 ];
                   else
                       list := pos_list;
                   fi;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPosition(", M, ", list (", list, "))" ], "need_output", HOMALG_IO.Pictograms.GetUnitPosition );
                   
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
                   
                   list_string := homalgSendBlocking( [ "GetUnitPosition_Z(", M, ", list (", list, "))" ], "need_output", HOMALG_IO.Pictograms.GetUnitPosition );
                   
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
                   
                   homalgSendBlocking( [ M, "[", j, i, "] =", M, "[", j, i, "]/", u ], "need_command", HOMALG_IO.Pictograms.DivideEntryByUnit );
                   
                 end,
               
               DivideRowByUnit :=
                 function( M, i, u, j )
                   local v;
                   
                   v := homalgStream( HomalgRing( M ) )!.variable_name;
                   
                   homalgSendBlocking( [ v, "i=", i, ";", v, "j=", j, ";for(", v, "k=1;", v, "k<=", NrColumns( M ), ";", v, "k=", v, "k+1){", M, "[", v, "k,", v, "i]=", M, "[", v, "k,", v, "i]/", u, ";};if(", v, "j>0){", M, "[", v, "j,", v, "i]=1;}" ], "need_command", HOMALG_IO.Pictograms.DivideRowByUnit );
                   
                 end,
               
               DivideColumnByUnit :=
                 function( M, j, u, i )
                   local v;
                   
                   v := homalgStream( HomalgRing( M ) )!.variable_name;
                   
                   homalgSendBlocking( [ v, "j=", j, ";", v, "i=", i, ";for(", v, "k=1;", v, "k<=", NrRows( M ), ";", v, "k=", v, "k+1){", M, "[", v, "j,", v, "k]=", M, "[", v, "j,", v, "k]/", u, ";};if(", v, "i>0){", M, "[", v, "j,", v, "i]=1;}" ], "need_command", HOMALG_IO.Pictograms.DivideColumnByUnit );
                   
                 end,
               
               CopyRowToIdentityMatrix :=
                 function( M, i, L, j )
                   local v, l;
                   
                   v := homalgStream( HomalgRing( M ) )!.variable_name;
                   
                   l := Length( L );
                   
                   if l > 1 and ForAll( L, IsHomalgMatrix ) then
                       homalgSendBlocking( [ v, "i=", i, ";", v, "j=", j, ";for(", v, "k=1;", v, "k<=", NrColumns( M ), ";", v, "k=", v, "k+1){", L[1], "[", v, "k,", v, "j]=-", M, "[", v, "k,", v, "i];", L[2], "[", v, "k,", v, "j]=", M, "[", v, "k,", v, "i];", "};", L[1], "[", v, "j,", v, "j]=1;", L[2], "[", v, "j,", v, "j]=1" ], "need_command", HOMALG_IO.Pictograms.CopyRowToIdentityMatrix );
                   elif l > 0 and IsHomalgMatrix( L[1] ) then
                       homalgSendBlocking( [ v, "i=", i, ";", v, "j=", j, ";for(", v, "k=1;", v, "k<=", NrColumns( M ), ";", v, "k=", v, "k+1){", L[1], "[", v, "k,", v, "j]=-", M, "[", v, "k,", v, "i];};", L[1], "[", v, "j,", v, "j]=1;" ], "need_command", HOMALG_IO.Pictograms.CopyRowToIdentityMatrix );
                   elif l > 1 and IsHomalgMatrix( L[2] ) then
                       homalgSendBlocking( [ v, "i=", i, ";", v, "j=", j, ";for(", v, "k=1;", v, "k<=", NrColumns( M ), ";", v, "k=", v, "k+1){", L[2], "[", v, "k,", v, "j]=", M, "[", v, "k,", v, "i];", "};", L[2], "[", v, "j,", v, "j]=1" ], "need_command", HOMALG_IO.Pictograms.CopyRowToIdentityMatrix );
                   fi;
                   
                 end,
               
               CopyColumnToIdentityMatrix :=
                 function( M, j, L, i )
                   local v, l;
                   
                   v := homalgStream( HomalgRing( M ) )!.variable_name;
                   
                   l := Length( L );
                   
                   if l > 1 and ForAll( L, IsHomalgMatrix ) then
                       homalgSendBlocking( [ v, "j=", j, ";", v, "i=", i, ";for(", v, "k=1;", v, "k<=", NrRows( M ), ";", v, "k=", v, "k+1){", L[1], "[", v, "i,", v, "k]=-", M, "[", v, "j,", v, "k];", L[2], "[", v, "i,", v, "k]=", M, "[", v, "j,", v, "k];", "};", L[1], "[", v, "i,", v, "i]=1;", L[2], "[", v, "i,", v, "i]=1" ], "need_command", HOMALG_IO.Pictograms.CopyColumnToIdentityMatrix );
                   elif l > 0 and IsHomalgMatrix( L[1] ) then
                       homalgSendBlocking( [ v, "j=", j, ";", v, "i=", i, ";for(", v, "k=1;", v, "k<=", NrRows( M ), ";", v, "k=", v, "k+1){", L[1], "[", v, "i,", v, "k]=-", M, "[", v, "j,", v, "k];", L[1], "[", v, "i,", v, "i]=1;" ], "need_command", HOMALG_IO.Pictograms.CopyColumnToIdentityMatrix );
                   elif l > 1 and IsHomalgMatrix( L[2] ) then
                       homalgSendBlocking( [ v, "j=", j, ";", v, "i=", i, ";for(", v, "k=1;", v, "k<=", NrRows( M ), ";", v, "k=", v, "k+1){", L[2], "[", v, "i,", v, "k]=", M, "[", v, "j,", v, "k];", "};", L[2], "[", v, "i,", v, "i]=1" ], "need_command", HOMALG_IO.Pictograms.CopyColumnToIdentityMatrix );
                   fi;
                   
                 end,
               
               SetColumnToZero :=
                 function( M, i, j )
                   local v;
                   
                   v := homalgStream( HomalgRing( M ) )!.variable_name;
                   
                   homalgSendBlocking( [ v, "i=", i, ";", v, "j=", j, ";for(", v, "k=1;", v, "k<", v, "i;", v, "k=", v, "k+1){", M, "[", v, "j,", v, "k]=0;};for(", v, "k=", v, "i+1;", v, "k<=", NrRows( M ), ";", v, "k=", v, "k+1){", M, "[", v, "j,", v, "k]=0;}" ], "need_command", HOMALG_IO.Pictograms.SetColumnToZero );
                   
                 end,
               
               GetCleanRowsPositions :=
                 function( M, clean_columns )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "GetCleanRowsPositions(", M, ", list (", clean_columns, "))" ], "need_output", HOMALG_IO.Pictograms.GetCleanRowsPositions );
                   
                   return StringToIntList( list_string );
                   
                 end,
               
               ## determined by CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries
               AffineDimension :=
                 function( mat )
                   
                   if ZeroColumns( mat ) <> [ ] and
                      ## the only case of a free direct summand we are allowed to send to Singular (<= 3-1-3)
                      not ( IsZero( mat ) and NrRows( mat ) = 1 and NrColumns( mat ) = 1 ) then
                       Error( "Singular (<= 3-1-3) does not handle nontrivial free direct summands correctly\n" );
                   fi;
                   
                   return Int( homalgSendBlocking( [ "dim(std(", mat, "))" ], "need_output", HOMALG_IO.Pictograms.AffineDimension ) );
                   
                 end,
               
               CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries :=
                 function( mat )
                   local hilb;
                   
                   if ZeroColumns( mat ) <> [ ] and
                      ## the only case of a free direct summand we allowed to send to Singular (<= 3-1-3)
                      not ( IsZero( mat ) and NrRows( mat ) = 1 and NrColumns( mat ) = 1 ) then
                       Error( "Singular (<= 3-1-3) does not handle nontrivial free direct summands correctly\n" );
                   fi;
                   
                   hilb := homalgSendBlocking( [ "hilb(std(", mat, "),1)" ], "need_output", HOMALG_IO.Pictograms.HilbertPoincareSeries );
                   
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
               #       not ( IsZero( mat ) and NrRows( mat ) = 1 and NrColumns( mat ) = 1 ) then
               #        Error( "Singular (<= 3-1-3) does not handle nontrivial free direct summands correctly\n" );
               #    fi;
               #    
               #    hilb := homalgSendBlocking( [ "hilb(std(", mat, "),2)" ], "need_output", HOMALG_IO.Pictograms.HilbertPoincareSeries );
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
                      not ( IsZero( mat ) and NrRows( mat ) = 1 and NrColumns( mat ) = 1 ) then
                       Error( "Singular (<= 3-1-3) does not handle nontrivial free direct summands correctly\n" );
                   fi;
                   
                   hilb := homalgSendBlocking( [ "CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries(", mat, ", intvec(", weights,"), intvec(", degrees, "))" ], "need_output", HOMALG_IO.Pictograms.HilbertPoincareSeries );
                   
                   hilb := StringToIntList( hilb );
                   
                   if hilb = [ 0, 0 ] then
                       return [ 0 ];
                   fi;
                   
                   return hilb;
                   
                 end,
               
               PrimaryDecomposition :=
                 function( mat )
                   local R, v, c;
                   
                   if not NrColumns( mat ) = 1 then
                       Error( "only primary decomposition of one-column matrices is supported\n" );
                   fi;
                   
                   R := HomalgRing( mat );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ "list ", v, "l=PrimaryDecomposition(", mat, ")" ], "need_command", HOMALG_IO.Pictograms.PrimaryDecomposition );
                   
                   c := Int( homalgSendBlocking( [ "size(", v, "l)" ], "need_output", R, HOMALG_IO.Pictograms.PrimaryDecomposition ) );
                   
                   return
                     List( [ 1 .. c ],
                           function( i )
                             local primary, prime;
                             
                             primary := HomalgVoidMatrix( "unkown_number_of_rows", 1, R );
                             prime := HomalgVoidMatrix( "unkown_number_of_rows", 1, R );
                             
                             homalgSendBlocking( [ "matrix ", primary, "[1][size(", v, "l[", i, "][1])]=", v, "l[", i, "][1]" ], "need_command", HOMALG_IO.Pictograms.PrimaryDecomposition );
                             homalgSendBlocking( [ "matrix ", prime, "[1][size(", v, "l[", i, "][2])]=", v, "l[", i, "][2]" ], "need_command", HOMALG_IO.Pictograms.PrimaryDecomposition );
                             
                             return [ primary, prime ];
                             
                           end
                         );
                   
                 end,
               
               Eliminate :=
                 function( rel, indets, R )
                   local elim;
                   
                   elim := Product( indets );
                   
                   return homalgSendBlocking( [ "matrix(eliminate(ideal(", rel, "),", elim, "))" ], [ "matrix" ], R, HOMALG_IO.Pictograms.Eliminate );
                   
                 end,
               
               Coefficients :=
                 function( poly, var )
                   local R, v, vars, coeffs;
                   
                   R := HomalgRing( poly );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ "matrix ", v, "m = coef(", poly, var, ")" ], "need_command", HOMALG_IO.Pictograms.Coefficients );
                   vars :=homalgSendBlocking( [ "submat(", v, "m,1..1,1..ncols(", v, "m))" ], [ "matrix" ], R, HOMALG_IO.Pictograms.Coefficients );
                   coeffs := homalgSendBlocking( [ "submat(", v, "m,2..2,1..ncols(", v, "m))" ], [ "matrix" ], R, HOMALG_IO.Pictograms.Coefficients );
                   
                   return [ vars, coeffs ];
                   
                 end,
               
               IndicatorMatrixOfNonZeroEntries :=
                 function( mat )
                   local l;
                   
                   l := StringToIntList( homalgSendBlocking( [ "IndicatorMatrixOfNonZeroEntries(", mat, ")" ], "need_output", HOMALG_IO.Pictograms.IndicatorMatrixOfNonZeroEntries ) );
                   
                   return ListToListList( l, NrRows( mat ), NrColumns( mat ) );
                   
                 end,
               
               DegreeOfRingElement :=
                 function( r, R )
                   
                   return Int( homalgSendBlocking( [ "deg( ", r, " )" ], "need_output", HOMALG_IO.Pictograms.DegreeOfRingElement ) );
                   
                 end,
               
               CoefficientsOfUnivariatePolynomial :=
                 function( r, var )
                   
                   return homalgSendBlocking( [ "coeffs( ", r, var, " )" ], [ "matrix" ], HOMALG_IO.Pictograms.Coefficients );
                   
                 end,
               
               LeadingModule :=
                 function( mat )
                   
                   return homalgSendBlocking( [ "matrix(lead(module(", mat, ")))" ], [ "matrix" ], HOMALG_IO.Pictograms.LeadingModule );
                   
                 end,
               
               MonomialMatrix :=
                 function( i, vars, R )
                   
                   return homalgSendBlocking( [ "matrix(ideal(", vars, ")^", i, ")" ], [ "matrix" ], R, HOMALG_IO.Pictograms.MonomialMatrix );
                   
                 end,
               
               MatrixOfSymbols :=
                 function( mat )
                   
                   return homalgSendBlocking( [ "MatrixOfSymbols(", mat, ")" ], [ "matrix" ], HOMALG_IO.Pictograms.MatrixOfSymbols );
                   
                 end,
               
               MatrixOfSymbols_workaround :=
                 function( mat )
                   
                   return homalgSendBlocking( [ "MatrixOfSymbols_workaround(", mat, ")" ], [ "matrix" ], HOMALG_IO.Pictograms.MatrixOfSymbols );
                   
                 end,
               
               Pullback :=
                 function( phi, M )
                   
                   if not IsBound( phi!.RingMap ) then
                       phi!.RingMap :=
                         homalgSendBlocking( [ Source( phi ), ImagesOfRingMap( phi ) ], [ "map" ], Range( phi ), HOMALG_IO.Pictograms.define );
                   fi;
                   
                   return homalgSendBlocking( [ phi!.RingMap, "(", M, ")" ], [ "matrix" ], Range( phi ), HOMALG_IO.Pictograms.Pullback );
                   
                 end,
               
               RandomPol :=
                 function( arg )
                   local R;
                   
                   R := arg[1];
                   
                   return homalgSendBlocking( [ "sparsepoly(", arg{[ 2 .. Length( arg ) ]}, ")" ], [ "def" ], R, HOMALG_IO.Pictograms.RandomPol );
                   
                 end,
               
               Evaluate :=
                 function( p, L )
                     
                   # Remember here the list L is of the form var1, val1, var2, val2, ...
                   return homalgSendBlocking( [ "subst(", p, L, ")" ], [ "poly" ], HOMALG_IO.Pictograms.Evaluate );
                   
                 end,
               
               EvaluateMatrix :=
                 function( M, L )
                   
                   # Remember here the list L is of the form var1, val1, var2, val2, ...
                   return homalgSendBlocking( [ "EvaluateMatrix(", M, L, ")" ], [ "matrix" ], HOMALG_IO.Pictograms.Evaluate );
                   
                 end,
               
               NumeratorAndDenominatorOfPolynomial :=    
                 function( p )
                   local R, v, numer, denom;
                   
                   R := HomalgRing( p );
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ "list ", v, "l=NumeratorAndDenominatorOfPolynomial(", p, ")" ], "need_command", HOMALG_IO.Pictograms.Numerator );
                   
                   numer := homalgSendBlocking( [ v, "l[1]" ], [ "poly" ], R, HOMALG_IO.Pictograms.Numerator );
                   denom := homalgSendBlocking( [ v, "l[2]" ], [ "poly" ], R, HOMALG_IO.Pictograms.Numerator );
                   
                   numer := HomalgExternalRingElement( numer, R );
                   denom := HomalgExternalRingElement( denom, R );
                   
                   return [ numer, denom ];
                   
                 end,
               
               Inequalities :=
                 function( R )
                   local v, l;
                   
                   v := homalgStream( R )!.variable_name;
                   
                   homalgSendBlocking( [ "list ", v, "l=system(\"denom_list\")" ], R, "need_command", HOMALG_IO.Pictograms.Inequalities );
                   
                   l := Int( homalgSendBlocking( [ "size(", v, "l)" ], R, "need_output", HOMALG_IO.Pictograms.Inequalities ) );
                   
                   l := List( [ 1 .. l ], i -> homalgSendBlocking( [ v, "l[", i, "]" ], [ "poly" ], R, HOMALG_IO.Pictograms.Inequalities ) );
                   
                   return List( l, a -> HomalgExternalRingElement( a, R ) );
                   
               end,
               
        )
 );
