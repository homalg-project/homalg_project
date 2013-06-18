#############################################################################
##
##  SingularTools.gi                           LocalizeRingForHomalg package
##
##  Copyright 2009-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for the rings provided by Singular.
##
#############################################################################

####################################
#
# global variables:
#
####################################

##
InstallValue( LocalizeRingMacrosForSingular,
        rec(
            
    _CAS_name := "Singular",
    
    _Identifier := "LocalizeRingForHomalg",
    
    GetColumnIndependentUnitPositionsLocal := "\n\
proc GetColumnIndependentUnitPositionsLocal (matrix M, list pos_list, matrix max_ideal)\n\
{\n\
  int m = nrows(M);\n\
  int n = ncols(M);\n\
  \n\
  list rest;\n\
  for (int o=m; o>=1; o--)\n\
  {\n\
    rest[o] = o;\n\
  }\n\
  int r = m;\n\
  list e;\n\
  list rest2;\n\
  list pos;\n\
  int i; int k; int a; int s = 1;\n\
  \n\
  for (int j=1; j<=n; j++)\n\
  {\n\
    for (i=1; i<=r; i++)\n\
    {\n\
      k = rest[r-i+1];\n\
      if (reduce(M[k,j],max_ideal) != 0) //IsUnit\n\
      {\n\
        rest2 = e;\n\
        pos[s] = list(j,k); s++;\n\
        for (a=1; a<=r; a++)\n\
        {\n\
          if (M[rest[a],j] == 0)\n\
          {\n\
            rest2[size(rest2)+1] = rest[a];\n\
          }\n\
        }\n\
        rest = rest2;\n\
        r = size(rest);\n\
        break;\n\
      }\n\
    }\n\
  }\n\
  return(string(pos));\n\
}\n\n",
    
    GetRowIndependentUnitPositionsLocal := "\n\
proc GetRowIndependentUnitPositionsLocal (matrix M, list pos_list, matrix max_ideal)\n\
{\n\
  int m = nrows(M);\n\
  int n = ncols(M);\n\
  \n\
  list rest;\n\
  for (int o=n; o>=1; o--)\n\
  {\n\
    rest[o] = o;\n\
  }\n\
  int r = n;\n\
  list e;\n\
  list rest2;\n\
  list pos;\n\
  int j; int k; int a; int s = 1;\n\
  \n\
  for (int i=1; i<=m; i++)\n\
  {\n\
    for (j=1; j<=r; j++)\n\
    {\n\
      k = rest[r-j+1];\n\
      if (reduce(M[i,k],max_ideal) != 0) //IsUnit\n\
      {\n\
        rest2 = e;\n\
        pos[s] = list(i,k); s++;\n\
        for (a=1; a<=r; a++)\n\
        {\n\
          if (M[i,rest[a]] == 0)\n\
          {\n\
            rest2[size(rest2)+1] = rest[a];\n\
          }\n\
        }\n\
        rest = rest2;\n\
        r = size(rest);\n\
        break;\n\
      }\n\
    }\n\
  }\n\
  return(string(pos));\n\
}\n\n",
    
    GetUnitPositionLocal := "\n\
proc GetUnitPositionLocal (matrix M, list pos_list, matrix max_ideal)\n\
{\n\
  int m = nrows(M);\n\
  int n = ncols(M);\n\
  int r;\n\
  list rest;\n\
  for (int o=m; o>=1; o--)\n\
  {\n\
    rest[o] = o;\n\
  }\n\
  rest=Difference(rest,pos_list);\n\
  r=size(rest);\n\
  for (int j=1; j<=n; j++)\n\
  {\n\
    for (int i=1; i<=r; i++)\n\
    {\n\
      if (reduce(M[rest[i],j],max_ideal) != 0) //IsUnit\n\
      {\n\
        return(string(j,\",\",rest[i])); // this is not a mistake\n\
      }\n\
    }\n\
  }\n\
  return(\"fail\");\n\
}\n\n",
    
    )

);

