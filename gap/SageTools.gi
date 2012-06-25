#############################################################################
##
##  SageTools.gi              RingsForHomalg package           Simon Goertzen
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the rings provided by Sage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( CommonHomalgTableForSageTools,
        
        rec(
               ZeroRows :=
                 function( C )
                   return StringToIntList( homalgSendBlocking( [ "ZeroRows(", C, ")" ], "need_output", HOMALG_IO.Pictograms.ZeroRows ) ) + 1;
                 end,
               
               ZeroColumns :=
                 function( C )
                   return StringToIntList( homalgSendBlocking( [ "ZeroColumns(", C, ")" ], "need_output", HOMALG_IO.Pictograms.ZeroColumns ) ) + 1;
                 end,
       
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               IsZero := r -> homalgSendBlocking( [ r, " == ", Zero( r ) ] , "need_output", HOMALG_IO.Pictograms.IsZero ) = "True",
               
               IsOne := r -> homalgSendBlocking( [ r, " == ", One( r ) ] , "need_output", HOMALG_IO.Pictograms.IsOne ) = "True",
               
               Zero := HomalgExternalRingElement( R -> homalgSendBlocking( [ R, ".zero_element()" ], "need_output", HOMALG_IO.Pictograms.Zero ), "Sage", IsZero ),
               
               One := HomalgExternalRingElement( R -> homalgSendBlocking( [ R, ".one_element()" ], "need_output", HOMALG_IO.Pictograms.One ), "Sage", IsOne ),
               
               MinusOne := HomalgExternalRingElement( R -> homalgSendBlocking( [ "-", R, ".one_element()" ], "need_output", HOMALG_IO.Pictograms.MinusOne ), "Sage", IsMinusOne ),
               
               Equal :=
                 function( A, B )
                 
                   return homalgSendBlocking( [ A, "==", B ], "need_output", HOMALG_IO.Pictograms.AreEqualMatrices ) = "True";
                 
                 end,
               
               ZeroMatrix :=
                 function( C )
                   
                   return homalgSendBlocking( [ "matrix(", HomalgRing( C ), NrRows( C ), NrColumns( C ), ")" ], HOMALG_IO.Pictograms.ZeroMatrix );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return homalgSendBlocking( [ "identity_matrix(", R, NrRows( C ), ")" ], HOMALG_IO.Pictograms.IdentityMatrix );
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return homalgSendBlocking( [ M, ".transpose()" ], HOMALG_IO.Pictograms.Involution );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   
                   plist := plist - 1;
                   return homalgSendBlocking( [ M, ".matrix_from_rows(", plist, ")" ], HOMALG_IO.Pictograms.CertainRows );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   plist := plist - 1;
                   return homalgSendBlocking( [ M, ".matrix_from_columns(", plist, ")" ], HOMALG_IO.Pictograms.CertainColumns );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "block_matrix([", A, B, "],ncols=2)" ], HOMALG_IO.Pictograms.UnionOfRows );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   
                   return homalgSendBlocking( [ "block_matrix([", A, B, "],ncols=1)" ], HOMALG_IO.Pictograms.UnionOfColumns );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := ShallowCopy( e );
                   Add( f, "block_diagonal_matrix(", 1 );
                   Add( f, ")" );
                   return homalgSendBlocking( f, HOMALG_IO.Pictograms.DiagMat );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return homalgSendBlocking( [ "(", a, ")*", A ], HOMALG_IO.Pictograms.MulMat );
                   
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
                   
                   return homalgSendBlocking( [ A, "*", B ], HOMALG_IO.Pictograms.Compose );
                   
                 end,
               
               NrRows :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ C, ".nrows()" ], "need_output", HOMALG_IO.Pictograms.NrRows ) );
                   
                 end,
                 
               NrColumns :=
                 function( C )
                   
                   return StringToInt( homalgSendBlocking( [ C, ".ncols()" ], "need_output", HOMALG_IO.Pictograms.NrColumns ) );
                   
                 end,
                 
               Minus :=
                 function( a, b )
                   
                   return homalgSendBlocking( [ a, " - ( ", b, " )" ], "need_output", HOMALG_IO.Pictograms.Minus );
                   
                 end,
                 
        )
 );
