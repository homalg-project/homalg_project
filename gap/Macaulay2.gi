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
            setring := _Macaulay2_SetRing,	## a Macaulay2 specific
            setinvol := _Macaulay2_SetInvolution,## a Macaulay2 specific
            only_warning := "--warning",	## a Macaulay2 specific
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
          SyzygiesGeneratorsOfRows, SyzygiesGeneratorsOfRows2,
          SyzygiesGeneratorsOfColumns, SyzygiesGeneratorsOfColumns2;
    
    IsIdentityMatrix := "\n\
IsIdentityMatrix = M -> (\n\
  local r, R;\n\
  r = (numgens target M)-1;\n\
  R = ring M;\n\
  all(toList(0..numgens(source(M))-1), i->toList(set((entries M_i)_{0..i-1, i+1..r})) == {0_R} and entries (M^{i})_{i} == {{1_R}})\n\
);\n\n";
    
    IsDiagonalMatrix := "\n\
IsDiagonalMatrix = M -> (\n\
  local r, R;\n\
  r = (numgens target M)-1;\n\
  R = ring M;\n\
  all(toList(0..numgens(source(M))-1), i->toList(set((entries M_i)_{0..i-1, i+1..r})) == {0_R})\n\
);\n\n";
    
    ZeroRows := "\n\
ZeroRows = M -> (\n\
  local R;\n\
  R = ring M;\n\
  concatenate({\"[\"} | between(\",\", apply(\n\
    select(toList(1..(numgens target M)), i->toList(set(flatten entries M^{i-1})) == {0_R}),\n\
      toString)) | {\"]\"})\n\
);\n\n";
    
    ZeroColumns := "\n\
ZeroColumns = M -> (\n\
  local R;\n\
  R = ring M;\n\
  concatenate({\"[\"} | between(\",\", apply(\n\
    select(toList(1..(numgens source M)), i->toList(set(entries M_(i-1))) == {0_R}),\n\
      toString)) | {\"]\"})\n\
);\n\n";
    
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
);\n\n";
    
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
);\n\n";
    
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
);\n\n";
    
    GetCleanRowsPositions := "\n\
GetCleanRowsPositions = (M, l) -> (\n\
  local R;\n\
  R = ring M;\n\
  concatenate between(\",\", apply(\n\
    for i in toList(0..(numgens target M)-1) list ( if not any((flatten entries M^{i})_l, k->k == 1_R) then continue; i+1 ),\n\
      toString))\n\
);\n\n";
    
    BasisOfRowModule := "\n\
BasisOfRowModule = M -> (\n\
  local G,R;\n\
  R = ring M;\n\
  G = gens gb image matrix transpose M;\n\
  transpose(map(R^(numgens target G), R^(numgens source G), G))\n\
);\n\n";
    # forget degrees!
    
    BasisOfColumnModule := "\n\
BasisOfColumnModule = M -> (\n\
  local G,R;\n\
  R = ring M;\n\
  G = gens gb image matrix M;\n\
  map(R^(numgens target G), R^(numgens source G), G)\n\
);\n\n";
    # forget degrees!
    
    BasisOfRowsCoeff := "\n\
BasisOfRowsCoeff = M -> (\n\
  local G,R,T;\n\
  R = ring M;\n\
  G = gb(image matrix transpose M, ChangeMatrix=>true);\n\
  T = getChangeMatrix G;\n\
  (transpose map(R^(numgens target gens G), R^(numgens source gens G), gens G),\n\
   transpose map(R^(numgens target T), R^(numgens source T), T))\n\
);\n\n";
    # forget degrees!
    
    BasisOfColumnsCoeff := "\n\
BasisOfColumnsCoeff = M -> (\n\
  local G,T;\n\
  G = gb(image matrix M, ChangeMatrix=>true);\n\
  T = getChangeMatrix G;\n\
  (map(R^(numgens target gens G), R^(numgens source gens G), gens G),\n\
   map(R^(numgens target T), R^(numgens source T), T))\n\
);\n\n";
    # forget degrees!
    
    DecideZeroRows := "\n\
DecideZeroRows = (A, B) -> (\n\
  Involution(remainder(matrix Involution(A), matrix Involution(B)))\n\
);\n\n";
    
    DecideZeroColumns := "\n\
DecideZeroColumns = (A, B) -> (\n\
  remainder(matrix A, matrix B)\n\
);\n\n";
    
    DecideZeroRowsEffectively := "\n\
DecideZeroRowsEffectively = (A, B) -> ( local q,r;\n\
  (q, r) = quotientRemainder(matrix Involution(A), matrix Involution(B));\n\
  (Involution(r), -Involution(q))\n\
);\n\n";
    
    DecideZeroColumnsEffectively := "\n\
DecideZeroColumnsEffectively = (A, B) -> ( local q,r;\n\
  (q, r) = quotientRemainder(matrix A, matrix B);\n\
  (r, -q)\n\
);\n\n";
    
    SyzygiesGeneratorsOfRows := "\n\
SyzygiesGeneratorsOfRows = M -> Involution(SyzygiesGeneratorsOfColumns(Involution(M)));\n\n";
    
    SyzygiesGeneratorsOfRows2 := "\n\
SyzygiesGeneratorsOfRows2 = (M, N) -> Involution(SyzygiesGeneratorsOfColumns2(Involution(M), Involution(N)));\n\n";
    
    SyzygiesGeneratorsOfColumns := "\n\
SyzygiesGeneratorsOfColumns = M -> (\n\
  local R,S;\n\
  R = ring M;\n\
  S = syz M;\n\
  map(R^(numgens target S), R^(numgens source S), S)\n\
);\n\n";
    
    SyzygiesGeneratorsOfColumns2 := "\n\
SyzygiesGeneratorsOfColumns2 = (M, N) -> (\n\
  local K,R;\n\
  R = ring M;\n\
  K = gens kernel map(cokernel N, source M, M);\n\
  map(R^(numgens target K), R^(numgens source K), K)\n\
);\n\n";
    
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
    homalgSendBlocking( BasisOfRowsCoeff, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfColumnsCoeff, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroRows, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroColumns, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroRowsEffectively, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroColumnsEffectively, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( SyzygiesGeneratorsOfColumns, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( SyzygiesGeneratorsOfColumns2, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( SyzygiesGeneratorsOfRows, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( SyzygiesGeneratorsOfRows2, "need_command", stream, HOMALG_IO.Pictograms.define );
    
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
    local nargs, stream, o, ar, ext_obj, R, RP;
    
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
    ext_obj := homalgSendBlocking( [ R, "[", var, "]" ], "break_lists", TheTypeHomalgExternalRingObjectInMacaulay2, properties, HOMALG_IO.Pictograms.CreateHomalgRing );
    
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
    ext_obj := homalgSendBlocking( Concatenation( [ R, "[", var, der, ",WeylAlgebra => {" ], [ JoinStringsWithSeparator( ListN( var, der, function(i, j) return Concatenation( i, "=>", j ); end ) ) ], [ "}]" ] ), "break_lists", TheTypeHomalgExternalRingObjectInMacaulay2, HOMALG_IO.Pictograms.CreateHomalgRing );
    
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
    
    BasisOfRowModule := "\n\
BasisOfRowModule = M -> (\n\
  local G,R;\n\
  R = ring M;\n\
  if isCommutative(R) then (\n\
    G = gens gb image matrix transpose M;\n\
    transpose(map(R^(numgens target G), R^(numgens source G), G))\n\
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
    ext_obj := homalgSendBlocking( [ "map(", R, "^", r, R, "^", c, ", pack(", c, ", ", Flat(['{', S, '}']), "))" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
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

##
InstallMethod( homalgSetName,
        "for homalg ring elements",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep, IsString, IsHomalgExternalRingInMacaulay2Rep ],
        
  function( r, name, R )
    
    SetName( r, homalgSendBlocking( [ "toString(", r, ")" ], "need_output", HOMALG_IO.Pictograms.homalgSetName ) );
    
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
