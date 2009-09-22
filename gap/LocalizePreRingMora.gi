InstallValue( CommonHomalgTableForSingularBasicMoraPreRing,
        
        rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               BasisOfRowModule :=
                 function( M )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), AssociatedComputationRing( R ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = BasisOfRowModule(", Numerator( M ), ")" ], "need_command", HOMALG_IO.Pictograms.BasisOfModule );
                   
                   return HomalgLocalMatrix( N, R );
                   
                 end,
               
               BasisOfColumnModule :=
                 function( M )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", AssociatedComputationRing( R ) );
                   
                   homalgSendBlocking( [ "matrix ", N, " = BasisOfColumnModule(", Numerator( M ), ")" ],  "need_command", HOMALG_IO.Pictograms.BasisOfModule );
                   
                   return HomalgLocalMatrix( N, R );
                   
                 end,
               
               BasisOfRowsCoeff :=
                 function( M, T )
                   local R, NN, TT, uN, uT, N;
                   
                   R := HomalgRing( M );
                   
                   NN := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), AssociatedComputationRing( R ) );
                   
                   TT := HomalgVoidMatrix( "unknown_number_of_rows", NrRows( M ), AssociatedComputationRing( R ) );
                   
                   homalgSendBlocking( [ "l=BasisOfRowsCoeffLocal(", M, "); matrix ", NN, " = l[1]; matrix ", TT, " = l[3]" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
                   uN := homalgSendBlocking( [ "l[2]" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   uT := homalgSendBlocking( [ "l[4]" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   SetEval( [ TT, uT ], T );
                   
                   N := HomalgLocalMatrix( NN, uN * Denominator( M ), R );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, T )
                   local R, NN, TT, uN, uT, N;
                   
                   R := HomalgRing( M );
                   
                   NN := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", AssociatedComputationRing( R ) );
                   
                   TT := HomalgVoidMatrix( NrColumns( M ), "unknown_number_of_columns", AssociatedComputationRing( R ) );
                   
                   homalgSendBlocking( [ "l=BasisOfColumnCoeffLocal(", M, "); matrix ", NN, " = l[1]; matrix ", TT, " = l[3]" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
                   uN := homalgSendBlocking( [ "l[2]" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   uT := homalgSendBlocking( [ "l[4]" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   SetEval( [ TT, uT ], T );
                   
                   N := HomalgLocalMatrix( NN, uN * Denominator( M ) , R );
                   
                   return N;
                   
                 end,
               
               DecideZeroRows :=
                 function( A, B )
                   local R, cR, NN, u, N;
                   
                   R := HomalgRing( A );
                   
                   cR := AssociatedComputationRing( R );
                   
                   NN := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), AssociatedComputationRing( R ) );
                   
                   homalgSendBlocking( [ "list l = DecideZeroRowsLocal(", Numerator( A ), Numerator( B ), "); matrix ", NN, "=l[1]" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
                   
                   #u := homalgSendBlocking( [ "l[2]" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   u := homalgSendBlocking( [ "l[2]" ], "return_ring_element", cR, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   N := HomalgLocalMatrix( NN, u * Denominator( A ), R );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumns :=
                 function( A, B )
                   local R, cR, NN, u, N;
                   
                   R := HomalgRing( A );
                   
                   cR := AssociatedComputationRing( R );
                   
                   NN := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), cR );
                   
                   homalgSendBlocking( [ "list l = DecideZeroColumnsLocal(", Numerator( A ), Numerator( B ), "); matrix ", NN, "=l[1]" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
                   
                   u := homalgSendBlocking( [ "l[2]" ], "return_ring_element", cR, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   N := HomalgLocalMatrix( NN, u * Denominator( A ), R );
                   
                   return N;
                   
                 end,
               
               DecideZeroRowsEffectively :=
                 function( A, B, T )
                   local R, NN, TT, uN, uT, N;
                   
                   R := HomalgRing( A );
                   
                   NN := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), AssociatedComputationRing( R ) );
                   
                   TT := HomalgVoidMatrix( "unknown_number_of_rows", "unknown_number_of_columns", AssociatedComputationRing( R ) );
                   
                   homalgSendBlocking( [ "l=DecideZeroRowsEffectivelyLocal(", Numerator( A ), Numerator( B ), "); matrix ", NN, " = l[1]; matrix ", TT, " = l[3]" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   uN := homalgSendBlocking( [ "l[2]" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   uT := homalgSendBlocking( [ "l[4]" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   SetEval( [ TT * Denominator( B ), uT ], T );
                   
                   N := HomalgLocalMatrix( NN * Denominator( B ) * Denominator( A ), uN, R );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local R, NN, TT, uN, uT, N;
                   
                   R := HomalgRing( A );
                   
                   NN := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), AssociatedComputationRing( R ) );
                   
                   TT := HomalgVoidMatrix( "unknown_number_of_rows", "unknown_number_of_columns", AssociatedComputationRing( R ) );
                   
                   homalgSendBlocking( [ "l=DecideZeroColumnsEffectivelyLocal(", Numerator( A ), Numerator( B ), "); matrix ", NN, " = l[1]; matrix ", T, " = l[3]" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   uN := homalgSendBlocking( [ "l[2]" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   uT := homalgSendBlocking( [ "l[4]" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
#                    SetEval( [ TT * Denominator( B ), uT ], T );
                   
                   N := HomalgLocalMatrix( NN * Denominator( B ) * Denominator( A ), uN, R );
                   
                   return N;
                   
                 end,
               
               SyzygiesGeneratorsOfRows :=
                 function( arg )
                   local M, R, N, M2;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrRows( M ), AssociatedComputationRing( R ) );
                   
                   if Length( arg ) > 1 and IsHomalgMatrix( arg[2] ) then
                       
                       M2 := arg[2];
                       
                       homalgSendBlocking( [ "matrix ", N, " = SyzygiesGeneratorsOfRows2(", Numerator( M ), Numerator( M2 ), ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                       
                   else
                       
                       homalgSendBlocking( [ "matrix ", N, " = SyzygiesGeneratorsOfRows(", Numerator( M ), ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                       
                   fi;
                   
                   return HomalgLocalMatrix( N , R );
                   
                 end,
               
               SyzygiesGeneratorsOfColumns :=
                 function( arg )
                   local M, R, N, M2;
                   
                   M := arg[1];
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NrColumns( M ), "unknown_number_of_columns", AssociatedComputationRing( R ) );
                   
                   if Length( arg ) > 1 and IsHomalgMatrix( arg[2] ) then
                       
                       M2 := arg[2];
                       
                       homalgSendBlocking( [ "matrix ", N, " = SyzygiesGeneratorsOfColumns2(", Numerator( M ), Numerator( M2 ), ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                       
                   else
                       
                       homalgSendBlocking( [ "matrix ", N, " = SyzygiesGeneratorsOfColumns(", Numerator( M ), ")" ], "need_command", HOMALG_IO.Pictograms.SyzygiesGenerators );
                       
                   fi;
                   
                   return HomalgLocalMatrix( N , R );
                   
                 end,
               
        )
 );