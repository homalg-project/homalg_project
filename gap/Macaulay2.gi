#############################################################################
##
##  Macaulay2.gi              RingsForHomalg package          Daniel Robertz
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system Macaulay2.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_Macaulay2,
        rec(
            cas := "macaulay2",		## normalized name on which the user should have no control
            name := "Macaulay2",
            executable := "M2",
            options := [ "--no-prompts", "--no-readline", "--print-width", "80" ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            SEARCH_READY_TWICE := true,	## a Macaulay2 specific
            variable_name := "o",	## a Macaulay2 specific ;-): o2 = 5 -> o1 = 5 : a = 7 -> o2 = 7 : o2 -> o3 = 5
            CUT_POS_BEGIN := -1,	## these values are
            CUT_POS_END := -1,		## not important for Macaulay2
            eoc_verbose := "",
            eoc_quiet := ";",
            setring := _Macaulay2_SetRing,	## a Macaulay2 specific
            setinvol := _Macaulay2_SetInvolution,## a Macaulay2 specific
            define := "=",
            prompt := "\033[01mM2>\033[0m ",
            output_prompt := "\033[1;30;43m<M2\033[0m ",
            banner := function( s ) Remove( s.errors, Length( s.errors ) ); Print( s.errors ); end,
           )
);
            
HOMALG_IO_Macaulay2.READY_LENGTH := Length( HOMALG_IO_Macaulay2.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalObjectWithIOStreamRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInMacaulay2Rep",
        IshomalgExternalObjectWithIOStreamRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInMacaulay2Rep",
        IsHomalgExternalRingRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeHomalgExternalRingObjectInMacaulay2",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMacaulay2Rep ) );

# a new type:
BindGlobal( "TheTypeHomalgExternalRingInMacaulay2",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInMacaulay2Rep ) );

####################################
#
# global functions:
#
####################################

##
InstallGlobalFunction( _Macaulay2_SetRing,
  function( R )
    local stream;
    
    stream := homalgStream( R );
    
    ## since _Macaulay2_SetRing might be called from homalgSendBlocking,
    ## we first set the new active ring to avoid infinite loops:
    stream.active_ring := R;
    
    homalgSendBlocking( [ "use ", R ], "need_command", HOMALG_IO.Pictograms.initialize );
    
end );

##
InstallGlobalFunction( _Macaulay2_SetInvolution,
  function( R )
    local RP;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.SetInvolution ) then
        RP!.SetInvolution( R );
    fi;
    
end );

