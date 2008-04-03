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
                   HomalgSendBlocking( [ "matrix Zero_Matrix[", NrRows( M ), "][", NrColumns( M ), "]" ], "need_command", M );
                   return HomalgSendBlocking( [ M, "==Zero_Matrix" ] , "need_output" ) = "1";
                   
                 end,
               
#               ZeroRows :=
#                 function( C )
#                   local R, list_string;
#                   
#                   R := HomalgRing( C );
#                   
#                   list_string := HomalgSendBlocking( [ "z := ZeroMatrix(", R, ",1,", NrColumns( C ), "); [i: i in #[ 1 .. ", NrRows( C ), " ] | RowSubmatrixRange(", C, ",i,i) eq z ];" ], "need_output" );
#                   return StringToIntList( list_string );
#                   
#                 end,
               
#               ZeroColumns :=
#                 function( C )
#                   local R, list_string;
#                   
#                   R := HomalgRing( C );
#                   
#                   list_string := HomalgSendBlocking( [ "z := ZeroMatrix(", R, NrRows( C ), ",1); [i: i in [ 1 .. #", NrColumns( C ), " ] | ColumnSubmatrixRange(", C, ",i,i) eq z ];" ], "need_output" );
#                   return StringToIntList( list_string );
#                   
#                 end,
               
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               Zero := HomalgExternalRingElement( "0", "Singular", IsZero ),
               
               One := HomalgExternalRingElement( "1", "Singular", IsOne ),
               
               MinusOne := HomalgExternalRingElement( "(-1)", "Singular" ),
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return HomalgSendBlocking( [ A, " == ",  B ] , "need_output" ) = "1";
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   
                   return HomalgSendBlocking( [ "0" ] , [ "matrix" ] , [ "[" , NrRows( C ) , "][" , NrColumns( C ) , "]" ], C );
                   
                 end,
             
               IdentityMatrix :=
                 function( C )
                   
                   return HomalgSendBlocking( [ "unitmat(", NrRows(C), ")" ] , [ "matrix" ] , [ "[", NrRows(C), "][", NrRows(C), "]"], C );
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return HomalgSendBlocking( [ "transpose(", M, ")" ] );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   
                    return HomalgSendBlocking( [ "submat(", M, ",intvec(", plist, "),1..", NrColumns( M ), ")" ], [ "matrix" ] );
                    # HomalgSendBlocking( [ "intvec iv=", plist ], "need_command", M );
                    # return HomalgSendBlocking( [ "submat(", M, ",iv,1..", NrColumns(M), ")" ], [ "matrix" ] );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   return HomalgSendBlocking( [ "submat(", M, ",1..", NrRows(M), ",intvec(", plist, "))" ], [ "matrix" ] );
                   # HomalgSendBlocking( [ "intvec iv=", plist ], "need_command", M );
                   # return HomalgSendBlocking( [ "submat(", M, ",1..", NrRows(M), ",iv)" ], [ "matrix" ] );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   
                   return HomalgSendBlocking( [ A, B ], [ "matrix" ], [ "[", NrRows(A) + NrRows(B), "][", NrColumns(A), "]" ] );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   
                   return HomalgSendBlocking( [ "concat(", A, B, ")" ], [ "matrix" ], [ "[", NrRows(A), "][", NrColumns(A) + NrColumns(B), "]" ] );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := Concatenation( [ "dsum([" ], e, [ "])" ] );
                   
                   return HomalgSendBlocking( f );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return HomalgSendBlocking( [ A, "*", a ] );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   
                   return HomalgSendBlocking( [ A, "+", B ] );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   
                   return HomalgSendBlocking( [ A, "-", B ] );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ B, "*", A ] );
                   
                 end,
               
               NrRows :=
                 function( C )
                   
                   return Int( HomalgSendBlocking( [ "nrows(", C, ")" ], "need_output" ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   return Int( HomalgSendBlocking( [ "ncols(", C, ")" ], "need_output" ) );
                   
                 end
               
        )
 );
