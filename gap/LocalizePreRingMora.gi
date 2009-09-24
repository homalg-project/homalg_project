InstallValue( CommonHomalgTableForSingularBasicMoraPreRing,
        
        rec(
               
               BasisOfRowsCoeff :=
                 function( M, T )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), R );
                   
                   homalgSendBlocking( [ "l=BasisOfRowsCoeffLocal(", M, "); matrix ", N, " = l[1]; matrix ", T, " = l[2]" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
                   N!.Denominator := homalgSendBlocking( [ "l[3]" ], [ "poly" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, T )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", R );
                   
                   homalgSendBlocking( [ "l=BasisOfColumnsCoeffLocal(", M, "); matrix ", N, " = l[1]; matrix ", T, " = l[2]" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
                   N!.Denominator := homalgSendBlocking( [ "l[3]" ], [ "poly" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   return N;
                   
                 end,
               
               DecideZeroRows :=
                 function( A, B )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ "list l = DecideZeroRowsLocal(", A , B , "); matrix ", N, "=l[1]" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
                   
                   N!.Denominator := homalgSendBlocking( [ "l[2]" ], [ "poly" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumns :=
                 function( A, B )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ "list l = DecideZeroColumnsLocal(",  A , B , "); matrix ", N, "=l[1]" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
                   
                   N!.Denominator := homalgSendBlocking( [ "l[2]" ], [ "poly" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   return N;
                   
                 end,
               
               DecideZeroRowsEffectively :=
                 function( A, B, T )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ "l=DecideZeroRowsEffectivelyLocal(", A , B , "); matrix ", N, " = l[1]; matrix ", T, " = l[3]" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   N!.Denominator := homalgSendBlocking( [ "l[2]" ], [ "poly" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   T!.Denominator := homalgSendBlocking( [ "l[2]" ], [ "poly" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ "l=DecideZeroColumnsEffectivelyLocal(", A , B , "); matrix ", N, " = l[1]; matrix ", T, " = l[3]" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   N!.Denominator := homalgSendBlocking( [ "l[2]" ], [ "poly" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   T!.Denominator := homalgSendBlocking( [ "l[2]" ], [ "poly" ], "return_ring_element", R, HOMALG_IO.Pictograms.BasisCoeff );
                   
                   return N;
                   
                 end,
               
        )
 );