##
InstallValue( LocalizeRingWithMoraMacrosForSingular,
        rec(
            
    _CAS_name := "Singular",
    
    _Identifier := "LocalizeRingForHomalg (Mora)",
    
#trying something local
# division(A^t,B^t) returns (TT^t, M^t, U^t) with
#                A^t*U^t = B^t*TT^t + M^t
# <=> (ignore U) M^t = A^t*U^t - B^t*TT^tr
# <=>            M   = u*A     + (-TT) * B
# <=> (T:=-TT)   M   = U*A     + T * B
# <=>         U^-1 M = A       + U^-1 * T * B
#here U should be made into a scalar matrix by changing M and T (lcm computation etc.)

#remark: in
#list l = l2[1],l2[2],l3[1],l3[2];
#the values l2[2] and l3[2] should be the same
#here are also some workarounds for Singular bugs
#U is filled with a zero at the diagonal, when we reduce zero. we may replace this zero with any unit, so for smaller somputations we choose 1.
#And division does not allway compute l[2] correctly, so we use the relation between the input and output of division to compute l[2] correctly.
    DecideZeroRowsEffectivelyMora := "\n\
proc DecideZeroRowsEffectivelyMora (matrix A, matrix B)\n\
{\n\
  list l = division(A,B);\n\
  matrix U=l[3];\n\
  for (int i=1; i<=ncols(U); i++)\n\
  {\n\
    if(U[i,i]==0){U[i,i]=1;};\n\
  }\n\
  l[3]=U;\n\
  l[2] = A * l[3] - B * l[1];\n\
  list l2 = CreateInputForLocalMatrixRows(l[2],l[3]);\n\
  list l3 = CreateInputForLocalMatrixRows(-l[1],l[3]);\n\
  list l = l2[1],l2[2],l3[1],l3[2];\n\
  return(l);\n\
}\n\n",
    
    DecideZeroColumnsEffectivelyMora := "\n\
proc DecideZeroColumnsEffectivelyMora (matrix A, matrix B)\n\
{\n\
  list l = DecideZeroRowsEffectivelyMora(Involution(A),Involution(B));\n\
  matrix B = l[1];\n\
  matrix T = l[3];\n\
  l = Involution(B),l[2],Involution(T),l[4];\n\
  return(l);\n\
}\n\n",
    
    DecideZeroRowsMora := "\n\
proc DecideZeroRowsMora (matrix A, matrix B)\n\
{\n\
  list l=DecideZeroRowsEffectivelyMora(A,B);\n\
  l=l[1],l[2];\n\
  return(l);\n\
}\n\n",
    
    DecideZeroColumnsMora := "\n\
proc DecideZeroColumnsMora (matrix A, matrix B)\n\
{\n\
  list l=DecideZeroColumnsEffectivelyMora(A,B);\n\
  l=l[1],l[2];\n\
  return(l);\n\
}\n\n",
    
    BasisOfRowsCoeffMora := "\n\
proc BasisOfRowsCoeffMora (matrix M)\n\
{\n\
  matrix B = BasisOfRowModule(M);\n\
  matrix U;\n\
  matrix T = lift(M,B,U); //never use stdlift, also because it might differ from std!!!\n\
  list l = CreateInputForLocalMatrixRows(T,U);\n\
  l = B,l[1],l[2];\n\
  return(l)\n\
}\n\n",
    
    BasisOfColumnsCoeffMora := "\n\
proc BasisOfColumnsCoeffMora (matrix M)\n\
{\n\
  list l = BasisOfRowsCoeffMora(Involution(M));\n\
  matrix B = l[1];\n\
  matrix T = l[2];\n\
  l = Involution(B),Involution(T),l[3];\n\
  return(l);\n\
}\n\n",
    
## A * U^-1 -> u^-1 A2
#above code should allready have caught this, but still: U is filled with a zero at the diagonal, when we reduce zero. we may replace this zero with any unit, so for smaller somputations we choose 1.
    
    CreateInputForLocalMatrixRows := "\n\
ring r= 0,(x),ds;\n\
matrix M[2][2]=[1,0,0,0];\n\
matrix NN[2][1]=[1,0];\n\
module N=std(NN);\n\
list l=division(M,N);\n\
if( l[3][2,2]==0 ) // this is a workaround for a bug in the 64 bit versions of Singular 3-1-0\n\
{ proc CreateInputForLocalMatrixRows (matrix A, matrix U)\n\
  {\n\
    poly u=1;\n\
    matrix A2=A;\n\
    for (int i=1; i<=ncols(U); i++)\n\
    {\n\
      if(U[i,i]!=0){u=lcm(u,U[i,i]);};\n\
    }\n\
    for (int i=1; i<=ncols(U); i++)\n\
    {\n\
      if(U[i,i]==0){\n\
        poly gg=1;\n\
      } else {\n\
        poly uu=U[i,i];\n\
        poly gg=u/uu;\n\
      };\n\
      if(gg!=1)\n\
      {\n\
        for(int k=1;k<=nrows(A2);k++){A2[k,i]=A2[k,i]*gg;};\n\
      }\n\
    }\n\
    list l=A2,u;\n\
    return(l);\n\
  }\n\
}\n\
else\n\
{ proc CreateInputForLocalMatrixRows (matrix A, matrix U)\n\
  {\n\
    poly u=1;\n\
    matrix A2=A;\n\
    for (int i=1; i<=ncols(U); i++)\n\
    {\n\
      u=lcm(u,U[i,i]);\n\
    }\n\
    for (int i=1; i<=ncols(U); i++)\n\
    {\n\
      poly uu=U[i,i];\n\
      poly gg=u/uu;\n\
      if(gg!=1)\n\
      {\n\
        for(int k=1;k<=nrows(A2);k++){A2[k,i]=A2[k,i]*gg;};\n\
      }\n\
    }\n\
    list l=A2,u;\n\
    return(l);\n\
  }\n\
}\n\
kill r;",
    
    GetColumnIndependentUnitPositionsMora := "\n\
proc GetColumnIndependentUnitPositionsMora (matrix M, list pos_list)\n\
{\n\
  int m = nrows(M);\n\
  int n = ncols(M);\n\
  \n\
  list rest;\n\
  for (int o=m; o>=1; o--)\n\
  {\n\
    rest[o] = o;\n\
  }\n\
  int r = m;\n\
  list e;\n\
  list rest2;\n\
  list pos;\n\
  int i; int k; int a; int s = 1;\n\
  \n\
  for (int j=1; j<=n; j++)\n\
  {\n\
    for (i=1; i<=r; i++)\n\
    {\n\
      k = rest[r-i+1];\n\
      if (deg(leadmonom(M[k,j])) == 0) //IsUnit\n\
      {\n\
        rest2 = e;\n\
        pos[s] = list(j,k); s++;\n\
        for (a=1; a<=r; a++)\n\
        {\n\
          if (M[rest[a],j] == 0)\n\
          {\n\
            rest2[size(rest2)+1] = rest[a];\n\
          }\n\
        }\n\
        rest = rest2;\n\
        r = size(rest);\n\
        break;\n\
      }\n\
    }\n\
  }\n\
  return(string(pos));\n\
}\n\n",
    
    GetRowIndependentUnitPositionsMora := "\n\
proc GetRowIndependentUnitPositionsMora (matrix M, list pos_list)\n\
{\n\
  int m = nrows(M);\n\
  int n = ncols(M);\n\
  \n\
  list rest;\n\
  for (int o=n; o>=1; o--)\n\
  {\n\
    rest[o] = o;\n\
  }\n\
  int r = n;\n\
  list e;\n\
  list rest2;\n\
  list pos;\n\
  int j; int k; int a; int s = 1;\n\
  \n\
  for (int i=1; i<=m; i++)\n\
  {\n\
    for (j=1; j<=r; j++)\n\
    {\n\
      k = rest[r-j+1];\n\
      if (deg(leadmonom(M[i,k])) == 0) //IsUnit\n\
      {\n\
        rest2 = e;\n\
        pos[s] = list(i,k); s++;\n\
        for (a=1; a<=r; a++)\n\
        {\n\
          if (M[i,rest[a]] == 0)\n\
          {\n\
            rest2[size(rest2)+1] = rest[a];\n\
          }\n\
        }\n\
        rest = rest2;\n\
        r = size(rest);\n\
        break;\n\
      }\n\
    }\n\
  }\n\
  return(string(pos));\n\
}\n\n",
    
    GetUnitPositionMora := "\n\
proc GetUnitPositionMora (matrix M, list pos_list)\n\
{\n\
  int m = nrows(M);\n\
  int n = ncols(M);\n\
  int r;\n\
  list rest;\n\
  for (int o=m; o>=1; o--)\n\
  {\n\
    rest[o] = o;\n\
  }\n\
  rest=Difference(rest,pos_list);\n\
  r=size(rest);\n\
  for (int j=1; j<=n; j++)\n\
  {\n\
    for (int i=1; i<=r; i++)\n\
    {\n\
      if (deg(leadmonom(M[rest[i],j])) == 0) //IsUnit\n\
      {\n\
        return(string(j,\",\",rest[i])); // this is not a mistake\n\
      }\n\
    }\n\
  }\n\
  return(\"fail\");\n\
}\n\n",
    
    )

);

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

