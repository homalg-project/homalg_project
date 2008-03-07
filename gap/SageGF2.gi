#############################################################################
##
##  SageGF2.gi                  homalg package                 Simon Görtzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The finite Sage field GF(2) with 2 Elements
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
               "for finite Sage field GF(2) with 2 Elements",
               [ IsHomalgExternalObjectRep and IsHomalgExternalObjectWithIOStream and IsSageGF2 ],

  function( arg )
    local RP;

    RP := rec( 
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (HomalgTable gives no default value)
               
               RingName := "GF(2)",
               
               ## Must be defined if other functions are not defined
               
               TriangularBasisOfRows :=
                 function( arg )
                   local M, R, nargs, N, rank_of_N, U;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   nargs := Length( arg );
                   
                   if nargs > 1 then
                       ## compute N and U: N = U*M, create M|Id_NrRows(N) and do Gauss there
                       HomalgSendBlocking( [ "_Id = identity_matrix(GF(2),", NrRows(M), ").sparse_matrix()" ], "need_command", R );
                       HomalgSendBlocking( [ "_MId = block_matrix([", M, ".sparse_matrix(),_Id],2).echelonize()" ], "need_command" );
                       HomalgSendBlocking( [ "_N=_MId.matrix_from_columns(range(", NrColumns(M) ,"))"], "need_command", R );
                       rank_of_N := Int( HomalgSendBlocking( [ "_N.rank()" ], "need_output", R ) );
                       N := HomalgSendBlocking( [ "_N.copy()"], R );
                       U := HomalgSendBlocking( [ "_MId.matrix_from_columns(range(", NrColumns(M), ",", NrColumns(M)+NrRows(M), ")).copy()"], R );
                       #HomalgSendBlocking( [ "_N=0; _MId=0" ], "need_command", R);
                   else
                       ## compute N only:
                       HomalgSendBlocking( [ "_N = ", M, ".echelon_form()" ], "need_command" );
                       HomalgSendBlocking( [ "_N = _N.sparse_matrix()" ], "need_command", R );
                       rank_of_N := Int( HomalgSendBlocking( [ "_N.rank()" ], "need_output", R ) );
                       N := HomalgSendBlocking( [ "_N" ], R );
                       HomalgSendBlocking( [ "_N=0;" ], "need_command", R );
                   fi;
                   
                   # assign U:
                   if nargs > 1 and IsHomalgMatrix( arg[2] ) then ## not TriangularBasisOfRows( M, "" )
                       SetEval( arg[2], U );
                       SetNrRows( arg[2], NrRows( M ) );
                       SetNrColumns( arg[2], NrRows( M ) );
                       SetIsFullRowRankMatrix( arg[2], true );
                       SetIsFullColumnRankMatrix( arg[2], true );
                   fi;
                   
                   N := MatrixForHomalg( N, R );
                   
                   SetNrRows( N, NrRows( M ) );
                   SetNrColumns( N, NrColumns( M ) );
                   SetRowRankOfMatrix( N, rank_of_N );
                   
                   if HasIsDiagonalMatrix( M ) and IsDiagonalMatrix( M ) then
                       SetIsDiagonalMatrix( N, true );
                   else
                       SetIsUpperTriangularMatrix( N, true );
                   fi;
                   
                   return N;
                   
                 end,
               
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
                   
               True := "True",
               
               Zero := HomalgExternalObject( "0", "Sage" ),
               
               One := HomalgExternalObject( "1", "Sage" ),
               
               MinusOne := HomalgExternalObject( "1", "Sage" ),
               
               Equal :=
                 function( A, B )
                 
                   return HomalgSendBlocking( [ A, "==", B ], "need_ouput" );
                 
                 end,
               
               ZeroMatrix :=
                 function( C )
                   
                   return HomalgSendBlocking( [ "matrix(GF(2),", NrRows(C), ",",  NrColumns(C), ", sparse=True)" ], HomalgRing(C) );
                   
                 end,
             
               IdentityMatrix :=
                 function( C )
                   local R;
                   
                   R := HomalgRing(C);
                   
                   return HomalgSendBlocking( [ "_id = identity_matrix(GF(2),", NrRows(C), ").sparse_matrix()" ], R );
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
                 function( A, B)
                   
                   return HomalgSendBlocking( [ "block_matrix([", A, B, "],2)" ] );
                   
                 end,
               
               UnionOfColumns :=
                 function( A, B)
                   
                   return HomalgSendBlocking( [ "block_matrix([", A, B, "],1)" ] );
                   
                 end,
               
               DiagMat :=
                 function( e )
                   local f;
                   
                   f := ShallowCopy( e );
                   Add( f, "block_diagonal_matrix(" ,1 );
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
                   
                 end,
               
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
                   
                 end
       
          );
    
    Objectify( HomalgTableType, RP );
    
    return RP;
    
end );
