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
               IsZeroMatrix :=
                 function( M )
                   homalgSendBlocking( [ "matrix Zero_Matrix[", NrRows( M ), "][", NrColumns( M ), "]" ], "need_command", M );
                   return homalgSendBlocking( [ M, "==Zero_Matrix" ] , "need_output", HOMALG_IO.Pictograms.IsZeroMatrix ) = "1";
                   
                 end,
               
               ZeroColumns := #was: ZeroRows
                 function( C )
                   local R, list_string;

                   R := HomalgRing( C );

                   homalgSendBlocking( [ "matrix Zero_Row[1][", NrColumns(C), "]" ] , C, "need_command" );

                   homalgSendBlocking( [ "list l;for (int i=1; i<=", NrColumns(C), "; i=i+1) { if (transpose(", C, ")[i] == Zero_Row || transpose(", C, ")[i] == 0) {l=insert(l,i);} }" ] , "need_command", HOMALG_IO.Pictograms.ZeroColumns );

                   list_string := homalgSendBlocking( [ "string(l)" ], C, "need_output" );

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

                   homalgSendBlocking( [ "matrix Zero_Row[1][", NrRows(C), "]" ] , C, "need_command" );

                   homalgSendBlocking( [ "list l;for (int i=1; i<=", NrRows(C), "; i=i+1) { if (", C, "[i] == Zero_Row || ", C, "[i] == 0) {l=insert(l,i);} }" ] , "need_command", HOMALG_IO.Pictograms.ZeroRows );

                   list_string := homalgSendBlocking( [ "string(l)" ], C, "need_output" );

                   #trying to understand singular's output
                   if list_string = "empty list" or list_string = "emptylist" then
                     return StringToIntList( "[]" );
                   else
                     return StringToIntList( list_string );
                   fi;

                 end,
               
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               Zero := HomalgExternalRingElement( "0", "Singular", IsZero ),
               
               One := HomalgExternalRingElement( "1", "Singular", IsOne ),
               
               MinusOne := HomalgExternalRingElement( "(-1)", "Singular" ),
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, " == ",  B ] , "need_output", HOMALG_IO.Pictograms.AreEqualMatrices ) = "1";
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "0" ] , [ "matrix" ] , [ "[" , NrColumns( C ) , "][" , NrRows( C ) , "]" ], C, HOMALG_IO.Pictograms.ZeroMatrix );
                   
                 end,
             
               IdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "unitmat(", NrRows(C), ")" ] , [ "matrix" ] , [ "[", NrRows(C), "][", NrRows(C), "]"], C, HOMALG_IO.Pictograms.IdentityMatrix );
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return homalgSendBlocking( [ "transpose(", M, ")" ], HOMALG_IO.Pictograms.Involution );
                   
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
               
               MulMat :=
                 function( a, A )
                   
                   return homalgSendBlocking( [ A, "*", a ], HOMALG_IO.Pictograms.MulMat );
                   
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
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ B, "*", A ], [ "matrix" ], HOMALG_IO.Pictograms.Compose );
                   
                 end,
               
               NrRows :=
                 function( C )
                   
                   return Int( homalgSendBlocking( [ "ncols(", C, ")" ], "need_output", HOMALG_IO.Pictograms.NrRows ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   return Int( homalgSendBlocking( [ "nrows(", C, ")" ], "need_output", HOMALG_IO.Pictograms.NrColumns ) );
                   
                 end,
               
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, " - ( ", b, " )" ], "need_output", HOMALG_IO.Pictograms.Minus );
                   
                 end,
               
        )
 );