##
InstallGlobalFunction( InitializeMacaulay2Tools,
  function( stream )
    local GetColumnIndependentUnitPositions, GetRowIndependentUnitPositions,
          IsIdentityMatrix, IsDiagonalMatrix,
          ZeroRows, ZeroColumns, GetUnitPosition, GetCleanRowsPositions,
          BasisOfRowModule, BasisOfColumnModule,
          BasisOfRowsCoeff, BasisOfColumnsCoeff,
          DecideZeroRows, DecideZeroColumns,
          DecideZeroRowsEffectively, DecideZeroColumnsEffectively,
          SyzForHomalg,
          SyzygiesGeneratorsOfRows, SyzygiesGeneratorsOfRows2,
          SyzygiesGeneratorsOfColumns, SyzygiesGeneratorsOfColumns2,
          Deg, MultiDeg,
          DegreesOfEntries, WeightedDegreesOfEntries,
          MultiWeightedDegreesOfEntries,
          NonTrivialDegreePerRow, NonTrivialWeightedDegreePerRow,
          NonTrivialMultiWeightedDegreePerRow,
          NonTrivialDegreePerRowWithColPosition,
          NonTrivialWeightedDegreePerRowWithColPosition,
          NonTrivialMultiWeightedDegreePerRowWithColPosition,
          NonTrivialDegreePerColumn, NonTrivialWeightedDegreePerColumn,
          NonTrivialMultiWeightedDegreePerColumn,
          NonTrivialDegreePerColumnWithRowPosition,
          NonTrivialWeightedDegreePerColumnWithRowPosition,
          NonTrivialMultiWeightedDegreePerColumnWithRowPosition;
    
    IsIdentityMatrix := "\n\
IsIdentityMatrix = M -> (\n\
  local r, R;\n\
  r = (numgens target M)-1;\n\
  R = ring M;\n\
  all(toList(0..numgens(source(M))-1), i->toList(set((entries M_i)_{0..i-1, i+1..r})) == {0_R} and entries (M^{i})_{i} == {{1_R}})
);\n\n";
    
    IsDiagonalMatrix := "\n\
IsDiagonalMatrix = M -> (\n\
  local r, R;\n\
  r = (numgens target M)-1;\n\
  R = ring M;\n\
  all(toList(0..numgens(source(M))-1), i->toList(set((entries M_i)_{0..i-1, i+1..r})) == {0_R})
);\n\n";
    
    ZeroRows := "\n\
ZeroRows = M -> (\n\
  local R;\n\
  R = ring M;\n\
  concatenate between(\",\", apply(\n\
    select(toList(1..(numgens target M)), i->toList(set(flatten entries M^{i-1})) == {0_R}),\n\
      toString))\n\
);\n\n";
    
    ZeroColumns := "\n\
ZeroColumns = M -> (\n\
  local R;\n\
  R = ring M;\n\
  concatenate between(\",\", apply(\n\
    select(toList(1..(numgens source M)), i->toList(set(entries M_(i-1))) == {0_R}),\n\
      toString))\n\
);\n\n";
    
    GetColumnIndependentUnitPositions := "\n\
GetColumnIndependentUnitPositions = (M, l) -> (\n\
  local p,r,rest;\n\
  rest = reverse toList(0..(numgens source M)-1);\n\
  concatenate between(\",\", apply(\n\
    for j in toList(0..(numgens target M)-1) list (\n\
      r = flatten entries M^{j};\n\
      p = for i in rest list ( if not isUnit(r#i) then continue; rest = select(rest, k->r#k == 0); break {j+1, i+1} );\n\
      if p == {} then continue;\n\
      p\n\
    ), toString))\n\
);\n\n";
    
    GetRowIndependentUnitPositions := "\n\
GetRowIndependentUnitPositions = (M, l) -> (\n\
  local c,p,rest;\n\
  rest = reverse toList(0..(numgens target M)-1);\n\
  concatenate between(\",\", apply(\n\
    for j in toList(0..(numgens source M)-1) list (\n\
      c = entries M_j;\n\
      p = for i in rest list ( if not isUnit(c#i) then continue; rest = select(rest, k->c#k == 0); break {i+1, j+1} );\n\
      if p == {} then continue;\n\
      p\n\
    ), toString))\n\
);\n\n";
    
    GetUnitPosition := "\n\
GetUnitPosition = (M, pos_list) -> (\n\
  local i,p,rest;\n\
  rest = toList(1..(numgens source M)) - set(pos_list);\n\
  i = 0;\n\
  for r in entries(M) list (\n\
    i = i+1;\n\
    p = for j in rest list ( if not isUnit(r#(j-1)) then continue; break {i, j} );\n\
    if p == {} then continue p;\n\
    return concatenate between(\",\", apply(p, toString))\n\
  );\n\
  \"fail\"\n\
);\n\n";
    
    GetCleanRowsPositions := "\n\
GetCleanRowsPositions = (M, l) -> (\n\
  local R;\n\
  R = ring M;\n\
  concatenate between(\",\", apply(\n\
    for i in toList(0..(numgens target M)-1) list ( if not any(flatten entries M^{i}, k->k == 1_R) then continue; i+1 ),\n\
      toString))\n\
);\n\n";
    
    BasisOfRowModule := "\n\
BasisOfRowModule = M -> entries gens gb image matrix transpose M;\n\n";
    
    BasisOfColumnModule := "\n\
BasisOfColumnModule = M -> entries gens gb image matrix M;\n\n";
    
