#############################################################################
##
##  Singular.gi               RingsForHomalg package         Mohamed Barakat
##                                                    Markus Lange-Hegermann
##                                                    
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system Singular.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_Singular,
        rec(
            cas := "singular",			## normalized name on which the user should have no control
            name := "Singular",
            executable := "Singular",
            options := [ "-t", "--echo=0", "--no-warn" ],	## the option "-q" causes IO to believe that Singular has died!
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_POS_BEGIN := 1,			## these are the most
            CUT_POS_END := 2,			## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";",
            nolistlist := true,			## a Singular specific
            break_lists := true,		## a Singular specific
            handle_output := true,		## a Singular specific
#            original_lines := true,		## a Singular specific
            check_output := true,		## a Singular specific looks for newlines without commas
            setring := _Singular_SetRing,	## a Singular specific
            setinvol := _Singular_SetInvolution,## a Singular specific
            define := "=",
            delete := function( var, stream ) homalgSendBlocking( [ "kill ", var ], "need_command", stream, HOMALG_IO.Pictograms.delete ); end,
            multiple_delete := _Singular_multiple_delete,
            prompt := "\033[01msingular>\033[0m ",
            output_prompt := "\033[1;30;43m<singular\033[0m ",
            display_color := "\033[0;30;47m",
           )
);

HOMALG_IO_Singular.READY_LENGTH := Length( HOMALG_IO_Singular.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalObjectWithIOStreamRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInSingularRep",
        IshomalgExternalObjectWithIOStreamRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInSingularRep",
        IsHomalgExternalRingRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeHomalgExternalRingObjectInSingular",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInSingularRep ) );

# two new types:
BindGlobal( "TheTypeHomalgExternalRingInSingular",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInSingularRep ) );

BindGlobal( "TheTypePreHomalgExternalRingInSingular",
        NewType( TheFamilyOfHomalgRings,
                IsPreHomalgRing and IsHomalgExternalRingInSingularRep ) );

####################################
#
# global functions and variables:
#
####################################

##
InstallGlobalFunction( _Singular_SetRing,
  function( R )
    local stream;
    
    stream := homalgStream( R );
    
    ## since _Singular_SetRing might be called from homalgSendBlocking,
    ## we first set the new active ring to avoid infinite loops:
    stream.active_ring := R;
    
    homalgSendBlocking( [ "setring ", R ], "need_command", HOMALG_IO.Pictograms.initialize );
    
    ## never use imapall here
    
end );

##
InstallGlobalFunction( _Singular_SetInvolution,
  function( R )
    local RP;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.SetInvolution ) then
        RP!.SetInvolution( R );
    fi;
    
end );

##
InstallGlobalFunction( _Singular_multiple_delete,
  function( var_list, stream )
    local str, var;
    
    str:="";
    
    for var in var_list do
      str := Concatenation( str, "kill ", String ( var ) , ";" );
    od;
    
    homalgSendBlocking( str, "need_command", stream, HOMALG_IO.Pictograms.multiple_delete );
    
end );

