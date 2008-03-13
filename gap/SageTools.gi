#############################################################################
##
##  SageTools.gi                sage rings for homalg          Simon Görtzen
##
##  Copyright 2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
## Implementations for the rings provided by sage.
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
                   local R, list_string;
                   
                   R := HomalgRing( C );
                   
                   HomalgSendBlocking( [ "Checklist=[", C, ".row(x).is_zero() for x in range(", NrRows( C ), ")]" ], "need_command" );
                   HomalgSendBlocking( [ "def check(i):\n  return Checklist[i]\n\n" ], "need_command", R );
                   list_string := HomalgSendBlocking( [ "filter(check,range(", NrRows( C ), "))" ], "need_output", R );
                   list_string := StringToIntList( list_string );
                   return list_string + 1;
                   
                 end,
               
               ZeroColumns :=
                 function( C )
                   local R, list_string;
                   
                   R := HomalgRing( C );
                   
                   HomalgSendBlocking( [ "Checklist=[", C, ".column(x).is_zero() for x in range(", NrColumns( C ), ")]" ], "need_command" );
                   HomalgSendBlocking( [ "def check(i):\n  return Checklist[i]\n\n" ], "need_command", R );
                   list_string := HomalgSendBlocking( [ "filter(check,range(", NrColumns( C ), "))" ], "need_output", R );
                   list_string := StringToIntList( list_string );
                   return list_string + 1;
                   
                 end,
       
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               True := "True",
               
               Zero := HomalgExternalRingElement( "0", "Sage", IsZero ),
               
               One := HomalgExternalRingElement( "1", "Sage", IsOne ),
               
               MinusOne := HomalgExternalRingElement( "(-1)", "Sage" ),
               
               Equal :=
                 function( A, B )
                 
                   return HomalgSendBlocking( [ A, "==", B ], "need_output" ) = "True";
                 
                 end,
               
               ZeroMatrix :=
                 function( C )
                   
                   return HomalgSendBlocking( [ "matrix(", HomalgRing(C), NrRows( C ), NrColumns( C ), ", sparse=True)" ] );
                   
                 end,
             
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   HomalgSendBlocking( [ "_id = identity_matrix(", R, NrRows( C ), ")" ], "need_command" );
                   return HomalgSendBlocking( [ "_id.sparse_matrix()" ], R );
                   
                 end,
               
               Involution :=
                 function( M )
                   
                   return HomalgSendBlocking( [ M, ".transpose()" ] );
                   
                 end,
               
               CertainRows :=
                 function( M, plist )
                   
                   plist := plist - 1;
                   return HomalgSendBlocking( [ M, ".matrix_from_rows(", plist, ")"] );
                   
                 end,
               
               CertainColumns :=
                 function( M, plist )
                   
                   plist := plist - 1;
                   return HomalgSendBlocking( [ M, ".matrix_from_columns(", plist, ")" ] );
                   
                 end,
               
               UnionOfRows :=
                 function( A, B )
                   
                   return HomalgSendBlocking( [ "block_matrix([", A, B, "],2)" ] );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B )
                   
                   return HomalgSendBlocking( [ "block_matrix([", A, B, "],1)" ] );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := ShallowCopy( e );
                   Add( f, "block_diagonal_matrix(", 1 );
                   Add( f, ")" );
                   return HomalgSendBlocking( f );
                   
                 end,
               
               MulMat :=
                 function( a, A )
                   
                   return HomalgSendBlocking( [a, "*", A] );
                   
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
                   
                   return Int( HomalgSendBlocking( [ C, ".nrows()" ], "need_output" ) );
                   
                 end,
               
               NrColumns :=
                 function( C )
                   
                   return Int( HomalgSendBlocking( [ C, ".ncols()" ], "need_output" ) );
                   
                 end
               
        )
 );
