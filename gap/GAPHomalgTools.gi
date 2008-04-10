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
                   
                   return HomalgSendBlocking( [ "IsZeroMatrix(", M, ")" ] , "need_output" ) = "true";
                   
                 end,
               
               ZeroRows :=
                 function( C )
                   local list_string;
                   
                   list_string := HomalgSendBlocking( [ "ZeroRows(", C, ")" ], "need_output" );
                   return StringToIntList( list_string );
                   
                 end,
               
               ZeroColumns :=
                 function( C )
                   local list_string;
                   
                   list_string := HomalgSendBlocking( [ "ZeroColumns(", C, ")" ], "need_output" );
                   return StringToIntList( list_string );
                   
                 end,
               
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               Zero := HomalgExternalRingElement( "0", "GAP", IsZero ),
               
               One := HomalgExternalRingElement( "1", "GAP", IsOne ),
               
               MinusOne := HomalgExternalRingElement( "(-1)", "GAP" ),
               
               AreEqualMatrices :=
                 function( A, B )
                   
                   return HomalgSendBlocking( [ A, "=", B ] , "need_output" ) = "true";
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return HomalgSendBlocking( [ "HomalgZeroMatrix(", NrRows( C ), NrColumns( C ), R, ")" ] );
                   
                 end,
             
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return HomalgSendBlocking( [ "HomalgIdentityMatrix(", NrRows( C ), R, ")" ] );
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return HomalgSendBlocking( [ "Involution(", M, ")" ] );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   
                   return HomalgSendBlocking( [ "CertainRows(", M, plist, ")" ] );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   return HomalgSendBlocking( [ "CertainColumns(", M, plist, ")" ] );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   
                   return HomalgSendBlocking( [ "UnionOfRows(", A, B, ")" ] );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   
                   return HomalgSendBlocking( [ "UnionOfColumns(", A, B, ")" ] );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := Concatenation( [ "DiagMat([" ], e, [ "])" ] );
                   
                   return HomalgSendBlocking( f );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return HomalgSendBlocking( [ a, "*", A ] );
                   
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
                   
                   return HomalgSendBlocking( [ A, "*", B ] );
                   
                 end,
               
               NrRows :=
                 function( C )
                   
                   return Int( HomalgSendBlocking( [ "NrRows(", C, ")" ], "need_output" ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   return Int( HomalgSendBlocking( [ "NrColumns(", C, ")" ], "need_output" ) );
                   
                 end
                 
        )
 );