##
InstallValue( SingularMacros,
        rec(
            
    IsMemberOfList := "\n\
proc IsMemberOfList (int i, list l)\n\
{\n\
  int k = size(l);\n\
  \n\
  for (int p=1; p<=k; p=p+1)\n\
  {\n\
    if (l[p]==i)\n\
    {\n\
      return(1); // this is not a mistake\n\
    }\n\
  }\n\
  return(0);\n\
}\n\n",
    
    Difference := "\n\
proc Difference (list a, list b)\n\
{\n\
  list c;\n\
  int s=size(a);\n\
  \n\
  for (int p=1; p<=s; p=p+1)\n\
  {\n\
    if (IsMemberOfList(a[p],b)==0)\n\
    {\n\
      c[size(c)+1] = a[p];\n\
    }\n\
  }\n\
  return(c);\n\
}\n\n",
    
    CreateListListOfIntegers := "\n\
proc CreateListListOfIntegers (degrees,m,n)\n\
{\n\
  list l;\n\
  for (int i=1; i<=m; i=i+1)\n\
  {\n\
    l[i]=intvec(degrees[(i-1)*n+1..i*n]);\n\
  }\n\
  return(l);\n\
}\n\n",
    
    IsZeroMatrix := "\n\
proc IsZeroMatrix (matrix m)\n\
{\n\
  matrix z[nrows(m)][ncols(m)];\n\
  return(m==z);\n\
}\n\n",
    
    IsIdentityMatrix := "\n\
proc IsIdentityMatrix (matrix m)\n\
{\n\
  return(m==unitmat(nrows(m)));\n\
}\n\n",
    
    IsDiagonalMatrix := "\n\
proc IsDiagonalMatrix (matrix m)\n\
{\n\
  int min=nrows(m);\n\
  if (min>ncols(m))\n\
  {\n\
    min=ncols(m);\n\
  }\n\
  matrix z[nrows(m)][ncols(m)];\n\
  matrix c = m;\n\
  for (int i=1; i<=min; i=i+1)\n\
  {\n\
    c[i,i]=0;\n\
  }\n\
  return(c==z);\n\
}\n\n",
    
    ZeroRows := "\n\
proc ZeroRows (matrix m)\n\
{\n\
  list l;\n\
  for (int i=1;i<=ncols(m);i=i+1)\n\
  {\n\
    if (m[i]==0)\n\
    {\n\
      l[size(l)+1]=i;\n\
    }\n\
  }\n\
  if (size(l)==0)\n\
  {\n\
    return(\"[]\"));\n\
  }\n\
  return(string(l));\n\
}\n\n",
    
    ZeroColumns := "\n\
proc ZeroColumns (matrix n)\n\
{\n\
  matrix m=transpose(n);\n\
  list l;\n\
  for (int i=1;i<=ncols(m);i=i+1)\n\
  {\n\
    if (m[i]==0)\n\
    {\n\
      l[size(l)+1]=i;\n\
    }\n\
  }\n\
  if (size(l)==0)\n\
  {\n\
    return(\"[]\"));\n\
  }\n\
  return(string(l));\n\
}\n\n",
    
    GetColumnIndependentUnitPositions := "\n\
proc GetColumnIndependentUnitPositions (matrix M, list pos_list)\n\
{\n\
  int m = nrows(M);\n\
  int n = ncols(M);\n\
  \n\
  list rest;\n\
  for (int o=1; o<=m; o=o+1)\n\
  {\n\
    rest[size(rest)+1] = o;\n\
  }\n\
  int r = m;\n\
  list e;\n\
  list rest2;\n\
  list pos;\n\
  int i; int k; int a;\n\
  \n\
  for (int j=1; j<=n; j=j+1)\n\
  {\n\
    for (i=1; i<=r; i=i+1)\n\
    {\n\
      k = rest[r-i+1];\n\
      if (deg(leadmonom(M[k,j])) == 0) //IsUnit\n\
      {\n\
        rest2 = e;\n\
        pos[size(pos)+1] = list(j,k);\n\
        for (a=1; a<=r; a=a+1)\n\
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
    
    GetRowIndependentUnitPositions := "\n\
proc GetRowIndependentUnitPositions (matrix M, list pos_list)\n\
{\n\
  int m = nrows(M);\n\
  int n = ncols(M);\n\
  \n\
  list rest;\n\
  for (int o=1; o<=n; o=o+1)\n\
  {\n\
    rest[size(rest)+1] = o;\n\
  }\n\
  int r = n;\n\
  list e;\n\
  list rest2;\n\
  list pos;\n\
  int j; int k; int a;\n\
  \n\
  for (int i=1; i<=m; i=i+1)\n\
  {\n\
    for (j=1; j<=r; j=j+1)\n\
    {\n\
      k = rest[r-j+1];\n\
      if (deg(leadmonom(M[i,k])) == 0) //IsUnit\n\
      {\n\
        rest2 = e;\n\
        pos[size(pos)+1] = list(i,k);\n\
        for (a=1; a<=r; a=a+1)\n\
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
    
    GetUnitPosition := "\n\
proc GetUnitPosition (matrix M, list pos_list)\n\
{\n\
  int m = nrows(M);\n\
  int n = ncols(M);\n\
  list rest;\n\
  for (int o=1; o<=m; o=o+1)\n\
  {\n\
    rest[size(rest)+1] = o;\n\
  }\n\
  rest=Difference(rest,pos_list);\n\
  for (int j=1; j<=n; j=j+1)\n\
  {\n\
    for (int i=1; i<=size(rest); i=i+1)\n\
    {\n\
      if (deg(leadmonom(M[rest[i],j])) == 0)//IsUnit\n\
      {\n\
        return(string(j,\",\",rest[i])); // this is not a mistake\n\
      }\n\
    }\n\
  }\n\
  return(\"fail\");\n\
}\n\n",
    
    GetCleanRowsPositions := "\n\
proc GetCleanRowsPositions (matrix m, list l)\n\
{\n\
  list rows = list();\n\
  for (int i=1;i<=size(l);i=i+1)\n\
  {\n\
    for (int j=1;j<=ncols(m);j=j+1)\n\
    {\n\
      if (m[l[i],j]==1)\n\
      {\n\
        rows[size(rows)+1] = j;\n\
        break;\n\
      }\n\
    }\n\
  }\n\
  if (size(rows)==0)\n\
  {\n\
    return(\"[]\"));\n\
  }\n\
  return(string(rows));\n\
}\n\n",
    
    BasisOfRowModule := "\n\
proc BasisOfRowModule (matrix M)\n\
{\n\
  return(std(M));\n\
}\n\n",
    
    BasisOfColumnModule := "\n\
proc BasisOfColumnModule (matrix M)\n\
{\n\
  return(Involution(BasisOfRowModule(Involution(M))));\n\
}\n\n",
    
    ReducedBasisOfRowModule := "\n\
proc ReducedBasisOfRowModule (matrix M)\n\
{\n\
  return(mstd(M)[2]);\n\
}\n\n",
    
    ReducedBasisOfColumnModule := "\n\
proc ReducedBasisOfColumnModule (matrix M)\n\
{\n\
  return(Involution(ReducedBasisOfRowModule(Involution(M))));\n\
}\n\n",
    
#    ## according to the documentation B=M*T in the commutative case, but it somehow does not work :(
#    ## and for plural to work one would need to define B=transpose(transpose(T)*transpose(M)), which is expensive!!
#    BasisOfRowsCoeff := "\n\
#proc BasisOfRowsCoeff (matrix M)\n\
#{\n\
#  matrix T;\n\
#  matrix B = matrix(liftstd(M,T));\n\
#  list l = transpose(transpose(T)*transpose(M)),T;\n\
#  return(l)\n\
#}\n\n",
    
    BasisOfRowsCoeff := "\n\
proc BasisOfRowsCoeff (matrix M)\n\
{\n\
  matrix B = std(M);\n\
  matrix T = lift(M,B); //never use stdlift, also because it might differ from std!!!\n\
  list l = B,T;\n\
  return(l)\n\
}\n\n",
    
    BasisOfColumnsCoeff := "\n\
proc BasisOfColumnsCoeff (matrix M)\n\
{\n\
  list l = BasisOfRowsCoeff(Involution(M));\n\
  matrix B = l[1];\n\
  matrix T = l[2];\n\
  l = Involution(B),Involution(T);\n\
  return(l);\n\
}\n\n",
    
    DecideZeroRows := "\n\
proc DecideZeroRows (matrix A, matrix B)\n\
{\n\
  return(reduce(A,B));\n\
}\n\n",
    
    DecideZeroColumns := "\n\
proc DecideZeroColumns (matrix A, matrix B)\n\
{\n\
  return(Involution(reduce(Involution(A),Involution(B))));\n\
}\n\n",
    
#todo: read part of the unit matrix in singular help!
#      it is ignored right now.
# division(A^t,B^t) returns (TT^t, M^t, U^t) with
#                A^t*U^t = B^t*TT^t + M^t
# <=> (ignore U) M^t = A^t - B^t*TT^tr
# <=>            M   = A   + (-TT) * B
# <=> (T:=-TT)   M   = A   + T * B
#M^t=A^t-T^t*B^t
    
    DecideZeroRowsEffectively := "\n\
proc DecideZeroRowsEffectively (matrix A, matrix B)\n\
{\n\
  matrix M = reduce(A,B);\n\
  matrix T = lift(B,M-A);\n\
  list l = M,T;\n\
  return(l);\n\
}\n\n",
    
    DecideZeroColumnsEffectively := "\n\
proc DecideZeroColumnsEffectively (matrix A, matrix B)\n\
{\n\
  list l = DecideZeroRowsEffectively(Involution(A),Involution(B));\n\
  matrix B = l[1];\n\
  matrix T = l[2];\n\
  l = Involution(B),Involution(T);\n\
  return(l);\n\
}\n\n",
    
    SyzForHomalg := "\n\
proc SyzForHomalg (matrix M)\n\
{\n\
  return(syz(M));\n\
}\n\n",
    
    SyzygiesGeneratorsOfRows := "\n\
proc SyzygiesGeneratorsOfRows (matrix M)\n\
{\n\
  return(SyzForHomalg(M));\n\
}\n\n",
    
    SyzygiesGeneratorsOfColumns := "\n\
proc SyzygiesGeneratorsOfColumns (matrix M)\n\
{\n\
  return(Involution(SyzForHomalg(Involution(M))));\n\
}\n\n",
    
    RelativeSyzygiesGeneratorsOfRows := "\n\
proc RelativeSyzygiesGeneratorsOfRows (matrix M1, matrix M2)\n\
{\n\
  return(std(modulo(M1, M2)));\n\
}\n\n",
    
    RelativeSyzygiesGeneratorsOfColumns := "\n\
proc RelativeSyzygiesGeneratorsOfColumns (matrix M1, matrix M2)\n\
{\n\
  return(Involution(RelativeSyzygiesGeneratorsOfRows(Involution(M1),Involution(M2))));\n\
}\n\n",
    
    ReducedSyzForHomalg := "\n\
proc ReducedSyzForHomalg (matrix M)\n\
{\n\
  return(matrix(nres(M,2)[2]));\n\
}\n\n",
    
    ReducedSyzygiesGeneratorsOfRows := "\n\
proc ReducedSyzygiesGeneratorsOfRows (matrix M)\n\
{\n\
  return(ReducedSyzForHomalg(M));\n\
}\n\n",
    
    ReducedSyzygiesGeneratorsOfColumns := "\n\
proc ReducedSyzygiesGeneratorsOfColumns (matrix M)\n\
{\n\
  return(Involution(ReducedSyzForHomalg(Involution(M))));\n\
}\n\n",
    
    Deg := "\n\
ring r;\n\
if ( deg(0,(1,1,1)) > 0 )  // this is a workaround for a bug in the 64 bit versions of Singular 3-0-4\n\
{ proc Deg (pol,weights)\n\
  {\n\
    if ( pol == 0 )\n\
    {\n\
      return(deg(0));\n\
    }\n\
    return(deg(pol,weights));\n\
  }\n\
}\n\
else\n\
{ proc Deg (pol,weights)\n\
  {\n\
    return(deg(pol,weights));\n\
  }\n\
}\n\
kill r;\n\n",
    
    MultiDeg := "\n\
proc MultiDeg (pol,weights)\n\
{\n\
  int mul=size(weights);\n\
  intmat m[1][mul];\n\
  for (int i=1; i<=mul; i=i+1)\n\
  {\n\
    m[1,i]=Deg(pol,weights[i]);\n\
  }\n\
  return(m);\n\
}\n\n",
    
    DegreesOfEntries := "\n\
proc DegreesOfEntries (matrix M)\n\
{\n\
  intmat m[ncols(M)][nrows(M)];\n\
  for (int i=1; i<=ncols(M); i=i+1)\n\
  {\n\
    for (int j=1; j<=nrows(M); j=j+1)\n\
    {\n\
      m[i,j] = deg(M[j,i]);\n\
    }\n\
  }\n\
  return(m);\n\
}\n\n",
    
    WeightedDegreesOfEntries := "\n\
proc WeightedDegreesOfEntries (matrix M, weights)\n\
{\n\
  intmat m[ncols(M)][nrows(M)];\n\
  for (int i=1; i<=ncols(M); i=i+1)\n\
  {\n\
    for (int j=1; j<=nrows(M); j=j+1)\n\
    {\n\
      m[i,j] = Deg(M[j,i],weights);\n\
    }\n\
  }\n\
  return(m);\n\
}\n\n",
    
    NonTrivialDegreePerRow := "\n\
proc NonTrivialDegreePerRow (matrix M)\n\
{\n\
  int b = 1;\n\
  intmat m[1][ncols(M)];\n\
  int d = deg(0);\n\
  for (int i=1; i<=ncols(M); i=i+1)\n\
  {\n\
    for (int j=1; j<=nrows(M); j=j+1)\n\
    {\n\
      if ( deg(M[j,i]) <> d ) { m[1,i] = deg(M[j,i]); break; }\n\
    }\n\
    if ( b && i > 1 ) { if ( m[1,i] <> m[1,i-1] ) { b = 0; } } // Singular is strange\n\
  }\n\
  if ( b ) { return(m[1,1]); } else { return(m); }\n\
}\n\n",
    
    NonTrivialWeightedDegreePerRow := "\n\
proc NonTrivialWeightedDegreePerRow (matrix M, weights)\n\
{\n\
  int b = 1;\n\
  intmat m[1][ncols(M)];\n\
  int d = Deg(0,weights);\n\
  for (int i=1; i<=ncols(M); i=i+1)\n\
  {\n\
    for (int j=1; j<=nrows(M); j=j+1)\n\
    {\n\
      if ( Deg(M[j,i],weights) <> d ) { m[1,i] = Deg(M[j,i],weights); break; }\n\
    }\n\
    if ( b && i > 1 ) { if ( m[1,i] <> m[1,i-1] ) { b = 0; } } // Singular is strange\n\
  }\n\
  if ( b ) { return(m[1,1]); } else { return(m); }\n\
}\n\n",
    
    NonTrivialDegreePerRowWithColPosition := "\n\
proc NonTrivialDegreePerRowWithColPosition(matrix M)\n\
{\n\
  intmat m[2][ncols(M)];\n\
  int d = deg(0);\n\
  for (int i=1; i<=ncols(M); i=i+1)\n\
  {\n\
    for (int j=1; j<=nrows(M); j=j+1)\n\
    {\n\
      if ( deg(M[j,i]) <> d ) { m[1,i] = deg(M[j,i]); m[2,i] = j; break; }\n\
    }\n\
  }\n\
  return(m);\n\
}\n\n",
    
    NonTrivialWeightedDegreePerRowWithColPosition := "\n\
proc NonTrivialWeightedDegreePerRowWithColPosition(matrix M, weights)\n\
{\n\
  intmat m[2][ncols(M)];\n\
  int d = Deg(0,weights);\n\
  for (int i=1; i<=ncols(M); i=i+1)\n\
  {\n\
    for (int j=1; j<=nrows(M); j=j+1)\n\
    {\n\
      if ( Deg(M[j,i],weights) <> d ) { m[1,i] = Deg(M[j,i],weights); m[2,i] = j; break; }\n\
    }\n\
  }\n\
  return(m);\n\
}\n\n",
    
    NonTrivialDegreePerColumn := "\n\
proc NonTrivialDegreePerColumn (matrix M)\n\
{\n\
  int b = 1;\n\
  intmat m[1][nrows(M)];\n\
  int d = deg(0);\n\
  for (int j=1; j<=nrows(M); j=j+1)\n\
  {\n\
    for (int i=1; i<=ncols(M); i=i+1)\n\
    {\n\
      if ( deg(M[j,i]) <> d ) { m[1,j] = deg(M[j,i]); break; }\n\
    }\n\
    if ( b && j > 1 ) { if ( m[1,j] <> m[1,j-1] ) { b = 0; } } // Singular is strange\n\
  }\n\
  if ( b ) { return(m[1,1]); } else { return(m); }\n\
}\n\n",
    
    NonTrivialWeightedDegreePerColumn := "\n\
proc NonTrivialWeightedDegreePerColumn (matrix M, weights)\n\
{\n\
  int b = 1;\n\
  intmat m[1][nrows(M)];\n\
  int d = Deg(0,weights);\n\
  for (int j=1; j<=nrows(M); j=j+1)\n\
  {\n\
    for (int i=1; i<=ncols(M); i=i+1)\n\
    {\n\
      if ( Deg(M[j,i],weights) <> d ) { m[1,j] = Deg(M[j,i],weights); break; }\n\
    }\n\
    if ( b && j > 1 ) { if ( m[1,j] <> m[1,j-1] ) { b = 0; } } // Singular is strange\n\
  }\n\
  if ( b ) { return(m[1,1]); } else { return(m); }\n\
}\n\n",
    
    NonTrivialDegreePerColumnWithRowPosition := "\n\
proc NonTrivialDegreePerColumnWithRowPosition (matrix M)\n\
{\n\
  intmat m[2][nrows(M)];\n\
  int d = deg(0);\n\
  for (int j=1; j<=nrows(M); j=j+1)\n\
  {\n\
    for (int i=1; i<=ncols(M); i=i+1)\n\
    {\n\
      if ( deg(M[j,i]) <> d ) { m[1,j] = deg(M[j,i]); m[2,j] = i; break; }\n\
    }\n\
  }\n\
  return(m);\n\
}\n\n",
    
    NonTrivialWeightedDegreePerColumnWithRowPosition := "\n\
proc NonTrivialWeightedDegreePerColumnWithRowPosition (matrix M, weights)\n\
{\n\
  intmat m[2][nrows(M)];\n\
  int d = Deg(0,weights);\n\
  for (int j=1; j<=nrows(M); j=j+1)\n\
  {\n\
    for (int i=1; i<=ncols(M); i=i+1)\n\
    {\n\
      if ( Deg(M[j,i],weights) <> d ) { m[1,j] = Deg(M[j,i],weights); m[2,j] = i; break; }\n\
    }\n\
  }\n\
  return(m);\n\
}\n\n",

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
    DecideZeroRowsEffectivelyLocal := "\n\
proc DecideZeroRowsEffectivelyLocal (matrix A, matrix B)\n\
{\n\
  list l = division(A,B);\n\
  matrix U=l[3];\n\
  for (int i=1; i<=ncols(U); i=i+1)\n\
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

    DecideZeroColumnsEffectivelyLocal := "\n\
proc DecideZeroColumnsEffectivelyLocal (matrix A, matrix B)\n\
{\n\
  list l = DecideZeroRowsEffectivelyLocal(Involution(A),Involution(B));\n\
  matrix B = l[1];\n\
  matrix T = l[3];\n\
  l = Involution(B),l[2],Involution(T),l[4];\n\
  return(l);\n\
}\n\n",

    DecideZeroRowsLocal := "\n\
proc DecideZeroRowsLocal (matrix A, matrix B)\n\
{\n\
  list l=DecideZeroRowsEffectivelyLocal(A,B);\n\
  l=l[1],l[2];\n\
  return(l);\n\
}\n\n",

    DecideZeroColumnsLocal := "\n\
proc DecideZeroColumnsLocal (matrix A, matrix B)\n\
{\n\
  list l=DecideZeroColumnsEffectivelyLocal(A,B);\n\
  l=l[1],l[2];\n\
  return(l);\n\
}\n\n",

    BasisOfRowsCoeffLocal := "\n\
proc BasisOfRowsCoeffLocal (matrix M)\n\
{\n\
  matrix B = std(M);\n\
  matrix U;\n\
  matrix T = lift(M,B,U); //never use stdlift, also because it might differ from std!!!\n\
  list l = CreateInputForLocalMatrixRows(T,U);\n\
  l = B,l[1],l[2];\n\
  return(l)\n\
}\n\n",

    BasisOfColumnsCoeffLocal := "\n\
proc BasisOfColumnsCoeffLocal (matrix M)\n\
{\n\
  list l = BasisOfRowsCoeffLocal(Involution(M));\n\
  matrix B = l[1];\n\
  matrix T = l[2];\n\
  l = Involution(B),Involution(T),l[3];\n\
  return(l);\n\
}\n\n",

## A * U^-1 -> u^-1 A2
#above code should allready have caught this, but still: U is filled with a zero at the diagonal, when we reduce zero. we may replace this zero with any unit, so for smaller somputations we choose 1.
    CreateInputForLocalMatrixRows := "\n\
proc CreateInputForLocalMatrixRows (matrix A, matrix U)\n\
{\n\
  poly u=1;\n\
  matrix A2=A;\n\
  for (int i=1; i<=ncols(U); i=i+1)\n\
  {\n\
    if(U[i,i]!=0){u=lcm(u,U[i,i]);};\n\
  }\n\
  for (int i=1; i<=ncols(U); i=i+1)\n\
  {\n\
    if(U[i,i]==0){\n\
      poly gg=1;\n\
    } else {\n\
      poly uu=U[i,i];\n\
      poly gg=u/uu;\n\
    };\n\
    if(gg!=1)\n\
    {\n\
      for(int k=1;k<=nrows(A2);k=k+1){A2[k,i]=A2[k,i]*gg;};\n\
    }\n\
  }\n\
  list l=A2,u;\n\
  return(l);\n\
}\n\n",

    )
);

