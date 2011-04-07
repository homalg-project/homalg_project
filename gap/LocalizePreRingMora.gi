##
InstallValue( CommonHomalgTableForSingularBasicMoraPreRing,
        
        rec(
               
               BasisOfRowsCoeff :=
                 function( M, T )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( "unknown_number_of_rows", NrColumns( M ), R );
                   
                   homalgSendBlocking( [ "list l=BasisOfRowsCoeffMora(", M, "); matrix ", N, " = l[1]; matrix ", T, " = l[2]" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
                   T!.Denominator := HomalgRingElement( homalgSendBlocking( [ "l[3]" ], [ "poly" ], R, HOMALG_IO.Pictograms.BasisCoeff ), R );
                   
                   return N;
                   
                 end,
               
               BasisOfColumnsCoeff :=
                 function( M, T )
                   local R, N;
                   
                   R := HomalgRing( M );
                   
                   N := HomalgVoidMatrix( NrRows( M ), "unknown_number_of_columns", R );
                   
                   homalgSendBlocking( [ "list l=BasisOfColumnsCoeffMora(", M, "); matrix ", N, " = l[1]; matrix ", T, " = l[2]" ], "need_command", HOMALG_IO.Pictograms.BasisCoeff );
                   
                   T!.Denominator := HomalgRingElement( homalgSendBlocking( [ "l[3]" ], [ "poly" ], R, HOMALG_IO.Pictograms.BasisCoeff ), R );
                   
                   return N;
                   
                 end,
               
               DecideZeroRows :=
                 function( A, B )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ "list l = DecideZeroRowsMora(", A , B , "); matrix ", N, "=l[1]" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
                   
                   N!.Denominator := HomalgRingElement( homalgSendBlocking( [ "l[2]" ], [ "poly" ], R, HOMALG_IO.Pictograms.BasisCoeff ), R );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumns :=
                 function( A, B )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ "list l = DecideZeroColumnsMora(",  A , B , "); matrix ", N, "=l[1]" ], "need_command", HOMALG_IO.Pictograms.DecideZero );
                   
                   N!.Denominator := HomalgRingElement( homalgSendBlocking( [ "l[2]" ], [ "poly" ], R, HOMALG_IO.Pictograms.BasisCoeff ), R );
                   
                   return N;
                   
                 end,
               
               DecideZeroRowsEffectively :=
                 function( A, B, T )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ "list l=DecideZeroRowsEffectivelyMora(", A , B , "); matrix ", N, " = l[1]; matrix ", T, " = l[3]" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   N!.Denominator := HomalgRingElement( homalgSendBlocking( [ "l[2]" ], [ "poly" ], R, HOMALG_IO.Pictograms.BasisCoeff ), R );
                   
                   T!.Denominator := HomalgRingElement( homalgSendBlocking( [ "l[2]" ], [ "poly" ], R, HOMALG_IO.Pictograms.BasisCoeff ), R );
                   
                   return N;
                   
                 end,
               
               DecideZeroColumnsEffectively :=
                 function( A, B, T )
                   local R, N;
                   
                   R := HomalgRing( A );
                   
                   N := HomalgVoidMatrix( NrRows( A ), NrColumns( A ), R );
                   
                   homalgSendBlocking( [ "list l=DecideZeroColumnsEffectivelyMora(", A , B , "); matrix ", N, " = l[1]; matrix ", T, " = l[3]" ], "need_command", HOMALG_IO.Pictograms.DecideZeroEffectively );
                   
                   N!.Denominator := HomalgRingElement( homalgSendBlocking( [ "l[2]" ], [ "poly" ], R, HOMALG_IO.Pictograms.BasisCoeff ), R );
                   
                   T!.Denominator := HomalgRingElement( homalgSendBlocking( [ "l[2]" ], [ "poly" ], R, HOMALG_IO.Pictograms.BasisCoeff ), R );
                   
                   return N;
                   
                 end,
               
        )
 );

#this table will be copied from LocalizeRingForHomalg, so the ValueGlobals are justified
InstallValue( CommonHomalgTableForSingularToolsMoraPreRing,
        
        rec(
               
               GetColumnIndependentUnitPositions :=
                 function( M, pos_list )
                   local list;
                   
                   if pos_list = [ ] then
                     list := [ 0 ];
                   else
                     Error( "a non-empty second argument is not supported in Singular yet: ", pos_list, "\n" );
                     list := pos_list;
                   fi;
                    
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositionsMora(", ValueGlobal( "Numerator" )( M ), ", list (", list, "))" ], "need_output", HOMALG_IO.Pictograms.GetColumnIndependentUnitPositions ) );
                   
                 end,
               
               GetRowIndependentUnitPositions :=
                 function( M, pos_list )
                   local list, pos;
                   
                   if pos_list = [ ] then
                     list := [ 0 ];
                   else
                     Error( "a non-empty second argument is not supported in Singular yet: ", pos_list, "\n" );
                     list := pos_list;
                   fi;
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositionsMora(", ValueGlobal( "Numerator" )( M ), ", list (", list, "))" ], "need_output", HOMALG_IO.Pictograms.GetColumnIndependentUnitPositions ) );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local l, list_string;
                   
                   if pos_list = [ ] then
                       l := [ 0 ];
                   else
                       l := pos_list;
                   fi;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPositionMora(", ValueGlobal( "Numerator" )( M ), ", list (", l, "))" ], "need_output", HOMALG_IO.Pictograms.GetUnitPosition );
                   
                   if list_string = "fail" then
                       return fail;
                   else
                       return StringToIntList( list_string );
                   fi;
                   
                 end,
               
        )
 );
 
#this table will be copied from LocalizeRingForHomalg, so the ValueGlobals are justified
InstallValue( HomalgTableForLocalizedRingsInSingularTools,

    rec(
               GetColumnIndependentUnitPositions :=
                 function( M, pos_list )
                   local list;
                   
                     if pos_list = [ ] then
                       list := [ 0 ];
                     else
                       Error( "a non-empty second argument is not supported in Singular yet: ", pos_list, "\n" );
                       list := pos_list;
                     fi;
                      
                     return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositionsLocal(", ValueGlobal( "Numerator" )( M ), ", list (", list, "), ", ValueGlobal( "GeneratorsOfMaximalLeftIdeal" )( HomalgRing( M ) ), ")" ], "need_output", HOMALG_IO.Pictograms.GetColumnIndependentUnitPositions ) );

                   
                 end,
               
               GetRowIndependentUnitPositions :=
                 function( M, pos_list )
                   local list;
                   
                     if pos_list = [ ] then
                       list := [ 0 ];
                     else
                       Error( "a non-empty second argument is not supported in Singular yet: ", pos_list, "\n" );
                       list := pos_list;
                     fi;
                   
                     return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositionsLocal(", ValueGlobal( "Numerator" )( M ), ", list (", list, "), ", ValueGlobal( "GeneratorsOfMaximalLeftIdeal" )( HomalgRing( M ) ), ")" ], "need_output", HOMALG_IO.Pictograms.GetRowIndependentUnitPositions ) );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local l, list_string;
                   
                   if pos_list = [ ] then
                       l := [ 0 ];
                   else
                       l := pos_list;
                   fi;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPositionLocal(", ValueGlobal( "Numerator" )( M ), ", list (", l, "), ", ValueGlobal( "GeneratorsOfMaximalLeftIdeal" )( HomalgRing( M ) ), ")" ], "need_output", HOMALG_IO.Pictograms.GetUnitPosition );
                   
                   if list_string = "fail" then
                       return fail;
                   else
                       return StringToIntList( list_string );
                   fi;
                   
                 end,
        )
 );
