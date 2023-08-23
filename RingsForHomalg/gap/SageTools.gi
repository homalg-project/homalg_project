# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementations for the rings provided by Sage.

####################################
#
# global variables:
#
####################################

BindGlobal( "CommonHomalgTableForSageTools",
        
        rec(
               Zero := HomalgExternalRingElement( R -> homalgSendBlocking( [ R, ".zero()" ], "Zero" ), "Sage", IsZero ),
               
               One := HomalgExternalRingElement( R -> homalgSendBlocking( [ R, ".one()" ], "One" ), "Sage", IsOne ),
               
               MinusOne := HomalgExternalRingElement( R -> homalgSendBlocking( [ "-", R, ".one()" ], "MinusOne" ), "Sage", IsMinusOne ),
               
               RingElement := R -> r -> homalgSendBlocking( [ R, ".one() * (", r, ")" ], "define" ),
               
               IsZero := r -> homalgSendBlocking( [ r, " == ", Zero( r ) ] , "need_output", "IsZero" ) = "True",
               
               IsOne := r -> homalgSendBlocking( [ r, " == ", One( r ) ] , "need_output", "IsOne" ) = "True",
               
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, " - ( ", b, " )" ], "Minus" );
                   
                 end,
                 
               Equal :=
                 function( A, B )
                 
                   return homalgSendBlocking( [ A, "==", B ], "need_output", "AreEqualMatrices" ) = "True";
                 
                 end,
               
               ZeroMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "matrix(", HomalgRing( C ), NumberRows( C ), NumberColumns( C ), ")" ], "ZeroMatrix" );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return homalgSendBlocking( [ "identity_matrix(", R, NumberRows( C ), ")" ], "IdentityMatrix" );
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return homalgSendBlocking( [ M, ".transpose()" ], "Involution" );
                   
                 end,
               
               TransposedMatrix :=
                 function( M )
                   
                   return homalgSendBlocking( [ M, ".transpose()" ], "TransposedMatrix" );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   
                   plist := plist - 1;
                   return homalgSendBlocking( [ M, ".matrix_from_rows(", plist, ")" ], "CertainRows" );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   plist := plist - 1;
                   return homalgSendBlocking( [ M, ".matrix_from_columns(", plist, ")" ], "CertainColumns" );
                   
                 end,
               
               UnionOfRowsPair :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "block_matrix([", A, B, "],ncols=2)" ], "UnionOfRows" );
                   
                 end,
               
               UnionOfColumnsPair :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "block_matrix([", A, B, "],ncols=1)" ], "UnionOfColumns" );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := ShallowCopy( e );
                   Add( f, "block_diagonal_matrix(", 1 );
                   Add( f, ")" );
                   return homalgSendBlocking( f, "DiagMat" );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return homalgSendBlocking( [ "(", a, ")*", A ], "MulMat" );
                   
                 end,
               
               MulMatRight :=
                 function( A, a )
                   
                   return homalgSendBlocking( [ A, "*(", a, ")" ], "MulMatRight" );
                   
                 end,
               
               AddMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "+", B ], "AddMat" );
                   
                 end,
               
               SubMat :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "-", B ], "SubMat" );
                   
                 end,
               
               Compose :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ A, "*", B ], "Compose" );
                   
                 end,
               
               NumberRows :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ C, ".nrows()" ], "need_output", "NumberRows" ) );
                   
                 end,
                 
               NumberColumns :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ C, ".ncols()" ], "need_output", "NumberColumns" ) );
                   
                 end,
                 
               ZeroRows :=
                 function( C )
                   return StringToIntList( homalgSendBlocking( [ "ZeroRows(", C, ")" ], "need_output", "ZeroRows" ) ) + 1;
                 end,
               
               ZeroColumns :=
                 function( C )
                   return StringToIntList( homalgSendBlocking( [ "ZeroColumns(", C, ")" ], "need_output", "ZeroColumns" ) ) + 1;
                 end,
       
        )
 );
