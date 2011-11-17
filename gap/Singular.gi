#############################################################################
##
##  Singular.gi               RingsForHomalg package         Mohamed Barakat
##                                                    Markus Lange-Hegermann
##                                                          Oleksandr Motsak
##                                                           Hans Schönemann
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
            executable := [ "Singular" ],	## this list is processed from left to right
            options := [ "-t", "--ticks-per-sec", "1000", "--echo=0", "--no-warn" ],	## the option "-q" causes IO to believe that Singular has died!
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
            ## prints polynomials in a format compatible with other CASs
            setring_post := [ "short=0;", "option(redTail);" ],	## a Singular specific
            setinvol := _Singular_SetInvolution,## a Singular specific
            define := "=",
            delete := function( var, stream ) homalgSendBlocking( [ "kill ", var ], "need_command", stream, HOMALG_IO.Pictograms.delete ); end,
            multiple_delete := _Singular_multiple_delete,
            prompt := "\033[01msingular>\033[0m ",
            output_prompt := "\033[1;30;43m<singular\033[0m ",
            display_color := "\033[0;30;47m",
            init_string := "option(noredefine);option(redSB);LIB \"matrix.lib\";LIB \"involut.lib\";LIB \"nctools.lib\";LIB \"poly.lib\";LIB \"finvar.lib\"",
            InitializeMacros := InitializeSingularMacros,
            time := function( stream, t ) return Int( homalgSendBlocking( [ "timer" ], "need_output", stream, HOMALG_IO.Pictograms.time ) ) - t; end,
            memory_usage := function( stream, o ) return Int( homalgSendBlocking( [ "memory(", o, ")" ], "need_output", stream, HOMALG_IO.Pictograms.memory ) ); end,
           )
);

