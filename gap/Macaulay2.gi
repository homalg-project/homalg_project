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
            #variable_name := "o",	## a Macaulay2 specific ;-): o2 = 5 -> o1 = 5 : a = 7 -> o2 = 7 : o2 -> o3 = 5  # definition of macros spoils numbering!
            variable_name := "oo",
            CUT_POS_BEGIN := -1,	## these values are
            CUT_POS_END := -1,		## not important for Macaulay2
            eoc_verbose := "",
            eoc_quiet := ";",
            break_lists := true,		## a Macaulay2 specific
            setring := _Macaulay2_SetRing,	## a Macaulay2 specific
            setinvol := _Macaulay2_SetInvolution,## a Macaulay2 specific
            remove_enter := true,       	## a Macaulay2 specific
            only_warning := "--warning",	## a Macaulay2 specific
            define := "=",
            garbage_collector := function( stream ) homalgSendBlocking( [ "collectGarbage()" ], "need_command", stream, HOMALG_IO.Pictograms.garbage_collector ); end,
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

# a new subrepresentation of the representation IshomalgExternalObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInMacaulay2Rep",
        IshomalgExternalObjectRep,
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
InstallValue( Macaulay2Macros,
        rec(
            
    IsIdentityMatrix := "\n\
IsIdentityMatrix = M -> (\n\
  local r, R;\n\
  r = (numgens target M)-1;\n\
  R = ring M;\n\
  all(toList(0..numgens(source(M))-1), i->toList(set((entries M_i)_{0..i-1, i+1..r})) == {0_R} and entries (M^{i})_{i} == {{1_R}})\n\
);\n\n",
    
    IsDiagonalMatrix := "\n\
IsDiagonalMatrix = M -> (\n\
  local r, R;\n\
  r = (numgens target M)-1;\n\
  R = ring M;\n\
  all(toList(0..numgens(source(M))-1), i->toList(set((entries M_i)_{0..i-1, i+1..r})) == {0_R})\n\
);\n\n",
    
    ZeroRows := "\n\
ZeroRows = M -> (\n\
  local R;\n\
  R = ring M;\n\
  concatenate({\"[\"} | between(\",\", apply(\n\
    select(toList(1..(numgens target M)), i->toList(set(flatten entries M^{i-1})) == {0_R}),\n\
      toString)) | {\"]\"})\n\
);\n\n",
    
    ZeroColumns := "\n\
ZeroColumns = M -> (\n\
  local R;\n\
  R = ring M;\n\
  concatenate({\"[\"} | between(\",\", apply(\n\
    select(toList(1..(numgens source M)), i->toList(set(entries M_(i-1))) == {0_R}),\n\
      toString)) | {\"]\"})\n\
);\n\n",
    
    GetColumnIndependentUnitPositions := "\n\
GetColumnIndependentUnitPositions = (M, l) -> (\n\
  local p,r,rest;\n\
  rest = reverse toList(0..(numgens source M)-1);\n\
  concatenate({\"[\"} | between(\",\",\n\
    for j in toList(0..(numgens target M)-1) list (\n\
      r = flatten entries M^{j};\n\
      p = for i in rest list ( if not isUnit(r#i) then continue; rest = select(rest, k->zero(r#k)); break {concatenate({\"[\", toString(j+1), \",\", toString(i+1), \"]\"})});\n\
      if p == {} then continue;\n\
      p#0\n\
    )) | {\"]\"})\n\
);\n\n",
    
    GetRowIndependentUnitPositions := "\n\
GetRowIndependentUnitPositions = (M, l) -> (\n\
  local c,p,rest;\n\
  rest = reverse toList(0..(numgens target M)-1);\n\
  concatenate({\"[\"} | between(\",\",\n\
    for j in toList(0..(numgens source M)-1) list (\n\
      c = entries M_j;\n\
      p = for i in rest list ( if not isUnit(c#i) then continue; rest = select(rest, k->zero(c#k)); break {concatenate({\"[\", toString(j+1), \",\", toString(i+1), \"]\"})});\n\
      if p == {} then continue;\n\
      p#0\n\
    )) | {\"]\"})\n\
);\n\n",
    
    GetUnitPosition := "\n\
GetUnitPosition = (M, l) -> (\n\
  local i,p,rest;\n\
  rest = toList(1..(numgens source M)) - set(l);\n\
  i = 0;\n\
  for r in entries(M) list (\n\
    i = i+1;\n\
    p = for j in rest list ( if not isUnit(r#(j-1)) then continue; break {i, j} );\n\
    if p == {} then continue p;\n\
    return concatenate between(\",\", apply(p, toString))\n\
  );\n\
  \"fail\"\n\
);\n\n",
    
    GetCleanRowsPositions := "\n\
GetCleanRowsPositions = (M, l) -> (\n\
  local R;\n\
  R = ring M;\n\
  concatenate between(\",\", apply(\n\
    for i in toList(0..(numgens target M)-1) list ( if not any((flatten entries M^{i})_l, k->k == 1_R) then continue; i+1 ),\n\
      toString))\n\
);\n\n",
    
    BasisOfRowModule := "\n\
BasisOfRowModule = M -> (\n\
  local G,R;\n\
  R = ring M;\n\
  if isCommutative(R) then (\n\
    G = gens gb image matrix transpose M;\n\
    transpose(map(R^(numgens target G), R^(numgens source G), G))\n\
  )\n\
  else if isSkewCommutative(R) then (\n\
    G = gens gb image matrix transpose apply(entries M, r->apply(r, c->sum apply(terms c, a->(-1)^(binomial(sum degree(a), 2)) * a)));\n\
    L := leadTerm G;\n\
    C := apply(toList(0..(numgens source L)-1), i->leadCoefficient sum entries L_i);\n\
    map(R^(numgens source G), R^(numgens target G),\n\
      apply(toList(0..(numgens source L)-1),\n\
        transpose apply(entries G, r->apply(r, c->sum apply(terms c, a->(-1)^(binomial(sum degree(a), 2)) * a))),\n\
          (i,j)->if isConstant(C_i) and C_i < 0 then -j else j))\n\
  )\n\
  else (\n\
    error \"BasisOfRowModule is not defined for this ring\"\n\
  )\n\
);\n\n",
    # forget degrees!
    
    BasisOfColumnModule := "\n\
BasisOfColumnModule = M -> (\n\
  local G,R;\n\
  R = ring M;\n\
  G = gens gb image matrix M;\n\
  map(R^(numgens target G), R^(numgens source G), G)\n\
);\n\n",
    # forget degrees!
    
    BasisOfRowsCoeff := "\n\
BasisOfRowsCoeff = M -> (\n\
  local G,R,T;\n\
  R = ring M;\n\
  if isCommutative(R) then (\n\
    G = gb(image matrix transpose M, ChangeMatrix=>true);\n\
    T = getChangeMatrix G;\n\
    (transpose map(R^(numgens target gens G), R^(numgens source gens G), gens G),\n\
     transpose map(R^(numgens target T), R^(numgens source T), T))\n\
  )\n\
  else if isSkewCommutative(R) then (\n\
    G = gb(image matrix transpose apply(entries M, r->apply(r, c->sum apply(terms c, a->(-1)^(binomial(sum degree(a), 2)) * a))), ChangeMatrix=>true);\n\
    T = getChangeMatrix G;\n\
    L := leadTerm gens G;\n\
    C := apply(toList(0..(numgens source L)-1), i->leadCoefficient sum entries L_i);\n\
    (map(R^(numgens source L), R^(numgens target L),\n\
      apply(toList(0..(numgens source L)-1),\n\
        entries transpose apply(entries gens G, r->apply(r, c->sum apply(terms c, a->(-1)^(binomial(sum degree(a), 2)) * a))),\n\
          (i,j)->if isConstant(C_i) and C_i < 0 then -j else j)),\n\
     map(R^(numgens source T), R^(numgens target T),\n\
      apply(toList(0..(numgens source L)-1),\n\
        entries transpose apply(entries T, r->apply(r, c->sum apply(terms c, a->(-1)^(binomial(sum degree(a), 2)) * a))),\n\
          (i,j)->if isConstant(C_i) and C_i < 0 then -j else j)))\n\
  )\n\
  else (\n\
    error \"BasisOfRowsCoeff is not defined for this ring\"\n\
  )\n\
);\n\n",
    # forget degrees!
    
    BasisOfColumnsCoeff := "\n\
BasisOfColumnsCoeff = M -> (\n\
  local G,T;\n\
  G = gb(image matrix M, ChangeMatrix=>true);\n\
  T = getChangeMatrix G;\n\
  (map(R^(numgens target gens G), R^(numgens source gens G), gens G),\n\
   map(R^(numgens target T), R^(numgens source T), T))\n\
);\n\n",
    # forget degrees!
    
    DecideZeroRows := "\n\
DecideZeroRows = (A, B) -> (\n\
  Involution(remainder(matrix Involution(A), matrix Involution(B)))\n\
);\n\n",
    
    DecideZeroColumns := "\n\
DecideZeroColumns = (A, B) -> (\n\
  remainder(matrix A, matrix B)\n\
);\n\n",
    
    DecideZeroRowsEffectively := "\n\
DecideZeroRowsEffectively = (A, B) -> ( local q,r;\n\
  (q, r) = quotientRemainder(matrix Involution(A), matrix Involution(B));\n\
  (Involution(r), -Involution(q))\n\
);\n\n",
    
    DecideZeroColumnsEffectively := "\n\
DecideZeroColumnsEffectively = (A, B) -> ( local q,r;\n\
  (q, r) = quotientRemainder(matrix A, matrix B);\n\
  (r, -q)\n\
);\n\n",
    
    SyzygiesGeneratorsOfRows := "\n\
SyzygiesGeneratorsOfRows = M -> Involution(SyzygiesGeneratorsOfColumns(Involution(M)));\n\n",
    
    SyzygiesGeneratorsOfColumns := "\n\
SyzygiesGeneratorsOfColumns = M -> (\n\
  local R,S;\n\
  R = ring M;\n\
  S = syz M;\n\
  map(R^(numgens target S), R^(numgens source S), S)\n\
);\n\n",
    
    RelativeSyzygiesGeneratorsOfRows := "\n\
RelativeSyzygiesGeneratorsOfRows = (M, N) -> Involution(RelativeSyzygiesGeneratorsOfColumns(Involution(M), Involution(N)));\n\n",
    
    RelativeSyzygiesGeneratorsOfColumns := "\n\
RelativeSyzygiesGeneratorsOfColumns = (M, N) -> (\n\
  local K,R;\n\
  R = ring M;\n\
  K = mingens kernel map(cokernel N, source M, M);\n\
  map(R^(numgens target K), R^(numgens source K), K)\n\
);\n\n",

    DegreeForHomalg := "\n\
DegreeForHomalg = r -> (\n\
  if zero r then -1 else sum degree(r)\n\
);\n\n",
    # degree(0) = -infinity in Macaulay2
    
    Deg := "\n\
Deg = (r,weights,R) -> (\n\
  sum apply(toList(0..#weights-1), i->weights#i * degree(R_i, leadTerm r))\n\
);\n\n",
    # degree(x, 0) = -1 in Macaulay2
    
    MultiDeg := "\n\
MultiDeg = (r,weights,R) -> (\n\
  concatenate between( \",\", apply(apply(0..#weights-1,i->Deg(r,weights#i,R)),toString))\n\
);\n\n",
    
    DegreesOfEntries := "\n\
DegreesOfEntries = M -> (\n\
  concatenate between(\",\", apply(\n\
    flatten apply(entries M, i->apply(i, DegreeForHomalg)),\n\
      toString))\n\
);\n\n",
    
    WeightedDegreesOfEntries := "\n\
WeightedDegreesOfEntries = (M,weights,R) -> (\n\
  concatenate between(\",\", apply(\n\
    flatten apply(entries M, i->apply(i, j->Deg(j,weights,R))),\n\
      toString))\n\
);\n\n",
    
    NonTrivialDegreePerRow := "\n\
NonTrivialDegreePerRow = M -> ( local n,p;\n\
  n = numgens(source M)-1;\n\
  concatenate between(\",\", apply(\n\
    for r in entries(M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {sum degree r#j} );\n\
      if p == {} then 0 else p#0\n\
    ), toString))\n\
)\n\n",
    
    NonTrivialWeightedDegreePerRow := "\n\
NonTrivialWeightedDegreePerRow = (M,weights,R) -> ( local n,p;\n\
  n = numgens(source M)-1;\n\
  concatenate between(\",\", apply(\n\
    for r in entries(M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {Deg(r#j,weights,R)} );\n\
      if p == {} then 0 else p#0\n\
    ), toString))\n\
)\n\n",
    
    NonTrivialDegreePerRowWithColPosition := "\n\
NonTrivialDegreePerRowWithColPosition = M -> ( local n,p;\n\
  n = numgens(source M)-1;\n\
  concatenate({\"[\"} | between(\",\",\n\
    for r in entries(M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {concatenate({\"[\", toString(sum degree r#j), \",\", toString(j+1), \"]\"})} );\n\
      if p == {} then \"[0,0]\" else p#0\n\
    )) | {\"]\"})\n\
)\n\n",
    
    NonTrivialWeightedDegreePerRowWithColPosition := "\n\
NonTrivialWeightedDegreePerRowWithColPosition = (M,weights,R) -> ( local n,p;\n\
  n = numgens(source M)-1;\n\
  concatenate({\"[\"} | between(\",\",\n\
    for r in entries(M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {concatenate({\"[\", toString(Deg(r#j,weights,R)), \",\", toString(j+1), \"]\"})} );\n\
      if p == {} then \"[0,0]\" else p#0\n\
    )) | {\"]\"})\n\
)\n\n",
    
    NonTrivialDegreePerColumn := "\n\
NonTrivialDegreePerColumn = M -> ( local n,p;\n\
  n = numgens(target M)-1;\n\
  concatenate between(\",\", apply(\n\
    for r in entries(transpose M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {sum degree r#j} );\n\
      if p == {} then 0 else p#0\n\
    ), toString))\n\
)\n\n",
    
    NonTrivialWeightedDegreePerColumn := "\n\
NonTrivialWeightedDegreePerColumn = (M,weights,R) -> ( local n,p;\n\
  n = numgens(target M)-1;\n\
  concatenate between(\",\", apply(\n\
    for r in entries(transpose M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {Deg(r#j,weights,R)} );\n\
      if p == {} then 0 else p#0\n\
    ), toString))\n\
)\n\n",
    
    NonTrivialDegreePerColumnWithRowPosition := "\n\
NonTrivialDegreePerColumnWithRowPosition = M -> ( local n,p;\n\
  n = numgens(target M)-1;\n\
  concatenate({\"[\"} | between(\",\",\n\
    for r in entries(transpose M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {concatenate({\"[\", toString(sum degree r#j), \",\", toString(j+1), \"]\"})} );\n\
      if p == {} then \"[0,0]\" else p#0\n\
    )) | {\"]\"})\n\
)\n\n",
    
    NonTrivialWeightedDegreePerColumnWithRowPosition := "\n\
NonTrivialWeightedDegreePerColumnWithRowPosition = (M,weights,R) -> ( local n,p;\n\
  n = numgens(target M)-1;\n\
  concatenate({\"[\"} | between(\",\",\n\
    for r in entries(transpose M) list (\n\
      p = for j in toList(0..n) list ( if zero(r#j) then continue; break {concatenate({\"[\", toString(Deg(r#j,weights,R)), \",\", toString(j+1), \"]\"})} );\n\
      if p == {} then \"[0,0]\" else p#0\n\
    )) | {\"]\"})\n\
)\n\n",
    
    )
);

