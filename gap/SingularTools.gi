#############################################################################
##
##  SingularTools.gi          RingsForHomalg package  Markus Lange-Hegermann
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
               ZeroColumns := #was: ZeroRows
                 function( C )
                   local R, list_string;

                   R := HomalgRing( C );

                   list_string := homalgSendBlocking( [ "matrix Zero_Row[1][", NrColumns(C), "]; list l;for (int i=", NrColumns( C ), "; i>=1; i=i-1) { if (transpose(", C, ")[i] == Zero_Row || transpose(", C, ")[i] == 0) {l=insert(l,i);} }; string(l)" ] , "need_output", HOMALG_IO.Pictograms.ZeroColumns );

                   #trying to understand singular's output with removed spaces from homalg
                   if list_string = "empty list" or list_string = "emptylist" then
                     return StringToIntList( "[]" );
                   else
                     return StringToIntList( list_string );
                   fi;

                 end,
               
               ZeroRows := #was: ZeroColumns
                 function( C )
                   local R, list_string;

                   R := HomalgRing( C );

                   list_string := homalgSendBlocking( [ "matrix Zero_Row[1][", NrRows(C), "]; list l;for (int i=", NrRows( C ), "; i>=1; i=i-1) { if (", C, "[i] == Zero_Row || ", C, "[i] == 0) {l=insert(l,i);} }; string(l)" ] , "need_output", HOMALG_IO.Pictograms.ZeroRows );

                   #trying to understand singular's output
                   if list_string = "empty list" or list_string = "emptylist" then
                     return StringToIntList( "[]" );
                   else
                     return StringToIntList( list_string );
                   fi;

                 end,
               
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               IsZero := r -> homalgSendBlocking( [ r, " == 0" ] , "need_output", HOMALG_IO.Pictograms.IsZero ) = "1",
               
               IsOne := r -> homalgSendBlocking( [ r, " == 1" ] , "need_output", HOMALG_IO.Pictograms.IsOne ) = "1",
               
               Zero := HomalgExternalRingElement( "0", "Singular", IsZero ),
               
               One := HomalgExternalRingElement( "1", "Singular", IsOne ),
               
               MinusOne := HomalgExternalRingElement( "-1", "Singular" ),
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, " == ",  B ] , "need_output", HOMALG_IO.Pictograms.AreEqualMatrices ) = "1";
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "0" ] , [ "matrix" ] , [ "[", NrColumns( C ), "][", NrRows( C ), "]" ], C, HOMALG_IO.Pictograms.ZeroMatrix );
                   
                 end,
             
               IdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "unitmat(", NrRows(C), ")" ] , [ "matrix" ] , [ "[", NrRows(C), "][", NrRows(C), "]"], C, HOMALG_IO.Pictograms.IdentityMatrix );
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return homalgSendBlocking( [ "transpose(", M, ")" ], [ "matrix" ], HOMALG_IO.Pictograms.Involution );
                   
                 end,
               
               CertainColumns := #was: CertainRows
                 function( M, plist )
                    
                   return homalgSendBlocking( [ "submat(", M, ",intvec(", plist, "),1..", NrRows( M ), ")" ], [ "matrix" ], HOMALG_IO.Pictograms.CertainColumns );
                    
                 end,
               
               CertainRows := #was: CertainColumns
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "submat(", M, ",1..", NrColumns( M ), ",intvec(", plist, "))" ], [ "matrix" ], HOMALG_IO.Pictograms.CertainRows );
                   
                 end,
               
               UnionOfColumns := #was UnionOfRows
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, B ], [ "matrix" ], [ "[", NrColumns(A) + NrColumns(B), "][", NrRows(A), "]" ], HOMALG_IO.Pictograms.UnionOfColumns );
                   
                 end,
               
               UnionOfRows := #was: UnionOfColumns
                 function( A, B )
                   
                   return homalgSendBlocking( [ "concat(", A, B, ")" ], [ "matrix" ], [ "[", NrColumns(A), "][", NrRows(A) + NrRows(B), "]" ], HOMALG_IO.Pictograms.UnionOfRows );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := Concatenation( [ "dsum(" ], e, [ ")" ] );
                   
                   return homalgSendBlocking( f, [ "matrix" ], [ "[", Sum( List( e, NrColumns ) ), "][", Sum( List( e, NrRows ) ), "]" ], HOMALG_IO.Pictograms.DiagMat );
                   
                 end,
               
               KroneckerMat :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ "tensor(", A, B, ")" ], [ "matrix" ], [ "[", NrColumns( A ) * NrColumns( B ), "][", NrRows( A ) * NrRows( B ), "]" ], HOMALG_IO.Pictograms.KroneckerMat );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return homalgSendBlocking( [ A, "*", a ], [ "matrix" ],  HOMALG_IO.Pictograms.MulMat );
                   
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
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ "transpose( transpose(", A, ") * transpose(", B, ") )" ], [ "matrix" ], HOMALG_IO.Pictograms.Compose ); # FIXME : this has to be extensively documented to be understandable!
		   
                 end,
               
               NrRows :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "ncols(", C, ")" ], "need_output", HOMALG_IO.Pictograms.NrRows ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ "nrows(", C, ")" ], "need_output", HOMALG_IO.Pictograms.NrColumns ) );
                   
                 end,
               
               Minus :=
                 function( a, b )
                     
                   return homalgSendBlocking( [ a, " - ( ", b, " )" ], "need_output", HOMALG_IO.Pictograms.Minus );
                     
                 end,
                   
               IsUnit :=	#FIXME: just for polynomial rings(?)
                 function( R, r )
		   
                   return homalgSendBlocking( [ "deg( ", r, " )" ], "need_output", HOMALG_IO.Pictograms.IsUnit ) = "0";
                   
                 end,
               
               DivideByUnit :=
                 function( a, e )
                   local u;
		   if IsHomalgExternalRingElement( e ) then
		     u := homalgPointer( e );
	           else
		     u := e;
	           fi;
		   
                   if u{[1]} = "-" then
                     #Info( InfoWarning, 1, "\033[01m\033[5;31;47mdividing by a unit starting with a minus sign:\033[0m ", u );
                     return homalgSendBlocking( [ "-(", a, ")/", u{[ 2..Length( u ) ]} ], "need_output", HOMALG_IO.Pictograms.DivideByUnit );
                   else
                     return homalgSendBlocking( [ "(",  a, ")/", u ], "need_output", HOMALG_IO.Pictograms.DivideByUnit );
                   fi;
                   
                 end,
                   
               GetUnitPosition :=
                 function( M, pos_list )
                   local list, list_string;
                   
                   if pos_list = [ ] then
                       list := [ 0 ];
                   else
                       list := pos_list;
                   fi;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPosition(", M, ", list (", list, "))" ], "need_output", "break_lists", HOMALG_IO.Pictograms.GetUnitPosition );
                   
                   if list_string = "fail" then
                       return fail;
                   else
                       return StringToIntList( list_string );
                   fi;
                   
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
                 
      )
);
