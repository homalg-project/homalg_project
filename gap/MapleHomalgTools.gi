#############################################################################
##
##  MapleHomalgTools.gi         homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
## Implementations for the rings provided by the ring packages
## of the Maple implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForMapleHomalgTools,
        
        rec(
               IsZeroMatrix :=
                 function( M )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return HomalgSendBlocking( [ "`homalg/IsZeroMapF`(", M, R, "[1],", R, "[2])" ] , "need_output" ) = "true";
                   
                 end,
               
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               AreEqualMatrices :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ "`homalg/IsZeroMapF`(", "`homalg/SubMat`(", A, B, R, "[1],", R, "[2]),", R, "[1],", R, "[2])" ] , "need_output" ) = "true";
                   
                 end,
               
               ZeroMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return HomalgSendBlocking( [ "`homalg/ZeroMap`(", NrRows( C ), NrColumns( C ), R, "[1],", R, "[2])" ] );
                   
                 end,
             
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return HomalgSendBlocking( [ "`homalg/IdentityMap`(", NrRows( C ), R, "[1],", R, "[2])" ] );
                   
                 end,
               
               Involution :=
                 function( M )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return HomalgSendBlocking( [ "`homalg/Involution`(", M, R, "[1],", R, "[2])" ] );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return HomalgSendBlocking( [ R, "[2][CertainRows](", M, plist, ")" ] );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return HomalgSendBlocking( [ R, "[2][CertainColumns](", M, plist, ")" ] );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ R, "[2][matrix](", R, "[2][UnionOfRows](", A, B, "))" ] );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ R, "[2][matrix](", R, "[2][UnionOfColumns](", A, B, "))" ] );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local R, f;
                   
                   R := HomalgRing( e[1] );
                   
                   f := Concatenation( [ "`homalg/DiagMat`(" ], e, [ R, "[2])" ] );
                   
                   return HomalgSendBlocking( f );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ "`homalg/MulMat`(", a, A, R, "[1],", R, "[2])" ] );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ "`homalg/AddMat`(", A, B, R, "[1],", R, "[2])" ] );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ "`homalg/SubMat`(", A, B, R, "[1],", R, "[2])" ] );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return HomalgSendBlocking( [ "`homalg/Compose`(", A, B, R, "[1],", R, "[2])" ] );
                   
                 end,
               
               NrRows :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return Int( HomalgSendBlocking( [ R, "[2][NumberOfRows](", C, ")" ], "need_output" ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return Int( HomalgSendBlocking( [ R, "[2][NumberOfGenerators](", C, ")" ], "need_output" ) );
                   
                 end
                 
        )
 );
