#############################################################################
##
##  SageTools.gi              RingsForHomalg package           Simon Görtzen
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

InstallValue( InitializeSageTools,
        
        function( R )
          local command;
          command := Concatenation(

            "def ZeroRows(C):\n",
            "  def check_rows(i):\n",
            "    return RowChecklist[i]\n",
            "  RowChecklist=[C.row(x).is_zero() for x in range(C.nrows())]\n",
            "  return filter(check_rows,range(C.nrows()))\n\n",
            
            "def ZeroColumns(C):\n",
            "  def check_cols(i):\n",
            "    return ColChecklist[i]\n",
            "  ColChecklist=[C.column(x).is_zero() for x in range(C.ncols())]\n",
            "  return filter(check_cols,range(C.ncols()))\n\n"
            
          );
            
          HomalgSendBlocking( [ command ], "need_command", R );

        end
);

InstallValue( CommonHomalgTableForSageTools,
        
        rec(
               ZeroRows :=
                 function( C )
                   return StringToIntList( HomalgSendBlocking( [ "ZeroRows(", C, ")" ], "need_output" ) ) + 1;
                 end,
               
               ZeroColumns :=
                 function( C )
                   return StringToIntList( HomalgSendBlocking( [ "ZeroColumns(", C, ")" ], "need_output" ) ) + 1;
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
                   
                   return HomalgSendBlocking( [ "matrix(", HomalgRing( C ), NrRows( C ), NrColumns( C ), ", sparse=True)" ] );
                   
                 end,
               
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing( C );
                   
                   return HomalgSendBlocking( [ "_id.sparse_matrix(); _id=0" ], [ "_id = identity_matrix(", R, NrRows( C ), ");" ], R );
                   
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
