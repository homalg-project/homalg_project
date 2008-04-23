#############################################################################
##
##  MAGMATools.gi             RingsForHomalg package         Mohamed Barakat
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
               IsZeroMatrix :=
                 function( M )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ M, " eq ZeroMatrix(", R, NrRows( M ), NrColumns( M ), ")" ] , "need_output" ) = "true";
                   
                 end,
               
               ZeroRows :=
                 function( C )
                   local R, list_string;
                   
                   R := HomalgRing( C );
                   
                   list_string := homalgSendBlocking( [ "z := ZeroMatrix(", R, ",1,", NrColumns( C ), "); [i: i in [ 1 .. ", NrRows( C ), " ] | RowSubmatrixRange(", C, ",i,i) eq z ];" ], "need_output" );
                   return StringToIntList( list_string );
                   
                 end,
               
               ZeroColumns :=
                 function( C )
                   local R, list_string;
                   
                   R := HomalgRing( C );
                   
                   list_string := homalgSendBlocking( [ "z := ZeroMatrix(", R, NrRows( C ), ",1); [i: i in [ 1 .. ", NrColumns( C ), " ] | ColumnSubmatrixRange(", C, ",i,i) eq z ];" ], "need_output" );
                   return StringToIntList( list_string );
                   
                 end,
               
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               Zero := HomalgExternalRingElement( "0", "MAGMA", IsZero ),
               
               One := HomalgExternalRingElement( "1", "MAGMA", IsOne ),
               
               MinusOne := HomalgExternalRingElement( "(-1)", "MAGMA" ),
               
               AreEqualMatrices :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ A, " eq ",  B ] , "need_output" ) = "true";
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return homalgSendBlocking( [ "ZeroMatrix(", R, NrRows( C ), NrColumns( C ), ")" ] );
                   
                 end,
             
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return homalgSendBlocking( [ "ScalarMatrix(", R, NrRows( C ), ",1)" ] );
                   
                 end,
               
               Involution :=
                 function( M )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "Transpose(", M, ")" ] );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "Matrix(", M, "[", plist, "])" ] );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "Transpose(Matrix(Transpose(", M, ")[",plist, "]))" ] );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ "VerticalJoin(", A, B, ")" ] );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ "HorizontalJoin(", A, B, ")" ] );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := Concatenation( [ "DiagonalJoin([" ], e, [ "])" ] );
                   
                   return homalgSendBlocking( f );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ a, "*", A ] );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ A, "+", B ] );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ A, "-", B ] );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ A, "*", B ] );
                   
                 end,
               
               NrRows :=
                 function( C )
                   
                   return Int( homalgSendBlocking( [ "NumberOfRows(", C, ")" ], "need_output" ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   return Int( homalgSendBlocking( [ "NumberOfColumns(", C, ")" ], "need_output" ) );
                   
                 end,
               
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, " - ( ", b, " )" ], "need_output" );
                   
                 end,
                 
        )
 );