##
InstallGlobalFunction( InitializeMacaulay2Macros,
  function( stream )
    
    InitializeMacros( Macaulay2Macros, stream );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInMacaulay2,
  function( arg )
    local nargs, stream, o, ar, ext_obj, R, RP;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Macaulay2 );
        o := 0;
    else
        o := 1;
    fi;
    
    InitializeMacaulay2Macros( stream );
    
    ar := [ arg[1], TheTypeHomalgExternalRingObjectInMacaulay2, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMacaulay2 );
    
    _Macaulay2_SetRing( R );
    
    RP := homalgTable( R );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( "\nInvolution = transpose;\n\n", "need_command", R, HOMALG_IO.Pictograms.define );
    end;
    
    RP!.SetInvolution( R );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInMacaulay2,
  function( arg )
    local nargs, l, c, R;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsInt( arg[1] ) and arg[1] <> 0 then
        l := 2;
        ## characteristic:
        c := AbsInt( arg[1] );
        R :=  [ "ZZ / ", c ];
    else
        if nargs > 0 and arg[1] = 0 then
            l := 2;
        else
            l := 1;
        fi;
        ## characteristic:
        c := 0;
	R := [ "ZZ" ];
    fi;
    
    if not ( IsZero( c ) or IsPrime( c ) ) then
        Error( "the ring Z/", c, "Z (", c, " non-prime) is not yet supported for Macaulay2!\nUse the generic residue class ring constructor '/' provided by homalg after defining the ambient ring (over the integers)\nfor help type: ?homalg: constructor for residue class rings\n" );
    fi;
    
    R := Concatenation( [ R, IsPrincipalIdealRing ], arg{[ l .. nargs ]} );
    
    R := CallFuncList( RingForHomalgInMacaulay2, R );
    
    SetIsResidueClassRingOfTheIntegers( R, true );
    
    SetRingProperties( R, c );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInMacaulay2,
  function( arg )
    local R;
    
    R := "QQ";
    
    R := Concatenation( [ R ], [ IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInMacaulay2, R );
    
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
    if HasIndeterminatesOfPolynomialRing( R ) then
        ext_obj := homalgSendBlocking( [ "(coefficientRing ", R, ")[", var, "]" ], TheTypeHomalgExternalRingObjectInMacaulay2, properties, HOMALG_IO.Pictograms.CreateHomalgRing );
    else
        ext_obj := homalgSendBlocking( [ R, "[", var, "]" ], TheTypeHomalgExternalRingObjectInMacaulay2, properties, HOMALG_IO.Pictograms.CreateHomalgRing );
    fi;
    
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
InstallMethod( RingOfDerivations,
        "for homalg rings in Macaulay2",
        [ IsHomalgExternalRingInMacaulay2Rep, IsList ],
        
  function( R, indets )
    local ar, var, der, stream, display_color, ext_obj, S, RP,
      BasisOfRowModule, BasisOfRowsCoeff;
    
    ar := _PrepareInputForRingOfDerivations( R, indets );
    
    var := ar[1];
    der := ar[2];
    
    stream := homalgStream( R );
    
    homalgSendBlocking( "needs \"Dmodules.m2\"", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    ## create the new ring
    if HasIndeterminatesOfPolynomialRing( R ) then
        ext_obj := homalgSendBlocking( Concatenation( [ "(coefficientRing ", R, ")[", var, der, ",WeylAlgebra => {" ], [ JoinStringsWithSeparator( ListN( var, der, function(i, j) return Concatenation( i, "=>", j ); end ) ) ], [ "}]" ] ), TheTypeHomalgExternalRingObjectInMacaulay2, HOMALG_IO.Pictograms.CreateHomalgRing );
    else
        ext_obj := homalgSendBlocking( Concatenation( [ R, "[", var, der, ",WeylAlgebra => {" ], [ JoinStringsWithSeparator( ListN( var, der, function(i, j) return Concatenation( i, "=>", j ); end ) ) ], [ "}]" ] ), TheTypeHomalgExternalRingObjectInMacaulay2, HOMALG_IO.Pictograms.CreateHomalgRing );
    fi;
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMacaulay2 );
    
    der := List( der, a -> HomalgExternalRingElement( a, S ) );
    
    Perform( der, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsWeylRing( S, true );
    
    SetBaseRing( S, R );
    
    SetRingProperties( S, R, der );
    
    _Macaulay2_SetRing( S );
    
    RP := homalgTable( S );
    
    #RP!.SetInvolution :=
    #  function( R )
    #    homalgSendBlocking( [ "\nInvolution = M -> transpose Dtransposition M;\n\n" ], "need_command", R, HOMALG_IO.Pictograms.define );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( [ "\nInvolution = M -> ( local R,T; R = ring M; T = Dtransposition M; transpose map(R^(numgens target T), R^(numgens source T), T) )\n\n" ], "need_command", R, HOMALG_IO.Pictograms.define );
    # forget degrees!
    end;
    
    # load Dmodules.m2 before using Dtransposition!
    BasisOfRowModule := "\n\
BasisOfRowModule = M -> (\n\
  local G,R;\n\
  R = ring M;\n\
  if isCommutative(R) then (\n\
    G = gens gb image matrix transpose M;\n\
    transpose(map(R^(numgens target G), R^(numgens source G), G))\n\
  )\n\
  else if isSkewCommutative(R) then (\n\
    G = gens gb image matrix transpose apply(entries M, r->apply(r, c->sum apply(terms c, a->(-1)^(binomial(sum degree(a), 2)) * a)));\n\
    L := leadTerm G;\n\
    C := apply(toList(0..(numgens source L)-1), i->leadCoefficient sum entries L_i);\n\
    map(R^(numgens source G), R^(numgens target G),\n\
      apply(toList(0..(numgens source L)-1),\n\
        transpose apply(entries G, r->apply(r, c->sum apply(terms c, a->(-1)^(binomial(sum degree(a), 2)) * a))),\n\
          (i,j)->if isConstant(C_i) and C_i < 0 then -j else j))\n\
  )\n\
  else (\n\
    G = gens gb image matrix transpose Dtransposition M;\n\
    L := leadTerm G;\n\
    C := apply(toList(0..(numgens source L)-1), i->leadCoefficient sum entries L_i);\n\
    map(R^(numgens source G), R^(numgens target G),\n\
      apply(toList(0..(numgens source L)-1),\n\
        entries transpose Dtransposition G,\n\
          (i,j)->if isConstant(C_i) and C_i < 0 then -j else j))\n\
  )\n\
);\n\n";
    
    BasisOfRowsCoeff := "\n\
BasisOfRowsCoeff = M -> (\n\
  local G,R,T;\n\
  R = ring M;\n\
  if isCommutative(R) then (\n\
    G = gb(image matrix transpose M, ChangeMatrix=>true);\n\
    T = getChangeMatrix G;\n\
    (transpose map(R^(numgens target gens G), R^(numgens source gens G), gens G),\n\
     transpose map(R^(numgens target T), R^(numgens source T), T))\n\
  )\n\
  else if isSkewCommutative(R) then (\n\
    G = gb(image matrix transpose apply(entries M, r->apply(r, c->sum apply(terms c, a->(-1)^(binomial(sum degree(a), 2)) * a))), ChangeMatrix=>true);\n\
    T = getChangeMatrix G;\n\
    L := leadTerm gens G;\n\
    C := apply(toList(0..(numgens source L)-1), i->leadCoefficient sum entries L_i);\n\
    (map(R^(numgens source L), R^(numgens target L),\n\
      apply(toList(0..(numgens source L)-1),\n\
        entries transpose apply(entries gens G, r->apply(r, c->sum apply(terms c, a->(-1)^(binomial(sum degree(a), 2)) * a))),\n\
          (i,j)->if isConstant(C_i) and C_i < 0 then -j else j)),\n\
     map(R^(numgens source T), R^(numgens target T),\n\
      apply(toList(0..(numgens source L)-1),\n\
        entries transpose apply(entries T, r->apply(r, c->sum apply(terms c, a->(-1)^(binomial(sum degree(a), 2)) * a))),\n\
          (i,j)->if isConstant(C_i) and C_i < 0 then -j else j)))\n\
  )\n\
  else (\n\
    G = gb(image matrix transpose Dtransposition M, ChangeMatrix=>true);\n\
    T = getChangeMatrix G;\n\
    L := leadTerm gens G;\n\
    C := apply(toList(0..(numgens source L)-1), i->leadCoefficient sum entries L_i);\n\
    (map(R^(numgens source L), R^(numgens target L),\n\
      apply(toList(0..(numgens source L)-1),\n\
        entries transpose Dtransposition gens G,\n\
          (i,j)->if isConstant(C_i) and C_i < 0 then -j else j)),\n\
     map(R^(numgens source T), R^(numgens target T),\n\
      apply(toList(0..(numgens source L)-1),\n\
        entries transpose Dtransposition T,\n\
          (i,j)->if isConstant(C_i) and C_i < 0 then -j else j)))\n\
  )\n\
);\n\n";
    
    homalgSendBlocking( BasisOfRowModule, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfRowsCoeff, "need_command", stream, HOMALG_IO.Pictograms.define );
    
    RP!.SetInvolution( S );
    
    return S;
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings in Macaulay2",
        [ IsHomalgExternalRingInMacaulay2Rep, IsHomalgExternalRingInMacaulay2Rep, IsList ],
        
  function( R, T, indets )
    local ar, var, anti, comm, stream, display_color, ext_obj, constructor, S, RP;
    
    ar := _PrepareInputForExteriorRing( R, T, indets );
    
    var := ar[1];
    anti := ar[2];
    comm := ar[3];
    
    stream := homalgStream( R );
    
    ## create the new ring
    if HasIndeterminatesOfPolynomialRing( T ) then
        # create the new ring in one go in order to ensure standard grading
        ext_obj := homalgSendBlocking( [ "(coefficientRing ", T, ")[", comm, anti, ",SkewCommutative => {", [ Length( comm )..( Length( comm ) + Length( anti ) - 1 ) ], "}]" ], TheTypeHomalgExternalRingObjectInMacaulay2, HOMALG_IO.Pictograms.CreateHomalgRing );
    else
        ext_obj := homalgSendBlocking( [ T, "[", anti, ",SkewCommutative => true]" ], TheTypeHomalgExternalRingObjectInMacaulay2, HOMALG_IO.Pictograms.CreateHomalgRing );
    fi;
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMacaulay2 );

    anti := List( anti , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( anti, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    comm := List( comm , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( comm, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsExteriorRing( S, true );
    
    if HasBaseRing( R ) and IsIdenticalObj( BaseRing( R ), T ) then
        SetBaseRing( S, T );
    fi;
    
    SetRingProperties( S, R, anti );
    
    _Macaulay2_SetRing( S );
    
    RP := homalgTable( S );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( [ "\nInvolution = M -> ( local R; R = ring M; transpose map(R^(numgens target M), R^(numgens source M), apply(entries M, r->apply(r, c->sum apply(terms c, a->(-1)^(binomial(sum degree(a), 2)) * a)))) )\n\n" ], "need_command", R, HOMALG_IO.Pictograms.define );
    end;
    
    RP!.SetInvolution( S );
    
    RP!.Compose :=
      function( A, B )
        
        return homalgSendBlocking( [ "Involution( Involution(", B, ") * Involution(", A, ") )" ], HOMALG_IO.Pictograms.Compose );
        
    end;
    
    return S;
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for external matrices in Macaulay2",
        [ IsHomalgExternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsString, IsHomalgExternalRingInMacaulay2Rep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, " = ", M, "_{0..(", c, "-2)} | map(target ", M, ", ", R, "^1, apply(toList(1..(numgens target ", M, ")), entries ", M, "_(", c, "-1), (k,l)->if k == ", r, " then {", s, "} else {l})) | ", M, "_{", c, "..(numgens source ", M, ")-1}" ], "need_command", HOMALG_IO.Pictograms.SetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "for homalg matrices in Macaulay2",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMacaulay2Rep ],
        
  function( s, r, c, R )
    local ext_obj, S;
    
    S := ShallowCopy( s );
    RemoveCharacters(S, "[]");
    ext_obj := homalgSendBlocking( [ "map(", R, "^", r, R, "^", c, ", pack(", c, ", {", S, "}))" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
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
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "(entries ", M, "^{", r - 1, "}_{", c - 1, "})#0#0" ], HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
    return HomalgExternalRingElement( ext_obj, R );
    
end );

##
InstallMethod( homalgSetName,
        "for homalg ring elements",
        [ IsHomalgExternalRingElementRep, IsString, IsHomalgExternalRingInMacaulay2Rep ],
        
  function( r, name, R )
    
    SetName( r, homalgSendBlocking( [ "toString(", r, ")" ], "need_output", HOMALG_IO.Pictograms.homalgSetName ) );
    
end );

##
InstallMethod( MatrixOfWeightsOfIndeterminates,
        "for external matrices in Macaulay2",
        [ IsHomalgExternalRingInMacaulay2Rep and HasWeightsOfIndeterminates ],
        
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
    
    ext_obj := homalgSendBlocking( [ "pack(", n, ",{", degrees, "})"  ], "break_lists", R, HOMALG_IO.Pictograms.CreateList );
    
    return HomalgMatrix( ext_obj, m, n, R );
    
end );

####################################
#
# transfer methods:
#
####################################

##
InstallMethod( SaveHomalgMatrixToFile,
        "for external matrices in Macaulay2",
        [ IsString, IsHomalgMatrix, IsHomalgExternalRingInMacaulay2Rep ],
        
  function( filename, M, R )
    local mode, command;
    
    if not IsBound( M!.SaveAs ) then
        mode := "ListList";
    else
        mode := M!.SaveAs; #not yet supported
    fi;
    
    if mode = "ListList" then

        command := [
	  "homalgsavefile = \"", filename, "\" << \"\";",
	  "homalgsavefile << concatenate({\"[[\"} | between(\"],[\", apply(entries ", M, ", i->( local s; s = toString(i); substring(s, 1, length(s)-2) ))) | {\"]]\"});",
          "homalgsavefile << close;"
        ];

        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.SaveHomalgMatrixToFile );

    fi;
    
    return true;
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for external rings in Macaulay2",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMacaulay2Rep ],
        
  function( filename, r, c, R )
    local mode, command, M;
    
    if not IsBound( R!.LoadAs ) then
        mode := "ListList";
    else
        mode := R!.LoadAs; #not yet supported
    fi;
    
    M := HomalgVoidMatrix( R );
    
    if mode = "ListList" then
        
        command := [ M, "=map(", R, "^", r, R, "^", c,
	             ", toList(apply(",
		     "value replace(\"[\\\\]\", \"\", get \"", filename, "\"), toList)));" ];
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.LoadHomalgMatrixFromFile );
        
    fi;
    
    SetNrRows( M, r );
    SetNrColumns( M, c );
    
    return M;
    
end );

##
InstallMethod( Display,
        "for homalg matrices in Singular",
        [ IsHomalgExternalMatrixRep ], 1,
        
  function( o )
    
    if IsHomalgExternalRingInMacaulay2Rep( HomalgRing( o ) ) then
        
        Print( "        ", homalgSendBlocking( [ o ], "need_display", HOMALG_IO.Pictograms.Display ) );
        
    else
        
        TryNextMethod( );
        
    fi;
    
end );

##
InstallMethod( DisplayRing,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInMacaulay2Rep ], 1,
        
  function( o )
    
    homalgDisplay( [ "describe ", o ] );
    
end );