#    ## according to the documentation B=M*T in the commutative case, but it somehow does not work :(
#    ## and for plural to work one would need to define B=transpose(transpose(T)*transpose(M)), which is expensive!!
#    BasisOfRowsCoeff := "\n\
#proc BasisOfRowsCoeff (matrix M)\n\
#{\n\
#  matrix T;\n\
#  matrix B = matrix(liftstd(M,T));\n\
#  list l = transpose(transpose(T)*transpose(M)),T;\n\
#  return(l)\n\
#}\n\n";
    
    BasisOfRowsCoeff := "\n\
proc BasisOfRowsCoeff (matrix M)\n\
{\n\
  matrix B = std(M);\n\
  matrix T = lift(M,B); //never use stdlift, also because it might differ from std!!!\n\
  list l = B,T;\n\
  return(l)\n\
}\n\n";
    
    BasisOfColumnsCoeff := "\n\
proc BasisOfColumnsCoeff (matrix M)\n\
{\n\
  list l = BasisOfRowsCoeff(Involution(M));\n\
  matrix B = l[1];\n\
  matrix T = l[2];\n\
  l = Involution(B),Involution(T);\n\
  return(l);\n\
}\n\n";
    
    DecideZeroRows := "\n\
proc DecideZeroRows (matrix A, matrix B)\n\
{\n\
  return(reduce(A,B));\n\
}\n\n";
    
    DecideZeroColumns := "\n\
proc DecideZeroColumns (matrix A, matrix B)\n\
{\n\
  return(Involution(reduce(Involution(A),Involution(B))));\n\
}\n\n";
    
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
}\n\n";
    
    DecideZeroColumnsEffectively := "\n\
proc DecideZeroColumnsEffectively (matrix A, matrix B)\n\
{\n\
  list l = DecideZeroRowsEffectively(Involution(A),Involution(B));\n\
  matrix B = l[1];\n\
  matrix T = l[2];\n\
  l = Involution(B),Involution(T);\n\
  return(l);\n\
}\n\n";
    
    SyzForHomalg := "\n\
proc SyzForHomalg (matrix M)\n\
{\n\
  list l = nres(M,2);\n\
  return(matrix(l[2]));\n\
  // return(syz(M));\n\
}\n\n";
    
    SyzygiesGeneratorsOfRows := "\n\
proc SyzygiesGeneratorsOfRows (matrix M)\n\
{\n\
  return(SyzForHomalg(M));\n\
}\n\n";
    
    SyzygiesGeneratorsOfRows2 := "\n\
proc SyzygiesGeneratorsOfRows2 (matrix M1, matrix M2)\n\
{\n\
  int r = nrows(M1);\n\
  int c1 = ncols(M1);\n\
  int c2 = ncols(M2);\n\
  matrix M[r][c1+c2] = concat(M1,M2);\n\
  matrix s = SyzForHomalg(M);\n\
  s = submat(s,1..c1,1..ncols(s));\n\
  return(std(s));\n\
}\n\n";
    
    SyzygiesGeneratorsOfColumns := "\n\
proc SyzygiesGeneratorsOfColumns (matrix M)\n\
{\n\
  return(Involution(SyzForHomalg(Involution(M))));\n\
}\n\n";
    
    SyzygiesGeneratorsOfColumns2 := "\n\
proc SyzygiesGeneratorsOfColumns2 (matrix M1, matrix M2)\n\
{\n\
  return(Involution(SyzygiesGeneratorsOfRows2(Involution(M1),Involution(M2))));\n\
}\n\n";
    
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
kill r;\n\n";
    
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
}\n\n";
    
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
}\n\n";
    
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
}\n\n";
    
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
}\n\n";
    
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
}\n\n";
    
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
}\n\n";
    
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
}\n\n";
    
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
}\n\n";
    
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
}\n\n";
    
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
}\n\n";
    
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
}\n\n";
    
    homalgSendBlocking( IsIdentityMatrix, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( IsDiagonalMatrix, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( ZeroRows, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( ZeroColumns, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( GetColumnIndependentUnitPositions, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( GetRowIndependentUnitPositions, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( GetUnitPosition, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( GetCleanRowsPositions, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfRowModule, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfColumnModule, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( BasisOfRowsCoeff, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( BasisOfColumnsCoeff, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( DecideZeroRows, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( DecideZeroColumns, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( DecideZeroRowsEffectively, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( DecideZeroColumnsEffectively, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( SyzForHomalg, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( SyzygiesGeneratorsOfRows, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( SyzygiesGeneratorsOfRows2, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( SyzygiesGeneratorsOfColumns, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( SyzygiesGeneratorsOfColumns2, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( Deg, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( MultiDeg, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( DegreesOfEntries, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( WeightedDegreesOfEntries, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( NonTrivialDegreePerRow, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( NonTrivialWeightedDegreePerRow, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( NonTrivialDegreePerRowWithColPosition, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( NonTrivialWeightedDegreePerRowWithColPosition, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( NonTrivialDegreePerColumn, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( NonTrivialWeightedDegreePerColumn, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( NonTrivialDegreePerColumnWithRowPosition, "need_command", stream, HOMALG_IO.Pictograms.define );
#    homalgSendBlocking( NonTrivialWeightedDegreePerColumnWithRowPosition, "need_command", stream, HOMALG_IO.Pictograms.define );
    
  end
);

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInMacaulay2,
  function( arg )
    local nargs, stream, o, ar, ext_obj, R;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Macaulay2 );
        o := 0;
    else
        o := 1;
    fi;
    
    InitializeMacaulay2Tools( stream );
    
    ar := [ arg[1], TheTypeHomalgExternalRingObjectInMacaulay2, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMacaulay2 );
    
    _Macaulay2_SetRing( R );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInMacaulay2,
  function( arg )
    local nargs, stream, m, c, R;
    
    nargs := Length( arg );
    
    if nargs > 0 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if nargs = 0 or arg[1] = 0 or ( nargs = 1 and IsBound( stream ) ) then
        m := 0;
        c := 0;
    elif IsInt( arg[1] ) then
        m := AbsInt( arg[1] );
        c := m;
    else
        Error( "the first argument must be an integer\n" );
    fi;
    
    if not ( IsZero( c ) or IsPrime( c ) ) then
        Error( "the ring Z/", c, "Z (", c, " non-prime) is not yet supported for Macaulay2!\nUse the generic residue class ring constructor '/' provided by homalg after defining the ambient ring (over the integers)\nfor help type: ?homalg: constructor for residue class rings\n" );
    fi;
    
    if IsBound( stream ) then
        R := RingForHomalgInMacaulay2( [ "ZZ / ", m ], IsPrincipalIdealRing, stream );
    else
        R := RingForHomalgInMacaulay2( [ "ZZ / ", m ], IsPrincipalIdealRing );
    fi;
    
    SetIsResidueClassRingOfTheIntegers( R, true );
    
    SetRingProperties( R, c );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInMacaulay2,
  function( arg )
    local ar, R;
    
    ar := Concatenation( [ "QQ" ], [ IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInMacaulay2, ar );
    
    SetIsFieldForHomalg( R, true );
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings in Macaulay2",
        [ IsHomalgExternalRingInMacaulay2Rep, IsList ],
        
  function( R, indets )
    local ar, r, var, properties, ext_obj, S, RP;
    
    ar := _PrepareInputForPolynomialRing( R, indets );
    
    r := ar[1];
    var := ar[2];
    properties := ar[3];
    
    ## create the new ring
    ext_obj := homalgSendBlocking( [ R, "[", var, "]" ], "break_lists", TheTypeHomalgExternalRingObjectInMacaulay2, properties,  HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMacaulay2 );
    
    var := List( var, a -> HomalgExternalRingElement( a, S ) );
    
    Perform( var, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsFreePolynomialRing( S, true );
    
    if HasIndeterminatesOfPolynomialRing( R ) and IndeterminatesOfPolynomialRing( R ) <> [ ] then
        SetBaseRing( S, R );
    fi;
    
    SetRingProperties( S, r, var );
    
    _Macaulay2_SetRing( R );
    
    return S;
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "for homalg matrices in Macaulay2",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMacaulay2Rep ],
        
  function( s, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "map(", R, "^", r, R, "^", c, ",", s, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for external matrices in Macaulay2",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInMacaulay2Rep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ "(entries ", M, "^{", r - 1, "}_{", c - 1, "})#0#0" ], "need_output", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for external matrices in Macaulay2",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInMacaulay2Rep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ "(entries ", M, "^{", r - 1, "}_{", c - 1, "})#0#0" ], "return_ring_element", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

