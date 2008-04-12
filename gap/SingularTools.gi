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
                   return homalgSendBlocking( [ M, "==Zero_Matrix" ] , "need_output" ) = "1";
                   
                 end,
               
#               ZeroRows :=
#                 function( C )
#                   local R, list_string;
#                   
#                   R := HomalgRing( C );
#                   
#                   list_string := homalgSendBlocking( [ "z := ZeroMatrix(", R, ",1,", NrColumns( C ), "); [i: i in #[ 1 .. ", NrRows( C ), " ] | RowSubmatrixRange(", C, ",i,i) eq z ];" ], "need_output" );
#                   return StringToIntList( list_string );
#                   
#                 end,
               
#               ZeroColumns :=
#                 function( C )
#                   local R, list_string;
#                   
#                   R := HomalgRing( C );
#                   
#                   list_string := homalgSendBlocking( [ "z := ZeroMatrix(", R, NrRows( C ), ",1); [i: i in [ 1 .. #", NrColumns( C ), " ] | ColumnSubmatrixRange(", C, ",i,i) eq z ];" ], "need_output" );
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
                   
                   return homalgSendBlocking( [ A, " == ",  B ] , "need_output" ) = "1";
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "0" ] , [ "matrix" ] , [ "[" , NrRows( C ) , "][" , NrColumns( C ) , "]" ], C );
                   
                 end,
             
               IdentityMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "unitmat(", NrRows(C), ")" ] , [ "matrix" ] , [ "[", NrRows(C), "][", NrRows(C), "]"], C );
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return homalgSendBlocking( [ "transpose(", M, ")" ] );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                    
                   return homalgSendBlocking( [ "submat(", M, ",intvec(", plist, "),1..", NrColumns( M ), ")" ], [ "matrix" ] );
                    
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "submat(", M, ",1..", NrRows(M), ",intvec(", plist, "))" ], [ "matrix" ] );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, B ], [ "matrix" ], [ "[", NrRows(A) + NrRows(B), "][", NrColumns(A), "]" ] );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "concat(", A, B, ")" ], [ "matrix" ], [ "[", NrRows(A), "][", NrColumns(A) + NrColumns(B), "]" ] );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := Concatenation( [ "dsum([" ], e, [ "])" ] );
                   
                   return homalgSendBlocking( f );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return homalgSendBlocking( [ A, "*", a ] );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "+", B ] );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "-", B ] );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ B, "*", A ] );
                   
                 end,
               
               NrRows :=
                 function( C )
                   
                   return Int( homalgSendBlocking( [ "nrows(", C, ")" ], "need_output" ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   return Int( homalgSendBlocking( [ "ncols(", C, ")" ], "need_output" ) );
                   
                 end
               
        )
 );