HOMALG_IO_Singular.READY_LENGTH := Length( HOMALG_IO_Singular.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalRingObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInSingularRep",
        IshomalgExternalRingObjectRep,
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

# a new type:
BindGlobal( "TheTypeHomalgExternalRingInSingular",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInSingularRep ) );

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
    
    if IsBound( HOMALG_IO_Singular.setring_post ) then
        homalgSendBlocking( HOMALG_IO_Singular.setring_post, "need_command", stream, HOMALG_IO.Pictograms.initialize );
    fi;
    
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
  for (int p=1; p<=k; p++)\n\
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
  int l = 1;\n\
  \n\
  for (int p=1; p<=s; p++)\n\
  {\n\
    if (IsMemberOfList(a[p],b)==0)\n\
    {\n\
      c[l] = a[p]; l++;\n\
    }\n\
  }\n\
  return(c);\n\
}\n\n",
    
    GetSparseListOfHomalgMatrixAsString := "\n\
proc GetSparseListOfHomalgMatrixAsString (M)\n\
{\n\
  list l;int k;\n\
  k = 1;\n\
  for(int i=1; i<=ncols(M); i++){\n\
    for(int j=1; j<=nrows(M); j++){\n\
      def p=M[j,i]; // remark: matrices are saved transposed in Singular\n\
      if(p!=0){l[k]=list(i,j,p); k++;};\n\
    };\n\
  };\n\
  return(string(l));\n\
}\n\n",
    
    CreateListListOfIntegers := "\n\
proc CreateListListOfIntegers (degrees,m,n)\n\
{\n\
  list l;\n\
  for (int i=m; i>=1; i--)\n\
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
  for (int i=1; i<=min; i++)\n\
  {\n\
    c[i,i]=0;\n\
  }\n\
  return(c==z);\n\
}\n\n",
    
    ZeroRows := "\n\
proc ZeroRows (module m)\n\
{\n\
  list l;\n\
  int s = 1;\n\
  for (int i=1;i<=ncols(m);i++)\n\
  {\n\
    if (m[i]==0)\n\
    {\n\
      l[s]=i; s++;\n\
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
  matrix m=module(transpose(n));\n\
  list l;\n\
  int s = 1;\n\
  for (int i=1;i<=ncols(m);i++)\n\
  {\n\
    if (m[i]==0)\n\
    {\n\
      l[s]=i; s++;\n\
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
      if (deg(M[k,j]) == 0) //IsUnit\n\
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
    
    GetColumnIndependentUnitPositions_Z := "\n\
proc GetColumnIndependentUnitPositions_Z (matrix M, list pos_list)\n\
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
      if (M[k,j] == 1 || M[k,j] == -1) //IsUnit\n\
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
    
    GetRowIndependentUnitPositions := "\n\
proc GetRowIndependentUnitPositions (matrix M, list pos_list)\n\
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
      if (deg(M[i,k]) == 0) //IsUnit\n\
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
    
    GetRowIndependentUnitPositions_Z := "\n\
proc GetRowIndependentUnitPositions_Z (matrix M, list pos_list)\n\
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
      if (M[i,k] == 1 || M[i,k] == -1) //IsUnit\n\
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
    
    GetUnitPosition := "\n\
proc GetUnitPosition (matrix M, list pos_list)\n\
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
      if (deg(M[rest[i],j]) == 0) //IsUnit\n\
      {\n\
        return(string(j,\",\",rest[i])); // this is not a mistake\n\
      }\n\
    }\n\
  }\n\
  return(\"fail\");\n\
}\n\n",
    
    GetUnitPosition_Z := "\n\
proc GetUnitPosition_Z (matrix M, list pos_list)\n\
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
      if (M[rest[i],j] == 1 || M[rest[i],j] == -1) //IsUnit\n\
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
  list rows;\n\
  int s = 1;\n\
  for (int i=1;i<=size(l);i++)\n\
  {\n\
    for (int j=1;j<=ncols(m);j++)\n\
    {\n\
      if (m[l[i],j]==1)\n\
      {\n\
        rows[s] = j; s++;\n\
        break;\n\
      }\n\
    }\n\
  }\n\
  if (s==0)\n\
  {\n\
    return(\"[]\"));\n\
  }\n\
  return(string(rows));\n\
}\n\n",
    
    PositionOfFirstNonZeroEntryPerRow := "\n\
proc PositionOfFirstNonZeroEntryPerRow (matrix M)\n\
{\n\
  int b = 1;\n\
  intmat m[1][ncols(M)];\n\
  for (int i=1; i<=ncols(M); i++)\n\
  {\n\
    for (int j=1; j<=nrows(M); j++)\n\
    {\n\
      if ( M[j,i] <> 0 ) { m[1,i] = j; break; }\n\
    }\n\
    if ( b && i > 1 ) { if ( m[1,i] <> m[1,i-1] ) { b = 0; } } // Singular is strange\n\
  }\n\
  if ( b ) { return(m[1,1]); } else { return(m); }\n\
}\n\n",
    
    PositionOfFirstNonZeroEntryPerColumn := "\n\
proc PositionOfFirstNonZeroEntryPerColumn (matrix M)\n\
{\n\
  int b = 1;\n\
  intmat m[1][nrows(M)];\n\
  for (int j=1; j<=nrows(M); j++)\n\
  {\n\
    for (int i=1; i<=ncols(M); i++)\n\
    {\n\
      if ( M[j,i] <> 0 ) { m[1,j] = i; break; }\n\
    }\n\
    if ( b && j > 1 ) { if ( m[1,j] <> m[1,j-1] ) { b = 0; } } // Singular is strange\n\
  }\n\
  if ( b ) { return(m[1,1]); } else { return(m); }\n\
}\n\n",
    
    IndicatorMatrixOfNonZeroEntries := "\n\
proc IndicatorMatrixOfNonZeroEntries(matrix M)\n\
{\n\
  intmat m[ncols(M)][nrows(M)];\n\
  for (int i=1; i<=ncols(M); i++)\n\
  {\n\
    for (int j=1; j<=nrows(M); j++)\n\
    {\n\
      m[i,j] = ( M[j,i] <> 0 );\n\
    }\n\
  }\n\
  return(m);\n\
}\n\n",
    
##  <#GAPDoc Label="BasisOfRowModule:SingularMacro">
##  <ManSection>
##    <Func Arg="M" Name="BasisOfRowModule" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    BasisOfRowModule := "\n\
proc BasisOfRowModule (matrix M)\n\
{\n\
  return(std(M));\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
    
##  <#GAPDoc Label="BasisOfColumnModule:SingularMacro">
##  <ManSection>
##    <Func Arg="M" Name="BasisOfColumnModule" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    BasisOfColumnModule := "\n\
proc BasisOfColumnModule (matrix M)\n\
{\n\
  return(Involution(BasisOfRowModule(Involution(M))));\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
    
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

#never use stdlift, also because it might differ from std!!!
##  <#GAPDoc Label="BasisOfRowsCoeff:SingularMacro">
##  <ManSection>
##    <Func Arg="M, T" Name="BasisOfRowsCoeff" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    BasisOfRowsCoeff := "\n\
proc BasisOfRowsCoeff (matrix M)\n\
{\n\
  matrix B = BasisOfRowModule(M);\n\
  matrix T = lift(M,B);\n\
  list l = B,T;\n\
  return(l)\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="BasisOfColumnsCoeff:SingularMacro">
##  <ManSection>
##    <Func Arg="M, T" Name="BasisOfColumnsCoeff" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    BasisOfColumnsCoeff := "\n\
proc BasisOfColumnsCoeff (matrix M)\n\
{\n\
  list l = BasisOfRowsCoeff(Involution(M));\n\
  matrix B = l[1];\n\
  matrix T = l[2];\n\
  l = Involution(B),Involution(T);\n\
  return(l);\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
    
##  <#GAPDoc Label="DecideZeroRows:SingularMacro">
##  <ManSection>
##    <Func Arg="A, B" Name="DecideZeroRows" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    DecideZeroRows := "\n\
proc DecideZeroRows (matrix A, matrix B)\n\
{\n\
  return(reduce(A,B));\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DecideZeroColumns:SingularMacro">
##  <ManSection>
##    <Func Arg="A, B" Name="DecideZeroColumns" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    DecideZeroColumns := "\n\
proc DecideZeroColumns (matrix A, matrix B)\n\
{\n\
  return(Involution(reduce(Involution(A),Involution(B))));\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
    
# division(A^t,B^t) returns (TT^t, M^t, U^t) with
#                A^t*U^t = B^t*TT^t + M^t
# <=> (ignore U) M^t = A^t - B^t*TT^tr
# <=>            M   = A   + (-TT) * B
# <=> (T:=-TT)   M   = A   + T * B
#M^t=A^t-T^t*B^t

##  <#GAPDoc Label="DecideZeroRowsEffectively:SingularMacro">
##  <ManSection>
##    <Func Arg="A, B, T" Name="DecideZeroRowsEffectively" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    DecideZeroRowsEffectively := "\n\
proc DecideZeroRowsEffectively (matrix A, matrix B)\n\
{\n\
  matrix M = reduce(A,B);\n\
  matrix T = lift(B,M-A);\n\
  list l = M,T;\n\
  return(l);\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="DecideZeroColumnsEffectively:SingularMacro">
##  <ManSection>
##    <Func Arg="A, B, T" Name="DecideZeroColumnsEffectively" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    DecideZeroColumnsEffectively := "\n\
proc DecideZeroColumnsEffectively (matrix A, matrix B)\n\
{\n\
  list l = DecideZeroRowsEffectively(Involution(A),Involution(B));\n\
  matrix B = l[1];\n\
  matrix T = l[2];\n\
  l = Involution(B),Involution(T);\n\
  return(l);\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
    
    SyzForHomalg := "\n\
proc SyzForHomalg (matrix M)\n\
{\n\
  return(syz(M));\n\
}\n\n",

##  <#GAPDoc Label="SyzygiesGeneratorsOfRows:SingularMacro">
##  <ManSection>
##    <Func Arg="M" Name="SyzygiesGeneratorsOfRows" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    SyzygiesGeneratorsOfRows := "\n\
proc SyzygiesGeneratorsOfRows (matrix M)\n\
{\n\
  return(SyzForHomalg(M));\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="SyzygiesGeneratorsOfColumns:SingularMacro">
##  <ManSection>
##    <Func Arg="M" Name="SyzygiesGeneratorsOfColumns" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    SyzygiesGeneratorsOfColumns := "\n\
proc SyzygiesGeneratorsOfColumns (matrix M)\n\
{\n\
  return(Involution(SyzForHomalg(Involution(M))));\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="RelativeSyzygiesGeneratorsOfRows:SingularMacro">
##  <ManSection>
##    <Func Arg="M, M2" Name="RelativeSyzygiesGeneratorsOfRows" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    RelativeSyzygiesGeneratorsOfRows := "\n\
proc RelativeSyzygiesGeneratorsOfRows (matrix M1, matrix M2)\n\
{\n\
  return(BasisOfRowModule(modulo(M1, M2)));\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="RelativeSyzygiesGeneratorsOfColumns:SingularMacro">
##  <ManSection>
##    <Func Arg="M, M2" Name="RelativeSyzygiesGeneratorsOfColumns" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    RelativeSyzygiesGeneratorsOfColumns := "\n\
proc RelativeSyzygiesGeneratorsOfColumns (matrix M1, matrix M2)\n\
{\n\
  return(Involution(RelativeSyzygiesGeneratorsOfRows(Involution(M1),Involution(M2))));\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="ReducedSyzygiesGeneratorsOfRows:SingularMacro">
##  <ManSection>
##    <Func Arg="M" Name="ReducedSyzygiesGeneratorsOfRows" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    ReducedSyzForHomalg := "\n\
proc ReducedSyzForHomalg (matrix M)\n\
{\n\
  return(matrix(nres(M,2)[2]));\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="ReducedSyzygiesGeneratorsOfColumns:SingularMacro">
##  <ManSection>
##    <Func Arg="M" Name="ReducedSyzygiesGeneratorsOfColumns" Label="Singular macro"/>
##    <Returns></Returns>
##    <Description>
##    
##      <Listing Type="Code"><![CDATA[
    ReducedSyzygiesGeneratorsOfRows := "\n\
proc ReducedSyzygiesGeneratorsOfRows (matrix M)\n\
{\n\
  return(ReducedSyzForHomalg(M));\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
    
    ReducedSyzygiesGeneratorsOfColumns := "\n\
proc ReducedSyzygiesGeneratorsOfColumns (matrix M)\n\
{\n\
  return(Involution(ReducedSyzForHomalg(Involution(M))));\n\
}\n\n",
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
    
    superCommutative_ForHomalg := "\n\
if ( defined(superCommutative) == 1 ) // the new name of the SCA constructor\n\
{ proc superCommutative_ForHomalg = superCommutative; }\n\
else\n\
{ \n\
  if ( defined(SuperCommutative) == 1 ) // the old name of the SCA constructor\n\
  { proc superCommutative_ForHomalg = SuperCommutative; }\n\
}\n\
\n\n",
    
    CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries := "\n\
proc CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries (module m,weights,degrees)\n\
{\n\
  module M = std(m);\n\
  attrib(M,\"isHomog\",degrees);\n\
  return(hilb(M,1,weights));\n\
}\n\n",

    PrimaryDecomposition := "\n\
proc PrimaryDecomposition (matrix m)\n\
{\n\
  return(primdecSY(m))\n\
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
    local nargs, ar, R, RP;
    
    nargs := Length( arg );
    
    ##this will lead to the call
    ##ring homalg_variable_something = arg[1];
    ar := [ arg[1], [ "ring" ] ];
    
    Add( ar, TheTypeHomalgExternalRingObjectInSingular );
    
    if nargs > 1 then
        Append( ar, arg{[ 2 .. nargs ]} );
    fi;
    
    ar := [ ar, TheTypeHomalgExternalRingInSingular ];
    
    Add( ar, "HOMALG_IO_Singular" );
    
    R := CallFuncList( CreateHomalgExternalRing, ar );
    
    _Singular_SetRing( R );
    
    RP := homalgTable( R );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( "\nproc Involution (matrix m)\n{\n  return(transpose(m));\n}\n\n", "need_command", R, HOMALG_IO.Pictograms.define );
    end;
    
    homalgStream( R ).setinvol( R );
    
    LetWeakPointerListOnExternalObjectsContainRingCreationNumbers( R );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInSingular,
  function( arg )
    local nargs, c, param, r, R;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsInt( arg[1] ) and arg[1] <> 0 then
        ## characteristic:
        c := AbsInt( arg[1] );
        arg := arg{[ 2 .. nargs ]};
    else
        ## characteristic:
        c := 0;
        if nargs > 0 and arg[1] = 0 then
            arg := arg{[ 2 .. nargs ]};
        fi;
    fi;
    
    if not ( IsZero( c ) or IsPrime( c ) ) then
        Error( "the support for the ring Z/", c, "Z (", c, " non-prime) in Singular is not stable yet!\nYou can use the generic residue class ring constructor '/' provided by homalg after defining the ambient ring (over the integers)\nfor help type: ?homalg: constructor for residue class rings\n" );
    fi;
    
    ## we create GF(p)[dummy_variable] and feed only expressions without
    ## "dummy_variable" to Singular. Since GAP does not know about
    ## the dummy_variable it will vanish during the next ring extension
    
    nargs := Length( arg );
    
    if nargs > 0 and IsString( arg[1] ) then
        
        param := ParseListOfIndeterminates( SplitString( arg[1], "," ) );
        
        arg := arg{[ 2 .. nargs ]};
        
        r := CallFuncList( HomalgRingOfIntegersInSingular, Concatenation( [ c ], arg ) );
        
        if IsZero( c ) then
            R := [ "(integer,", JoinStringsWithSeparator( param ), "),dummy_variable,dp" ];
        else
            R := [ "(", String( c ), ",", JoinStringsWithSeparator( param ), "),dummy_variable,dp" ];
        fi;
        
    else
        
        if IsZero( c ) then
            R := [ "(integer)", ",dummy_variable,dp" ];
        else
            R := [ String( c ), ",dummy_variable,dp" ];
        fi;
        
    fi;
    
    R := Concatenation( [ R, IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInSingular, R );
    
    if IsBound( param ) then
        
        param := List( param, a -> HomalgExternalRingElement( a, R ) );
        
        Perform( param, function( v ) SetName( v, homalgPointer( v ) ); end );
        
        SetRationalParameters( R, param );
        
        SetCoefficientsRing( R, r );
        
        SetIsResidueClassRingOfTheIntegers( R, false );
        
        if IsPrime( c ) then
            SetIsFieldForHomalg( R, true );
        else
            SetIsFieldForHomalg( R, false );
            SetIsPrincipalIdealRing( R, true );
            SetIsCommutative( R, true );
        fi;
        
    else
        
        SetIsResidueClassRingOfTheIntegers( R, true );
        
    fi;
    
    SetRingProperties( R, c );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInSingular,
  function( arg )
    local nargs, param, minimal_polynomial, Q, R;
    
    ## we create Q[dummy_variable] and feed only expressions without
    ## "dummy_variable" to Singular. Since GAP does not know about
    ## the dummy_variable it will vanish during the next ring extension
    
    nargs := Length( arg );
    
    if nargs > 0 and IsString( arg[1] ) then
        
        param := ParseListOfIndeterminates( SplitString( arg[1], "," ) );
        
        arg := arg{[ 2 .. nargs ]};
        
        if nargs > 1 and IsString( arg[1] ) then
            minimal_polynomial := arg[1];
            arg := arg{[ 2 .. nargs - 1 ]};
        fi;
        
        Q := CallFuncList( HomalgFieldOfRationalsInSingular, arg );
        
        R := [ "(0,", JoinStringsWithSeparator( param ), "),dummy_variable,dp" ];
        
    else
        
        R := "0,dummy_variable,dp";
        
    fi;
    
    R := Concatenation( [ R ], [ IsPrincipalIdealRing ], arg );
    
    if IsBound( Q ) then
        ## R will be defined in the same instance of Singular as Q
        Add( R, Q );
    fi;
    
    R := CallFuncList( RingForHomalgInSingular, R );
    
    if IsBound( minimal_polynomial ) then
        ## FIXME: we assume the polynomial is irreducible of degree > 1
        homalgSendBlocking( [ "minpoly=", minimal_polynomial ], "need_command", R, HOMALG_IO.Pictograms.define );
        R!.MinimalPolynomialOfPrimitiveElement := minimal_polynomial;
    fi;
    
    if IsBound( param ) then
        
        param := List( param, a -> HomalgExternalRingElement( a, R ) );
        
        Perform( param, function( v ) SetName( v, homalgPointer( v ) ); end );
        
        SetRationalParameters( R, param );
        
        SetIsFieldForHomalg( R, true );
        
        SetCoefficientsRing( R, Q );
        
    else
        
        SetIsRationalsForHomalg( R, true );
        
    fi;
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep, IsList ],
        
  function( R, indets )
    local ar, r, var, nr_var, properties, param, ext_obj, S, l, RP;
    
    ar := _PrepareInputForPolynomialRing( R, indets );
    
    r := ar[1];
    var := ar[2];	## all indeterminates, relative and base
    nr_var := ar[3];	## the number of relative indeterminates
    properties := ar[4];
    param := ar[5];
    
    ## create the new ring
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        ext_obj := homalgSendBlocking( [ "(integer", param, "),(", var, "),dp" ] , [ "ring" ], TheTypeHomalgExternalRingObjectInSingular, properties, R, HOMALG_IO.Pictograms.CreateHomalgRing );
    else
        ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", var, "),dp" ] , [ "ring" ], TheTypeHomalgExternalRingObjectInSingular, properties, R, HOMALG_IO.Pictograms.CreateHomalgRing );
    fi;
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInSingular );
    
    if IsBound( r!.MinimalPolynomialOfPrimitiveElement ) then
        homalgSendBlocking( [ "minpoly=", r!.MinimalPolynomialOfPrimitiveElement ], "need_command", S, HOMALG_IO.Pictograms.define );
    fi;
    
    var := List( var, a -> HomalgExternalRingElement( a, S ) );
    
    Perform( var, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsFreePolynomialRing( S, true );
    
    if HasIndeterminatesOfPolynomialRing( R ) and IndeterminatesOfPolynomialRing( R ) <> [ ] then
        SetBaseRing( S, R );
        l := Length( var );
        SetRelativeIndeterminatesOfPolynomialRing( S, var{[ l - nr_var + 1 .. l ]} );
    fi;
    
    SetRingProperties( S, r, var );
    
    _Singular_SetRing( S );
    
    RP := homalgTable( S );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( "\nproc Involution (matrix m)\n{\n  return(transpose(m));\n}\n\n", "need_command", R, HOMALG_IO.Pictograms.define );
    end;
    
    homalgStream( S ).setinvol( S );
    
    if not ( HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) ) then
        Unbind( RP!.IsUnit );
        Unbind( RP!.GetColumnIndependentUnitPositions );
        Unbind( RP!.GetRowIndependentUnitPositions );
        Unbind( RP!.GetUnitPosition );
    fi;
    
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        RP!.IsUnit := RP!.IsUnit_Z;
        RP!.GetColumnIndependentUnitPositions := RP!.GetColumnIndependentUnitPositions_Z;
        RP!.GetRowIndependentUnitPositions := RP!.GetRowIndependentUnitPositions_Z;
        RP!.GetUnitPosition := RP!.GetUnitPosition_Z;
    fi;
    
    return S;
    
end );

##
InstallMethod( RingOfDerivations,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep, IsList ],
        
  function( R, indets )
    local ar, r, var, der, param, stream, display_color, ext_obj, S, RP;
    
    ar := _PrepareInputForRingOfDerivations( R, indets );
    
    r := ar[1];
    var := ar[2];
    der := ar[3];
    param := ar[4];
    
    stream := homalgStream( R );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        Print( "================================================================\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
                     SINGULAR::PLURAL\n\
The SINGULAR Subsystem for Non-commutative Polynomial Computations\n\
     by: G.-M. Greuel, V. Levandovskyy, H. Schoenemann\n\
FB Mathematik der Universitaet, D-67653 Kaiserslautern\033[0m\n\
================================================================\n" );
        
    fi;
    
    ## create the new ring in 2 steps: expand polynomial ring with derivatives and then
    ## add the Weyl-structure
    ## todo: this creates a block ordering with a new "dp"-block
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        ext_obj := homalgSendBlocking( [ "(integer", param,  "),(", var, der, "),dp" ] , [ "ring" ], TheTypeHomalgExternalRingObjectInSingular, R, HOMALG_IO.Pictograms.CreateHomalgRing );
    else
        ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", var, der, "),dp" ] , [ "ring" ], R, HOMALG_IO.Pictograms.initialize );
    fi;
    ext_obj := homalgSendBlocking( [ "Weyl();" ] , [ "def" ] , TheTypeHomalgExternalRingObjectInSingular, ext_obj, HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInSingular );
    
    if IsBound( r!.MinimalPolynomialOfPrimitiveElement ) then
        homalgSendBlocking( [ "minpoly=", r!.MinimalPolynomialOfPrimitiveElement ], "need_command", S, HOMALG_IO.Pictograms.define );
    fi;
    
    der := List( der , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( der, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsWeylRing( S, true );
    
    SetBaseRing( S, R );
    
    SetRingProperties( S, R, der );
    
    _Singular_SetRing( S );
    
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
    
    homalgStream( S ).setinvol( S );
    
    RP!.Compose :=
      function( A, B )
        
        return homalgSendBlocking( [ "transpose( transpose(", A, ") * transpose(", B, ") )" ], [ "matrix" ], HOMALG_IO.Pictograms.Compose ); # FIXME : this has to be extensively documented to be understandable!
        
    end;
    
    ## there exists a bug in Plural (3-0-4,3-1-0) that occurs with nres(M,2)[2];
    if homalgSendBlocking( "\n\
// start: check the nres-isHomog-bug in Plural:\n\
ring homalg_Weyl_1 = 0,(x,y,z,Dx,Dy,Dz),dp;\n\
def homalg_Weyl_2 = Weyl();\n\
setring homalg_Weyl_2;\n\
option(redTail);short=0;\n\
matrix homalg_Weyl_3[1][3] = 3*Dy-Dz,2*x,3*Dx+3*Dz;\n\
matrix homalg_Weyl_4 = nres(homalg_Weyl_3,2)[2];\n\
ncols(homalg_Weyl_4) == 2; kill homalg_Weyl_4; kill homalg_Weyl_3; kill homalg_Weyl_2; kill homalg_Weyl_1;\n\
// end: check the nres-isHomog-bug in Plural."
    , "need_output", S, HOMALG_IO.Pictograms.initialize ) = "1" then;
    
        Unbind( RP!.ReducedSyzygiesGeneratorsOfRows );
        Unbind( RP!.ReducedSyzygiesGeneratorsOfColumns );
    fi;
    
    _Singular_SetRing( S );
    
    ## there seems to exists a bug in Plural that occurs with mres(M,1)[1];
    Unbind( RP!.ReducedBasisOfRowModule );
    Unbind( RP!.ReducedBasisOfColumnModule );
    
    if not ( HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) ) then
        Unbind( RP!.IsUnit );
        Unbind( RP!.GetColumnIndependentUnitPositions );
        Unbind( RP!.GetRowIndependentUnitPositions );
        Unbind( RP!.GetUnitPosition );
    fi;
    
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        RP!.IsUnit := RP!.IsUnit_Z;
        RP!.GetColumnIndependentUnitPositions := RP!.GetColumnIndependentUnitPositions_Z;
        RP!.GetRowIndependentUnitPositions := RP!.GetRowIndependentUnitPositions_Z;
        RP!.GetUnitPosition := RP!.GetUnitPosition_Z;
    fi;
    
    return S;
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep, IsHomalgExternalRingInSingularRep, IsHomalgExternalRingInSingularRep, IsList ],
        
  function( R, Coeff, Base, indets )
    local ar, r, param, var, anti, comm, stream, display_color, ext_obj, S, RP;
    
    ar := _PrepareInputForExteriorRing( R, Base, indets );
    
    r := ar[1];
    param := ar[2];
    var := ar[3];
    anti := ar[4];
    comm := ar[5];
    
    stream := homalgStream( R );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        Print( "================================================================\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
                     SINGULAR::SCA\n\
The SINGULAR Subsystem for Super-Commutative Algebras\n\
     by: G.-M. Greuel, O. Motsak, H. Schoenemann\n\
FB Mathematik der Universitaet, D-67653 Kaiserslautern\033[0m\n\
================================================================\n" );
        
    fi;
    
    ## create the new ring in 2 steps: create a polynomial ring with anti commuting and commuting variables and then
    ## add the exterior structure
    ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", Concatenation( comm, anti ), "),dp" ] , [ "ring" ], R, HOMALG_IO.Pictograms.initialize );
    
    ext_obj := homalgSendBlocking( [ "superCommutative_ForHomalg(", Length( comm ) + 1, ");" ] , [ "def" ] , TheTypeHomalgExternalRingObjectInSingular, ext_obj, HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInSingular );
    
    if IsBound( r!.MinimalPolynomialOfPrimitiveElement ) then
        homalgSendBlocking( [ "minpoly=", r!.MinimalPolynomialOfPrimitiveElement ], "need_command", S, HOMALG_IO.Pictograms.define );
    fi;
    
    anti := List( anti , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( anti, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    comm := List( comm , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( comm, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsExteriorRing( S, true );
    
    SetBaseRing( S, Base );
    
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
    
    homalgStream( S ).setinvol( S );
    
    RP!.Compose :=
      function( A, B )
        
        return homalgSendBlocking( [ "transpose( transpose(", A, ") * transpose(", B, ") )" ], [ "matrix" ], HOMALG_IO.Pictograms.Compose ); # see RingOfDerivations
        
    end;
    
    if not ( HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) ) then
        Unbind( RP!.IsUnit );
        Unbind( RP!.GetColumnIndependentUnitPositions );
        Unbind( RP!.GetRowIndependentUnitPositions );
        Unbind( RP!.GetUnitPosition );
    fi;
    
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        RP!.IsUnit := RP!.IsUnit_Z;
        RP!.GetColumnIndependentUnitPositions := RP!.GetColumnIndependentUnitPositions_Z;
        RP!.GetRowIndependentUnitPositions := RP!.GetRowIndependentUnitPositions_Z;
        RP!.GetUnitPosition := RP!.GetUnitPosition_Z;
    fi;
    
    return S;
    
end );

##
InstallMethod( SetMatElm,
        "for homalg external matrices in Singular",
        [ IsHomalgExternalMatrixRep and IsMutable, IsPosInt, IsPosInt, IsString, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", c, r, "]=", s ], "need_command", HOMALG_IO.Pictograms.SetMatElm );
    
end );

##
InstallMethod( AddToMatElm,
        "for homalg external matrices in Singular",
        [ IsHomalgExternalMatrixRep and IsMutable, IsPosInt, IsPosInt, IsHomalgExternalRingElementRep, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, a, R )
    
    homalgSendBlocking( [ M, "[", c, r, "]=", a, "+", M, "[", c, r, "]" ], "need_command", HOMALG_IO.Pictograms.AddToMatElm );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg external matrices in Singular",
        [ IsString, IsHomalgExternalRingInSingularRep ],
        
  function( s, R )
    local r, c;
    
    r := Length( Positions( s, '[' ) ) - 1;
    
    c := ( Length( Positions( s, ',' ) ) + 1 ) / r;
    
    return CreateHomalgMatrixFromString( s, r, c, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg external matrices in Singular",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInSingularRep ],
        
  function( s, r, c, R )
    local str, ext_obj;
    
    str := ShallowCopy( s );
    
    RemoveCharacters( str, "[]" );
    
    ext_obj := homalgSendBlocking( [ str ], [ "matrix" ], [ "[", r, "][", c, "]" ], R, HOMALG_IO.Pictograms.HomalgMatrix );
    
    if not ( r = 1 and c = 1 ) then
        homalgSendBlocking( [ ext_obj, " = transpose(", ext_obj, ")" ], "need_command", HOMALG_IO.Pictograms.TransposedMatrix );
    fi;
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( MatElmAsString,
        "for homalg external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsPosInt, IsPosInt, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ M, "[", c, r, "]" ], "need_output", HOMALG_IO.Pictograms.MatElm );
    
end );

##
InstallMethod( MatElm,
        "for homalg external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsPosInt, IsPosInt, IsHomalgExternalRingInSingularRep ],
        
  function( M, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ M, "[", c, r, "]" ], [ "def" ], HOMALG_IO.Pictograms.MatElm );
    
    return HomalgExternalRingElement( ext_obj, R );
    
end );

####################################
#
# transfer methods:
#
####################################

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for homalg external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSingularRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "\"[\"+string(transpose(", M, "))+\"]\"" ], "need_output", HOMALG_IO.Pictograms.GetListOfHomalgMatrixAsString );
    #remark: matrices are saved transposed in singular
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for homalg external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSingularRep ],
        
  function( M, R )
    local command;
    
      command := [
          "matrix m[", NrColumns( M ),"][1];",
          "string s = \"[\";",
          "for(int i=1;i<=", NrRows( M ), ";i++){",
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
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for homalg external matrices in Singular",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSingularRep ],
        
  function( M, R )
    local s;
    
    s := homalgSendBlocking( [ "GetSparseListOfHomalgMatrixAsString(", M, ")" ], "need_output", HOMALG_IO.Pictograms.GetSparseListOfHomalgMatrixAsString );
    
    s := SplitString( s, "," );
    
    s := ListToListList( s, Length( s ) / 3, 3 );
    
    s := JoinStringsWithSeparator( List( s, JoinStringsWithSeparator ), "],[" );
    
    return Concatenation( "[[", s, "]]" );
    
end );

##
InstallMethod( SaveHomalgMatrixToFile,
        "for homalg external matrices in Singular",
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
          "for(int i=1;i<=", NrRows( M ), ";i++)",
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
        "for homalg external rings in Singular",
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
        "for homalg external matrices in Singular",
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

