#############################################################################
##
##  GAPHomalgTools.gi         RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the external rings provided by the ring packages
##  of the GAP implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForGAPHomalgTools,
        
        rec(
               IsZeroMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ "IsZeroMatrix(", M, ")" ] , "need_output" ) = "true";
                   
                 end,
               
               ZeroRows :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroRows(", C, ")" ], "need_output" );
                   return StringToIntList( list_string );
                   
                 end,
               
               ZeroColumns :=
                 function( C )
                   local list_string;
                   
                   list_string := homalgSendBlocking( [ "ZeroColumns(", C, ")" ], "need_output" );
                   return StringToIntList( list_string );
                   
                 end,
               
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               Zero := HomalgExternalRingElement( "0", "GAP", IsZero ),
               
               One := HomalgExternalRingElement( "1", "GAP", IsOne ),
               
               MinusOne := HomalgExternalRingElement( "(-1)", "GAP" ),
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "=", B ] , "need_output" ) = "true";
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return homalgSendBlocking( [ "HomalgZeroMatrix(", NrRows( C ), NrColumns( C ), R, ")" ] );
                   
                 end,
             
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return homalgSendBlocking( [ "HomalgIdentityMatrix(", NrRows( C ), R, ")" ] );
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return homalgSendBlocking( [ "Involution(", M, ")" ] );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "CertainRows(", M, plist, ")" ] );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   return homalgSendBlocking( [ "CertainColumns(", M, plist, ")" ] );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "UnionOfRows(", A, B, ")" ] );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "UnionOfColumns(", A, B, ")" ] );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := Concatenation( [ "DiagMat([" ], e, [ "])" ] );
                   
                   return homalgSendBlocking( f );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return homalgSendBlocking( [ a, "*", A ] );
                   
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
                   
                   return homalgSendBlocking( [ A, "*", B ] );
                   
                 end,
               
               NrRows :=
                 function( C )
                   
                   return Int( homalgSendBlocking( [ "NrRows(", C, ")" ], "need_output" ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   return Int( homalgSendBlocking( [ "NrColumns(", C, ")" ], "need_output" ) );
                   
                 end
                 
        )
 );