##
InstallGlobalFunction( InitializeSingularMacros,
  function( stream )
    local v;
    
    v := stream.variable_name;
    
    homalgSendBlocking( [ "int ", v, "i; int ", v, "j; int ", v, "k; list ", v, "l;\n\n" ], "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    InitializeMacros( SingularMacros, stream );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInSingular,
  function( arg )
    local nargs, stream, o, ar, ext_obj, R, RP;
    
    nargs := Length( arg );
    
    ##check whether the last argument already has a stream pointing to a running
    ##instance of Singular
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;

    ##if no such stream is found in the last argument, start and initialize
    ##a new Singular-process
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Singular );
        
        ##shut down the "redefining" messages
        homalgSendBlocking( "option(noredefine);option(redSB);LIB \"matrix.lib\";LIB \"control.lib\";LIB \"ring.lib\";LIB \"involut.lib\";LIB \"nctools.lib\";LIB \"poly.lib\";LIB \"finvar.lib\"", "need_command", stream, HOMALG_IO.Pictograms.initialize );
        o := 0;
    else
        o := 1;
    fi;
    
    InitializeSingularMacros( stream );
    
    ##this will lead to the call
    ##ring homalg_variable_something = arg[1];
    ar := [ [ arg[1] ], [ "ring" ], TheTypeHomalgExternalRingObjectInSingular, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInSingular );
    
    _Singular_SetRing( R );
    
    ##prints output in a compatible format
    homalgSendBlocking( "option(redTail);short=0;", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    RP := homalgTable( R );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( "\nproc Involution (matrix m)\n{\n  return(transpose(m));\n}\n\n", "need_command", R, HOMALG_IO.Pictograms.define );
    end;
    
    RP!.SetInvolution( R );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInSingular,
  function( arg )
    local ar, R;
    
    ##It seems that Singular does not know the fields.
    ##Instead we create Q[dummy_variable] and feed only expressions
    ##without "dummy_variable" to Singular. Since homalg in GAP
    ##does not know of the dummy_variable, during the next ring extension
    ##it will vanish and not slow down basis calculations.
    ar := Concatenation( [ "0,dummy_variable,dp" ], [ IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInSingular, ar );
    
    SetIsFieldForHomalg( R, true );
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInSingular,
  function( p )
    local ar, R;
    
    if not IsPrime( p ) then
      Error("given number ist not prime\n");
    fi;
    
    ##It seems that Singular does not know fields.
    ##Instead we create GF(p)[dummy_variable] and feed only expressions
    ##without "dummy_variable" to Singular. Since homalg in GAP
    ##does not know of the dummy_variable, during the next ring extension
    ##it will vanish and not slow down basis calculations.
    ar := Concatenation( [ Concatenation( String(p), ",dummy_variable,dp") ], [ IsPrincipalIdealRing ] );
    
    R := CallFuncList( RingForHomalgInSingular, ar );
    
    SetIsFieldForHomalg( R, true );
    
    SetRingProperties( R, p );
    
    return R;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep, IsList ],
        
  function( R, indets )
    local ar, r, var, properties, ext_obj, S, RP;
    
    ar := _PrepareInputForPolynomialRing( R, indets );
    
    r := ar[1];
    var := ar[2];
    properties := ar[3];
    
    ## create the new ring
    ext_obj := homalgSendBlocking( [ Characteristic( R ), ",(", var, "),dp" ] , [ "ring" ], TheTypeHomalgExternalRingObjectInSingular, properties, R, HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInSingular );
    
    var := List( var, a -> HomalgExternalRingElement( a, S ) );
    
    Perform( var, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsFreePolynomialRing( S, true );
    
    if HasIndeterminatesOfPolynomialRing( R ) and IndeterminatesOfPolynomialRing( R ) <> [ ] then
        SetBaseRing( S, R );
    fi;
    
    SetRingProperties( S, r, var );
    
    _Singular_SetRing( S );
    
    homalgSendBlocking( "option(redTail);short=0;", "need_command", ext_obj, HOMALG_IO.Pictograms.initialize );
    
    RP := homalgTable( S );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( "\nproc Involution (matrix m)\n{\n  return(transpose(m));\n}\n\n", "need_command", R, HOMALG_IO.Pictograms.define );
    end;
    
    RP!.SetInvolution( S );
    
    return S;
    
end );

##
InstallMethod( RingOfDerivations,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep, IsList ],
        
  function( R, indets )
    local ar, var, der, stream, display_color, ext_obj, S, RP;
    
    ar := _PrepareInputForRingOfDerivations( R, indets );
    
    var := ar[1];
    der := ar[2];
    
    stream := homalgStream( R );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        Print( "----------------------------------------------------------------\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
                     SINGULAR::PLURAL\n\
The SINGULAR Subsystem for Non-commutative Polynomial Computations\n\
     by: G.-M. Greuel, V. Levandovskyy, H. Schoenemann\n\
FB Mathematik der Universitaet, D-67653 Kaiserslautern\033[0m\n\
----------------------------------------------------------------\n\n" );
        
    fi;
    
    ## create the new ring in 2 steps: expand polynomial ring with derivatives and then
    ## add the Weyl-structure
    ## todo: this creates a block ordering with a new "dp"-block
    ext_obj := homalgSendBlocking( [ Characteristic( R ), ",(", var, der, "),dp" ] , [ "ring" ], R, HOMALG_IO.Pictograms.initialize );
    ext_obj := homalgSendBlocking( [ "Weyl();" ] , [ "def" ] , TheTypeHomalgExternalRingObjectInSingular, ext_obj, HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInSingular );
    
    der := List( der , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( der, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsWeylRing( S, true );
    
    SetBaseRing( S, R );
    
    SetRingProperties( S, R, der );
    
    _Singular_SetRing( S );
    
    homalgSendBlocking( "option(redTail);short=0;", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    RP := homalgTable( S );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( Concatenation(
                [ "\nproc Involution (matrix M)\n{\n" ],
                [ "  map F = ", R, ", " ],
                IndeterminateCoordinatesOfRingOfDerivations( R ),
                Concatenation( List( IndeterminateDerivationsOfRingOfDerivations( R ), a -> [ ", -" , a ] ) ),
                [ ";\n  return( transpose( involution( M, F ) ) );\n}\n\n" ]
                ), "need_command", HOMALG_IO.Pictograms.define );
    end;
    
    RP!.SetInvolution( S );
    
    RP!.Compose :=
      function( A, B )
        
        return homalgSendBlocking( [ "transpose( transpose(", A, ") * transpose(", B, ") )" ], [ "matrix" ], HOMALG_IO.Pictograms.Compose ); # FIXME : this has to be extensively documented to be understandable!
        
    end;
    
    ## there seems to exists a bug in Plural that occurs with mres(M,1)[1];
    Unbind( RP!.ReducedBasisOfRowModule );
    Unbind( RP!.ReducedBasisOfColumnModule );
    
    return S;
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep, IsHomalgExternalRingInSingularRep, IsList ],
        
  function( R, T, indets )
    local ar, var, anti, comm, stream, display_color, ext_obj, constructor, S, RP;
    
    ar := _PrepareInputForExteriorRing( R, T, indets );
    
    var := ar[1];
    anti := ar[2];
    comm := ar[3];
    
    stream := homalgStream( R );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        Print( "----------------------------------------------------------------\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
                     SINGULAR::PLURAL\n\
The SINGULAR Subsystem for Non-commutative Polynomial Computations\n\
     by: G.-M. Greuel, V. Levandovskyy, H. Schoenemann\n\
FB Mathematik der Universitaet, D-67653 Kaiserslautern\033[0m\n\
----------------------------------------------------------------\n\n" );
        
    fi;
    
    ## create the new ring in 2 steps: create a polynomial ring with anti commuting and commuting variables and then
    ## add the exterior structure
    ext_obj := homalgSendBlocking( [ Characteristic( R ), ",(", Concatenation( comm, anti ), "),dp" ] , [ "ring" ], R, HOMALG_IO.Pictograms.initialize );
    
    if homalgSendBlocking( "defined(SuperCommutative)", "need_output", ext_obj ) = "1" then
        constructor := "SuperCommutative";
    elif homalgSendBlocking( "defined(superCommutative)", "need_output", ext_obj ) = "1" then
        constructor := "superCommutative";
    else
        Error( "no Singular constructor found for exterior algebras\n" );
    fi;
    
    ext_obj := homalgSendBlocking( [ constructor, "(", Length( comm ) + 1, ");" ] , [ "def" ] , TheTypeHomalgExternalRingObjectInSingular, ext_obj, HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInSingular );
    
    anti := List( anti , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( anti, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    comm := List( comm , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( comm, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsExteriorRing( S, true );
    
    if HasBaseRing( R ) and IsIdenticalObj( BaseRing( R ), T ) then
        SetBaseRing( S, T );
    fi;
    
    SetRingProperties( S, R, anti );
    
    _Singular_SetRing( S );
    
    homalgSendBlocking( "option(redTail);option(redSB);", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    RP := homalgTable( S );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( Concatenation(
                [ "\nproc Involution (matrix M)\n{\n" ],
                [ "  map F = ", R ],
                Concatenation( List( IndeterminatesOfExteriorRing( R ), a -> [ a ] ) ),
                [ ";\n  return( transpose( involution( M, F ) ) );\n}\n\n" ]
                ), "need_command", HOMALG_IO.Pictograms.define );
    end;
    
    RP!.SetInvolution( S );
    
    RP!.Compose :=
      function( A, B )
        
        return homalgSendBlocking( [ "transpose( transpose(", A, ") * transpose(", B, ") )" ], [ "matrix" ], HOMALG_IO.Pictograms.Compose ); # see RingOfDerivations
        
    end;
    
    return S;
    
end );

##
#InstallMethod( SetRingProperties,
#        "constructor",
#        [ IsHomalgRing and IsLocalRing, IsHomalgRing ],
#        
#  function( S, R )
#    local RP;
#    
#    RP := homalgTable( R );
#    
#    SetCoefficientsRing( S, R );
#    SetCharacteristic( S, Characteristic( R ) );
#    SetIsCommutative( S, true );
#    if HasGlobalDimension( R ) then
#        SetGlobalDimension( S, GlobalDimension( R ) );
#    fi;
#    if HasKrullDimension( R ) then
#        SetKrullDimension( S, KrullDimension( R ) );
#    fi;
#          
#    SetIsIntegralDomain( S, true );
#    
#    SetBasisAlgorithmRespectsPrincipalIdeals( S, true );
#    
#end );

InstallMethod( LocalizePolynomialRingWithMoraAtZero,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep ],
        
  function( R )
    local var, properties, ext_obj, S, RP, component;

    #check whether base ring is polynomial and then extract needed data
    if HasIndeterminatesOfPolynomialRing( R ) and IsCommutative( R ) then
      var := IndeterminatesOfPolynomialRing( R );
    else
      Error( "base ring is not a polynomial ring" );
    fi;
    
    properties := [ IsCommutative, IsLocalRing ];
    
    if Length( var ) <= 1 then
        Add( properties, IsPrincipalIdealRing );
    fi;
    
    ## create the new ring
    ext_obj := homalgSendBlocking( [ Characteristic( R ), ",(", var, "),ds" ] , [ "ring" ], R, properties, TheTypeHomalgExternalRingObjectInSingular, HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgExternalRing( ext_obj, TheTypePreHomalgExternalRingInSingular );
    
    _Singular_SetRing( S );
    
    homalgSendBlocking( "option(redTail);short=0;", "need_command", ext_obj, HOMALG_IO.Pictograms.initialize );
    
    RP := homalgTable( S );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( "\nproc Involution (matrix m)\n{\n  return(transpose(m));\n}\n\n", "need_command", R, HOMALG_IO.Pictograms.define );
      end;
    
    RP!.SetInvolution( S );
    
    for component in NamesOfComponents( CommonHomalgTableForSingularBasicMoraPreRing ) do
        RP!.(component) := CommonHomalgTableForSingularBasicMoraPreRing.(component);
    od;
    
    return S;
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsString, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", c, r, "]=", s ], "need_command", HOMALG_IO.Pictograms.SetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( AddToEntryOfHomalgMatrix,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgExternalRingElementRep, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, a, R )
    
    homalgSendBlocking( [ M, "[", c, r, "]=", a, "+", M, "[", c, r, "]" ], "need_command", HOMALG_IO.Pictograms.AddToEntryOfHomalgMatrix );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "for homalg matrices in Singular",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInSingularRep ],
        
  function( s, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ s ], [ "matrix" ], [ "[", r, "][", c, "]" ], R, HOMALG_IO.Pictograms.HomalgMatrix );
    
    if not ( r = 1 and c = 1 ) then
        homalgSendBlocking( [ ext_obj, " = transpose(", ext_obj, ")" ], "need_command", HOMALG_IO.Pictograms.TransposedMatrix ); #added by Simon
    fi;
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ M, "[", c, r, "]" ], "need_output", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ M, "[", c, r, "]" ], [ "def" ], "return_ring_element", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( MatrixOfWeightsOfIndeterminates,
        "for external matrices in Singular",
        [ IsHomalgExternalRingInSingularRep and HasWeightsOfIndeterminates ],
        
  function( R )
    local degrees, n, m, ext_obj;
    
    degrees := WeightsOfIndeterminates( R );
    
    n := Length( degrees );
    
    if n > 0 and IsList( degrees[1] ) then
        m := Length( degrees[1] );
        degrees := Flat( TransposedMat( degrees ) );
    else
        m := 1;
    fi;
    
    ext_obj := homalgSendBlocking( [ "CreateListListOfIntegers(intvec(", degrees, "),", m, n, ")"  ], [ "list" ], R, HOMALG_IO.Pictograms.CreateList );
    
    return HomalgMatrix( ext_obj, m, n, R );
    
end );

####################################
#
# transfer methods:
#
####################################

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSingularRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "\"[\"+string(transpose(", M, "))+\"]\"" ], "need_output", HOMALG_IO.Pictograms.GetListOfHomalgMatrixAsString );
    #remark: matrices are saved transposed in singular
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSingularRep ],
        
  function( M, R )
    local command;
    
      command := [
          "matrix m[", NrColumns( M ),"][1];",
          "string s = \"[\";",
          "for(int i=1;i<=", NrRows( M ), ";i=i+1){",
            "m = ", M, "[1..", NrColumns( M ), ",i];",#remark: matrices are saved transposed in singular
            "if(i!=1){s=s+\",\";};",
            "s=s+\"[\"+string(m)+\"]\";",
          "};",
          "s=s+\"]\";"
        ];
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.GetListListOfHomalgMatrixAsString );
    
        return homalgSendBlocking( [ "s" ], "need_output", R, HOMALG_IO.Pictograms.GetListListOfHomalgMatrixAsString );
    
end );

##
#InstallMethod( GetSparseListOfHomalgMatrixAsString,
#        "for external matrices in Singular",
#        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSingularRep ],
#        
#  function( M , R )
#    local command,s;
#
#    command := [
#          "list l;poly p;list l2;",
#          "for(int i=1;i<=", NrRows( M ), ";i=i+1){",
#            "for(int j=1;j<=", NrColumns( M ), ";j=j+1){",
#              "p=", M, "[j,i];", #remark: matrices are saved transposed in singular
#              "if(p!=0){l2=[i,j,p];l=insert(l,l2)};",
#            "};",
#          "};"
#        ];
#    
#    homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.GetSparseListOfHomalgMatrixAsString);
#    
#    s := homalgSendBlocking( "l", "need_output", R, HOMALG_IO.Pictograms.GetSparseListOfHomalgMatrixAsString);
#    
#    if s <> "emptylist" then
#      return s;
#    else
#      return "[]"
#    fi;
#    
#end );

##

InstallMethod( SaveHomalgMatrixToFile,
        "for external matrices in Singular",
        [ IsString, IsHomalgMatrix, IsHomalgExternalRingInSingularRep ],
        
  function( filename, M, R )
    local mode, command;
    
    if not IsBound( M!.SaveAs ) then
        mode := "ListList";
    else
        mode := M!.SaveAs; #not yet supported
    fi;
    
    if mode = "ListList" then

        command := [ 
          "matrix m[", NrColumns( M ),"][1];",
          "string s = \"[\";",
          "for(int i=1;i<=", NrRows( M ), ";i=i+1)",
          "{m = ", M, "[1..", NrColumns( M ), ",i]; if(i!=1){s=s+\",\";};s=s+\"[\"+string(m)+\"]\";};",
          #remark: matrices are saved transposed in singular
          "s=s+\"]\";",
          "write(\"w: ", filename,"\",s);"
        ];

        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.SaveHomalgMatrixToFile );

    fi;
    
    return true;
    
end );


##
InstallMethod( LoadHomalgMatrixFromFile,
        "for external rings in Singular",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInSingularRep ],
        
  function( filename, r, c, R )
    local mode, fs, str, fname, command, M;
    
    if not IsBound( R!.LoadAs ) then
        mode := "ListList";
    else
        mode := R!.LoadAs; #not yet supported
    fi;
    
    #read the file with GAP and parse it for better Singular reading:
    fs := IO_File( filename, "r" );
    if fs = fail then
        Error( "unable to open the file ", filename, " for reading\n" );
    fi;
    str := IO_ReadUntilEOF( fs );
    if str = fail then
        Error( "unable to read lines from the file ", filename, "\n" );
    fi;
    if IO_Close( fs ) = fail then
        Error( "unable to close the file ", filename, "\n" );
    fi;
    
    str := Filtered( str, c -> not c in " []" );
    
    fname := Concatenation( filename, "-singular" );
    
    fname := FigureOutAnAlternativeDirectoryForTemporaryFiles( fname, "with_filename" );
    
    fs := IO_File( fname, "w" );
    if fs = fail then
        Error( "unable to open the file ", fname, " for writing\n" );
    fi;
    if IO_WriteFlush( fs, str ) = fail then
        Error( "unable to write in the file ", fname, "\n" );
    fi;
    if IO_Close( fs ) = fail then
        Error( "unable to close the file ", fname, "\n" );
    fi;
    
    M := HomalgVoidMatrix( R );
    
    if mode = "ListList" then
        
        command := [ "string s=read(\"r: ", fname, "\");",
                     "execute( \"matrix ", M, "[", r, "][", c, "] = \" + s + \";\" );",
                     M, " = transpose(", M, ")" ];#remark: matrices are saved transposed in singular
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.LoadHomalgMatrixFromFile );
        
    fi;
    
    if not ( IsBound( HOMALG_IO.DoNotDeleteTemporaryFiles ) and HOMALG_IO.DoNotDeleteTemporaryFiles = true ) then
        Exec( Concatenation( "/bin/rm -f \"", fname, "\"" ) );
    fi;
    
    SetNrRows( M, r );
    SetNrColumns( M, c );
    
    return M;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for homalg matrices in Singular",
        [ IsHomalgExternalMatrixRep ], 1,
        
  function( o )
    
    if IsHomalgExternalRingInSingularRep( HomalgRing( o ) ) then
        
        Print( homalgSendBlocking( [ "print(transpose(", o, "))" ], "need_display", HOMALG_IO.Pictograms.Display ) );
        
    else
        
        TryNextMethod( );
        
    fi;
    
end );

##
InstallMethod( DisplayRing,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep ], 1,
        
  function( o )
    
    homalgDisplay( [ "print(", o, ")" ] );
    
end );