##
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
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositionsMora(", Numerator( M ), ", list (", list, "))" ], "need_output", HOMALG_IO.Pictograms.GetColumnIndependentUnitPositions ) );
                   
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
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositionsMora(", Numerator( M ), ", list (", list, "))" ], "need_output", HOMALG_IO.Pictograms.GetColumnIndependentUnitPositions ) );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local l, list_string;
                   
                   if pos_list = [ ] then
                       l := [ 0 ];
                   else
                       l := pos_list;
                   fi;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPositionMora(", Numerator( M ), ", list (", l, "))" ], "need_output", HOMALG_IO.Pictograms.GetUnitPosition );
                   
                   if list_string = "fail" then
                       return fail;
                   else
                       return StringToIntList( list_string );
                   fi;
                   
                 end,
               
        )
);

##
InstallValue( HomalgTableForLocalizedRingsForSingularTools,

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
                      
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetColumnIndependentUnitPositionsLocal(", Numerator( M ), ", list (", list, "), ", GeneratorsOfMaximalLeftIdeal( HomalgRing( M ) ), ")" ], "need_output", HOMALG_IO.Pictograms.GetColumnIndependentUnitPositions ) );
                   
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
                   
                   return StringToDoubleIntList( homalgSendBlocking( [ "GetRowIndependentUnitPositionsLocal(", Numerator( M ), ", list (", list, "), ", GeneratorsOfMaximalLeftIdeal( HomalgRing( M ) ), ")" ], "need_output", HOMALG_IO.Pictograms.GetRowIndependentUnitPositions ) );
                   
                 end,
               
               GetUnitPosition :=
                 function( M, pos_list )
                   local l, list_string;
                   
                   if pos_list = [ ] then
                       l := [ 0 ];
                   else
                       l := pos_list;
                   fi;
                   
                   list_string := homalgSendBlocking( [ "GetUnitPositionLocal(", Numerator( M ), ", list (", l, "), ", GeneratorsOfMaximalLeftIdeal( HomalgRing( M ) ), ")" ], "need_output", HOMALG_IO.Pictograms.GetUnitPosition );
                   
                   if list_string = "fail" then
                       return fail;
                   else
                       return StringToIntList( list_string );
                   fi;
                   
                 end,
        )
);

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( _LocalizePolynomialRingAtZeroWithMora,
        "for homalg rings in Singular",
        [ IsHomalgRing and IsFreePolynomialRing ],
        
  function( globalR )
    local var, properties, ext_obj, S, RP;
    
    if LoadPackage( "RingsForHomalg" ) <> true then
        Error( "the package RingsForHomalg failed to load\n" );
    fi;
    
    if not ValueGlobal( "IsHomalgExternalRingInSingularRep" )( globalR ) then
        TryNextMethod( );
    fi;
    
    if not IsBoundGlobal( "TheTypePreHomalgExternalRingInSingular" ) then
        BindGlobal( "TheTypePreHomalgExternalRingInSingular",
                NewType( TheFamilyOfHomalgRings,
                        IsPreHomalgRing and ValueGlobal( "IsHomalgExternalRingInSingularRep" ) ) );
    fi;
    
    #check whether base ring is polynomial and then extract needed data
    if HasIndeterminatesOfPolynomialRing( globalR ) and IsCommutative( globalR ) then
        var := IndeterminatesOfPolynomialRing( globalR );
    else
        Error( "base ring is not a polynomial ring" );
    fi;
    
    UpdateMacrosOfLaunchedCAS( LocalizeRingWithMoraMacrosForSingular, homalgStream( globalR ) );
    
    properties := [ IsCommutative, IsLocal ];
    
    if Length( var ) <= 1 then
        Add( properties, IsPrincipalIdealRing );
    fi;
    
    var := List( var, String );
    
    ## create the new ring
    ext_obj := homalgSendBlocking( [ Characteristic( globalR ), ",(", var, "),ds" ] , [ "ring" ], globalR, properties, ValueGlobal( "TheTypeHomalgExternalRingObjectInSingular" ), HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgExternalRing( ext_obj, ValueGlobal( "TheTypePreHomalgExternalRingInSingular" ) );
    
    SetIndeterminatesOfPolynomialRing( S, List( var, v -> v / S ) );
    
    ValueGlobal( "_Singular_SetRing" )( S );
    
    RP := homalgTable( S );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( "\nproc Involution (matrix m)\n{\n  return(transpose(m));\n}\n\n", "need_command", R, HOMALG_IO.Pictograms.define );
    end;
    
    RP!.SetInvolution( S );
    
    AppendToAhomalgTable( RP, CommonHomalgTableForSingularBasicMoraPreRing );
    
    return S;
    
end );

