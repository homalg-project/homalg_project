#############################################################################
##
##  MAGMA.gi                  RingsForHomalg package         Mohamed Barakat
##                                                            Simon Goertzen
##                                                          Markus Kirschmer
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system MAGMA.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_MAGMA,
        rec(
            cas := "magma",		## normalized name on which the user should have no control
            name := "MAGMA",
            executable := [ "magma" ],	## this list is processed from left to right
            options := [ ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_POS_BEGIN := 1,		## these are the most
            CUT_POS_END := 2,		## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";",
            remove_enter := true,	## a MAGMA specific
            error_stdout := " error",	## a MAGMA specific
            setring := _MAGMA_SetRing,	## a MAGMA specific
            define := ":=",
            delete := function( var, stream ) homalgSendBlocking( [ "delete ", var ], "need_command", stream, HOMALG_IO.Pictograms.delete ); end,
            multiple_delete := _MAGMA_multiple_delete,
            prompt := "\033[01mmagma>\033[0m ",
            output_prompt := "\033[1;31;47m<magma\033[0m ",
            display_color := "\033[0;30;47m",
            InitializeCASMacros := InitializeMAGMAMacros,
            time := function( stream, t ) return Int( homalgSendBlocking( [ "Floor( Cputime() * 1000 )" ], "need_output", stream, HOMALG_IO.Pictograms.time ) ) - t; end,
           )
);

HOMALG_IO_MAGMA.READY_LENGTH := Length( HOMALG_IO_MAGMA.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalRingObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInMAGMARep",
        IshomalgExternalRingObjectRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInMAGMARep",
        IsHomalgExternalRingRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeHomalgExternalRingObjectInMAGMA",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMAGMARep ) );

# a new type:
BindGlobal( "TheTypeHomalgExternalRingInMAGMA",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInMAGMARep ) );

####################################
#
# global functions:
#
####################################

##
InstallGlobalFunction( _MAGMA_SetRing,
  function( R )
    local stream, param, indets;
    
    stream := homalgStream( R );
    
    ## since _MAGMA_SetRing might be called from homalgSendBlocking,
    ## we first set the new active ring to avoid infinite loops:
    stream.active_ring := R;
    
    if HasRationalParameters( R ) then
        param := RationalParameters( R );
        param := List( param, String );
        param := JoinStringsWithSeparator( param );
        if HasIsFreePolynomialRing( R ) and HasCoefficientsRing( R ) then
            homalgSendBlocking( [ "_<", param, "> := BaseRing(", R, ")" ], "need_command", "break_lists", HOMALG_IO.Pictograms.initialize );
        else
            homalgSendBlocking( [ "_<", param, "> := ", R ], "need_command", "break_lists", HOMALG_IO.Pictograms.initialize );
        fi;
    fi;
    
    if HasCoefficientsRing( R ) then
        indets := Indeterminates( R );
        indets := List( indets, String );
        indets := JoinStringsWithSeparator( indets );
        homalgSendBlocking( [ "_<", indets, "> := ", R ], "need_command", "break_lists", HOMALG_IO.Pictograms.initialize );
    fi;
    
    if IsBound( HOMALG_IO_MAGMA.setring_post ) then
        homalgSendBlocking( HOMALG_IO_MAGMA.setring_post, "need_command", stream, HOMALG_IO.Pictograms.initialize );
    fi;
    
end );

##
InstallGlobalFunction( _MAGMA_multiple_delete,
  function( var_list, stream )
    local num, l, i, str;
    
    num := 100;
    
    l := Length( var_list );
    
    i := 1;
    
    if l - i < num then
        str := [ "delete ", var_list ];
    else
        while true do
            str := [ "delete ", var_list{[ i .. i + num - 1 ]} ];
            homalgSendBlocking( str, "need_command", stream, "break_lists", HOMALG_IO.Pictograms.multiple_delete );
            i := i + num;
            if l - i < num then
                break;
            fi;
        od;
        str := [ "delete ", var_list{[ i .. l ]} ];
    fi;
    
    homalgSendBlocking( str, "need_command", stream, "break_lists", HOMALG_IO.Pictograms.multiple_delete );
    
end );

##
InstallValue( MAGMAMacros,
        rec(
            
    _order := [
               "MyRowspace",
               "BasisOfRowModule",
               "BasisOfRowsCoeff",
               "DecideZeroRows",
               "DecideZeroRowsEffectively",
               "SyzygiesGeneratorsOfRows",
               "RelativeSyzygiesGeneratorsOfRows",
               ],
    
    IsDiagonalMatrix := "\n\
IsDiagonalMatrix := function(M)\n\
  for i:= 1 to Min(Nrows(M),Ncols(M)) do M[i,i]:= 0; end for;\n\
  return IsZero(M);\n\
end function;\n\n",
    
    ZeroRows := "\n\
ZeroRows := function(M)\n\
  return [i: i in [ 1 .. Nrows(M) ] | IsZero(M[i]) ];\n\
end function;\n\n",
    
    ZeroColumns := "\n\
ZeroColumns := function(M)\n\
  return [i: i in [ 1 .. Ncols(M) ] | IsZero(ColumnSubmatrixRange(M,i,i)) ];\n\
end function;\n\n",
    
    GetColumnIndependentUnitPositions := "\n\
GetColumnIndependentUnitPositions:= function(M, pos_list)\n\
  rest := [ 1..Ncols(M) ];\n\
  pos := [ ];\n\
  for i in [ 1 .. Nrows(M) ] do\n\
     for r in Reverse(rest) do\n\
       if [ i, r ] notin pos_list and IsUnit(M[i, r]) then\n\
         Append( ~pos, [ i, r ] );\n\
         rest:= [ x: x in rest | IsZero(M[i, x]) ];\n\
         break;\n\
       end if;\n\
    end for;\n\
  end for;\n\
  return pos;\n\
end function;\n\n",
    
    GetRowIndependentUnitPositions := "\n\
GetRowIndependentUnitPositions:= function(M, pos_list)\n\
  rest := [ 1..Nrows(M) ];\n\
  pos := [ ];\n\
  for j in [ 1 .. Ncols(M) ] do\n\
     for r in Reverse(rest) do\n\
       if [ j, r ] notin pos_list and IsUnit(M[r, j]) then\n\
         Append( ~pos, [ j, r ] );\n\
         rest:= [ x: x in rest | IsZero(M[x, j]) ];\n\
         break;\n\
       end if;\n\
    end for;\n\
  end for;\n\
  return pos;\n\
end function;\n\n",
    
    GetUnitPosition := "\n\
GetUnitPosition:= function(M, pos_list)\n\
  collist:= [ x : x in [1 .. Ncols(M)] | x notin pos_list ];\n\
  ok:= exists(l){ [i, j]: i in [1 .. Nrows(M) ], j in collist | IsUnit( M[i, j] ) };\n\
  return ok select l else \"fail\";\n\
end function;\n\n",
    
    PositionOfFirstNonZeroEntryPerRow := "\n\
PositionOfFirstNonZeroEntryPerRow := function(M)\n\
  X:= [];\n\
  for i in [1..Nrows(M)] do\n\
    Append(~X, Depth(M[i]));\n\
  end for;\n\
  if exists{ x : x in X | x ne X[1] } then\n\
    return X;\n\
  else\n\
    return X[1];\n\
  end if;\n\
end function;\n\n",
    
    PositionOfFirstNonZeroEntryPerColumn := "\n\
PositionOfFirstNonZeroEntryPerColumn := function(M)\n\
  X:= [];\n\
  m:= Nrows(M);\n\
  for j in [1..Ncols(M)] do\n\
    if exists(i){ i: i in [1..m] | not IsZero(M[i,j]) } then\n\
      Append(~X, i);\n\
    else\n\
      Append(~X, 0);\n\
    end if;\n\
  end for;\n\
  if exists{ x : x in X | x ne X[1] } then\n\
    return X;\n\
  else\n\
    return X[1];\n\
  end if;\n\
end function;\n\n",
    
    DivideRowByUnit := "\n\
DivideRowByUnit:= procedure( ~M, i, u, j )\n\
  R := BaseRing(M);\n\
  M[i] *:= 1/(R ! u);\n\
  // to be sure:\n\
  if j gt 0 then\n\
    M[i, j]:= R ! 1;\n\
  end if;\n\
end procedure;\n\n",
    
    DivideColumnByUnit := "\n\
DivideColumnByUnit:= procedure( ~M, j, u, i )\n\
  R := BaseRing(M);\n\
  uinv:= 1/(R ! u);\n\
  for a in [ 1 .. Nrows(M) ] do\n\
    M[a, j] *:= uinv;\n\
  end for;\n\
  // to be sure:\n\
  if i gt 0 then\n\
    M[i, j]:= R ! 1;\n\
  end if;\n\
end procedure;\n\n",
    
    CopyRowToIdentityMatrix := "\n\
CopyRowToIdentityMatrix := procedure( M, i, ~I, j, e)\n\
  I[j]:= M[i];\n\
  if e eq -1 then I[j] *:= -1; end if;\n\
  I[j,j]:= 1;\n\
end procedure;\n\n",

    CopyRowToIdentityMatrix2 := "\n\
CopyRowToIdentityMatrix2 := procedure( M, i, ~I1, ~I2, j)\n\
  I1[j]:= -M[i];\n\
  I1[j,j]:= 1;\n\
  I2[j]:= M[i];\n\
  I2[j,j]:= 1;\n\
end procedure;\n\n",

    CopyColumnToIdentityMatrix := "\n\
CopyColumnToIdentityMatrix := procedure( M, j, ~I, i , e)\n\
  rowlist:= [ 1..i-1 ] cat [ i+1 .. Nrows(M)];\n\
  if e eq 1 then\n\
    for k in rowlist do\n\
      I[k,i] := M[k,j];\n\
    end for;\n\
  else\n\
    for k in rowlist do\n\
      I[k,i] := -M[k,j];\n\
    end for;\n\
  end if;\n\
end procedure;\n\n",
    
    CopyColumnToIdentityMatrix2 := "\n\
CopyColumnToIdentityMatrix2 := procedure( M, j, ~I1, ~I2, i )\n\
  rowlist:= [ 1..i-1 ] cat [ i+1 .. Nrows(M)];\n\
  for k in rowlist do\n\
    x:= M[k,j];\n\
    I1[k,i] := -x;\n\
    I2[k,i] := x;\n\
  end for;\n\
end procedure;\n\n",
    
    SetColumnToZero := "\n\
SetColumnToZero:= procedure( ~M, i, j )\n\
  rowlist:= [ 1..i-1 ] cat [ i+1 .. Nrows(M)];\n\
  for k in rowlist do\n\
    M[k,j]:= 0;\n\
  end for;\n\
end procedure;\n\n",
    
    GetCleanRowsPositions := "\n\
GetCleanRowsPositions:= function( M, clean_columns )\n\
  clean_rows := [ ];\n\
  m := Nrows( M );\n\
  for j in clean_columns do\n\
    for i in [ 1 .. m ] do\n\
      if IsOne(M[i, j]) then\n\
        Append( ~clean_rows, i );\n\
        break;\n\
       end if;\n\
     end for;\n\
  end for;\n\
  return clean_rows;\n\
end function;\n\n",
    
    MyRowspace := "\n\
MyRowspace := function(M)\n\
  if Type(BaseRing(M)) eq AlgExt then\n\
    return sub< Module(BaseRing(M), Ncols(M)) | RowSequence(M) >;\n\
  end if;\n\
  if Type(M) eq AlgMatElt then\n\
    return Rowspace(RMatrixSpace( BaseRing(M), Nrows(M), Ncols(M)) ! M);\n\
  else\n\
    return Rowspace(M);\n\
  end if;\n\
end function;\n\n",
    
    BasisOfRowModule := "\n\
BasisOfRowModule := function(M)\n\
  S := MyRowspace(M);\n\
  Groebner(S);\n\
  return BasisMatrix(S);\n\
end function;\n\n",
    
    BasisOfColumnModule := "\n\
BasisOfColumnModule := function(M)\n\
  return Transpose(BasisOfRowModule(Transpose(M)));\n\
end function;\n\n",
   
    PartiallyReducedBasisOfRowModule := "\n\
PartiallyReducedBasisOfRowModule := function(M)\n\
  S := MyRowspace(M);\n\
  //Groebner(S);\n\
  return Matrix( BaseRing(M), Degree(S), &cat [Eltseq(x) : x in MinimalBasis(S)] );\n\
end function;\n\n\
\n\
PartiallyReducedBasisOfColumnModule := function(M)\n\
  return Transpose(PartiallyReducedBasisOfRowModule(Transpose(M)));\n\
end function;\n\n",
    
    BasisOfRowsCoeff := "\n\
BasisOfRowsCoeff:= function(M)\n\
  B := BasisOfRowModule(M);\n\
  T := Solution(M, B);\n\
  return B, T;\n\
end function;\n\n",
    
    BasisOfColumnsCoeff := "\n\
BasisOfColumnsCoeff:= function(M)\n\
  B, T := BasisOfRowsCoeff(Transpose(M));\n\
  return Transpose(B), Transpose(T);\n\
end function;\n\n",
    
    DecideZeroRows := "\n\
DecideZeroRows:= function(A, B)\n\
  S := MyRowspace(B);\n\
  F := Generic(S);\n\
  return Matrix( [Eltseq(NormalForm(F ! A[i], S)): i in [1..Nrows(A)]] );\n\
end function;\n\n",
    
    DecideZeroColumns := "\n\
DecideZeroColumns:= function(A, B)\n\
  return Transpose(DecideZeroRows(Transpose(A),Transpose(B)));\n\
end function;\n\n",
    
    DecideZeroRowsEffectively := "\n\
DecideZeroRowsEffectively:= function(A, B)\n\
  S := MyRowspace(B);\n\
  F := Generic(S);\n\
  M := Matrix( [Eltseq(NormalForm(F ! A[i], S)): i in [1..Nrows(A)]] );\n\
  return M, Solution( B, M-A );\n\
end function;\n\n",
    
    DecideZeroColumnsEffectively := "\n\
DecideZeroColumnsEffectively:= function(A, B)\n\
  M, T := DecideZeroRowsEffectively(Transpose(A),Transpose(B));\n\
  return Transpose(M), Transpose(T);\n\
end function;\n\n",
    
    SyzygiesGeneratorsOfRows := "\n\
SyzygiesGeneratorsOfRows:= function(M)\n\
    S := MyRowspace(M);\n\
    SM := SyzygyModule(S);\n\
  return Matrix( BaseRing(M), Degree(SM), &cat [Eltseq(x) : x in Basis(SM)] );\n\
end function;\n\n",
    
    SyzygiesGeneratorsOfColumns := "\n\
SyzygiesGeneratorsOfColumns:= function(M)\n\
  return Transpose(SyzygiesGeneratorsOfRows(Transpose(M)));\n\
end function;\n\n",

    RelativeSyzygiesGeneratorsOfRows := "\n\
RelativeSyzygiesGeneratorsOfRows:= function(M1, M2)\n\
  S := MyRowspace( VerticalJoin(M1, M2) );\n\
  SM := SyzygyModule(S);\n\
  SM := MyRowspace( ColumnSubmatrix( BasisMatrix(SM), 1, Nrows(M1) ) );\n\
  return Matrix( BaseRing(M1), Degree(SM), &cat [Eltseq(x) : x in MinimalBasis(SM)] );\n\
end function;\n\n",
    
    RelativeSyzygiesGeneratorsOfColumns := "\n\
RelativeSyzygiesGeneratorsOfColumns:= function(M1, M2)\n\
  return Transpose(RelativeSyzygiesGeneratorsOfRows(Transpose(M1),Transpose(M2)));\n\
end function;\n\n",

    imap := "\n\
function imap(M, R)\n\
S:= BaseRing(Parent(M));\n\
if {Type(S), Type(R)} subset {RngMPol, RngUPol, FldFunRat} then\n\
  N:= []; V:= []; B:= R;\n\
  while Type(B) in {RngMPol, RngUPol, FldFunRat} do\n\
    N cat:= Names(B);\n\
    V cat:= [ R | B.i: i in [1..NumberOfNames(B)] ];\n\
    B:= BaseRing(B);\n\
  end while;\n\
  error if #Set(N) ne #N, \"variable name used twice!\";\n\
  Images:= [ i eq 0 select R ! 0 else V[i] where i:= Index(N, n) : n in Names(S)];\n\
  h:= hom< S -> R | Images >;\n\
  return ChangeRing(M, h);\n\
end if;\n\
return ChangeRing(M, R);\n\
end function;\n\n",

    DegreeOfRingElement := "\n\
// a work around of a bug noticed by Markus L.-H. in the 64bit Magma V2.17-2\n\
if Degree(PolynomialRing(Rationals(),2)!0) eq 0 then\n\
Deg:= function(r,R)\n\
  a := R!r;\n\
  if a eq 0 then return -1; end if; return Degree(a);\n\
end function;\n\
Deg2:= function(r,R,v)\n\
  a := R!r;\n\
  if a eq 0 then return -1; end if; return Degree(a,v);\n\
end function;\n\
else\n\
Deg:= function(r,R)\n\
  return Degree(R!r);\n\
end function;\n\
Deg2:= function(r,R,v)\n\
  return Degree(R!r,v);\n\
end function;\n\
end if;\n\n",
    
    MonomialsUnivariate := "\n\
MonomialsUnivariate :=\n\
func<f,x| [x^(i-1): i in [1..#C] | C[i] ne 0] where C:=Coefficients(f,x)>;\n\n",
    
    ("!Diff") := "\n\
// liefert f nach g. Reihenfolge ist der Parameter in Magma-Konvention (alles andere ist sehr komisch)\n\
function mydiff(f,g)\n\
  P:= Parent(f);\n\
  assert not IsZero(g) and Parent(g) eq P;\n\
  C, M:= CoefficientsAndMonomials(g);\n\
  return &+ [ C[j] * &* [ P | Derivative(f, e[i], i) : i in [1..#e] | e[i] ne 0 ] where e:= Exponents(M[j]) : j in [1..#C] ];\n\
end function;\n\n",
    
    Diff := "\n\
// Frei nach dem GAP-Handbuch:\n\
// If D is a f × p-matrix and N is a g × q-matrix then H=Diff(D,N) is an fg × pq-matrix whose entry H[g*(i-1)+j,q*(k-1)+l] is the\n\
// result of differentiating N[j,l] by the differential operator corresponding to D[i,k]. (Here we follow the Macaulay2 convention.)\n\
function Diff(D, N)\n\
  return Matrix( Ncols(D) * Ncols(N), [ mydiff(N[j,l], D[i,k]) : l in [1..Ncols(N)], k in [1..Ncols(D)] , j in [1..Nrows(N)], i in [1..Nrows(D)] ] );\n\
end function;\n\n",
    
    )
);

##   
InstallGlobalFunction( InitializeMAGMAMacros,
  function( stream )
    
    homalgSendBlocking( "SetHistorySize(0);\n\n", "need_command", stream, HOMALG_IO.Pictograms.initialize );

    return InitializeMacros( MAGMAMacros, stream );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInMAGMA,
  function( arg )
    local nargs, ar, R;
    
    nargs := Length( arg );
    
    ar := [ arg[1] ];
    
    Add( ar, TheTypeHomalgExternalRingObjectInMAGMA );
    
    if nargs > 1 then
        Append( ar, arg{[ 2 .. nargs ]} );
    fi;
    
    ar := [ ar, TheTypeHomalgExternalRingInMAGMA ];
    
    Add( ar, "HOMALG_IO_MAGMA" );
    
    R := CallFuncList( CreateHomalgExternalRing, ar );
    
    _MAGMA_SetRing( R );
    
    LetWeakPointerListOnExternalObjectsContainRingCreationNumbers( R );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInMAGMA,
  function( arg )
    local nargs, l, c, d, R;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsInt( arg[1] ) and arg[1] <> 0 then
	l := 2;
        ## characteristic:
        c := AbsInt( arg[1] );
        if IsPrime( c ) then
            if nargs > 1 and IsPosInt( arg[2] ) then
                d := arg[2];
                l := 3;
            else
                d := 1;
            fi;
            R := [ [ "GaloisField(", c, d, ")" ], [ ], [ "<Z", c, "_", d, ">" ] ];
        else
            R := [ [ "IntegerRing(", c, ")" ] ];
        fi;
    else
        if nargs > 0 and arg[1] = 0 then
            l := 2;
        else
            l := 1;
        fi;
        ## characteristic:
        c := 0;
        R := [ [ "IntegerRing()" ] ];
    fi;
    
    if not ( IsZero( c ) or IsPrime( c ) ) then
        Error( "the ring Z/", c, "Z (", c, " non-prime) is not yet supported for MAGMA!\nYou can use the generic residue class ring constructor '/' provided by homalg after defining the ambient ring (over the integers)\nfor help type: ?homalg: constructor for residue class rings\n" );
    fi;
    
    R := Concatenation( R, [ IsPrincipalIdealRing ], arg{[ l .. nargs ]} );
    
    R := CallFuncList( RingForHomalgInMAGMA, R );
    
    if IsBound( d ) and d > 1 then
        R!.NameOfPrimitiveElement := Concatenation( "Z", String( c ), "_", String( d ) );
        SetIsFieldForHomalg( R, true );
        SetRingProperties( R, c, d );
        SetName( R, Concatenation( "GF(", String( c ), "^", String( d ), ")" ) );
    else
        SetIsResidueClassRingOfTheIntegers( R, true );
        SetRingProperties( R, c );
    fi;
    
    return R;
    
end );

##
InstallMethod( HomalgRingOfIntegersInUnderlyingCAS,
        "for an integer and homalg ring in MAGMA",
        [ IsInt, IsHomalgExternalRingInMAGMARep ],
        
  HomalgRingOfIntegersInMAGMA );

##
InstallGlobalFunction( HomalgFieldOfRationalsInMAGMA,
  function( arg )
    local nargs, param, minimal_polynomial, Q, R;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsString( arg[1] ) then
        
        param := ParseListOfIndeterminates( SplitString( arg[1], "," ) );
        
        arg := arg{[ 2 .. nargs ]};
        
        if nargs > 1 and IsString( arg[1] ) then
            minimal_polynomial := arg[1];
            arg := arg{[ 2 .. nargs - 1 ]};
        fi;
        
        Q := CallFuncList( HomalgFieldOfRationalsInMAGMA, arg );
        
        R := Q * param;
        
        R := homalgSendBlocking( [ "FieldOfFractions(", R, ")" ], TheTypeHomalgExternalRingObjectInMAGMA, [ IsPrincipalIdealRing ], HOMALG_IO.Pictograms.CreateHomalgRing );
        
        R := CreateHomalgExternalRing( R, TheTypeHomalgExternalRingInMAGMA );
        
    else
        
        R := "Rationals()";
        
        R := Concatenation( [ R ], [ IsPrincipalIdealRing ], arg );
        
        R := CallFuncList( RingForHomalgInMAGMA, R );
        
    fi;
    
    if IsBound( param ) then
        
        param := List( param, function( a ) local r; r := HomalgExternalRingElement( a, R ); SetName( r, a ); return r; end );
        
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
InstallGlobalFunction( HomalgCyclotomicFieldInMAGMA,
  function( arg )
    local degree, var, R;
    
    if Length( arg ) < 2 then
        
        Error( "too few arguments" );
        
    fi;
    
    degree := arg[ 1 ];
    
    var := arg[ 2 ];
    
    arg := arg{ [ 3 .. Length( arg )] };
    
    if not IsInt( degree ) or degree < 2 or not IsString( var ) then
        
        Error( "input must be an integer > 1 and a string\n" );
        
        return;
        
    fi;
    
    R := [ [ "CyclotomicField(", String( degree ), ")" ], [ ], [ "<", var, ">" ] ];
    
    R := Concatenation( R, [ IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInMAGMA, R );
    
    SetName( R, Concatenation( "Q[", var, "]" ) );
    
    SetIsRationalsForHomalg( R, false );
    
    SetIsFieldForHomalg( R, true );
    
    return R;
    
end );

##
InstallMethod( FieldOfFractions,
        "for homalg rings in MAGMA",
        [ IsHomalgExternalRingInMAGMARep and IsIntegersForHomalg ],
        
  function( ZZ )
    
    return HomalgFieldOfRationalsInMAGMA( ZZ );
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings in MAGMA",
        [ IsHomalgExternalRingInMAGMARep, IsList ],
        
  function( R, indets )
    local ar, r, var, nr_var, properties, ext_obj, S, l;
    
    ar := _PrepareInputForPolynomialRing( R, indets );
    
    r := ar[1];
    var := ar[2];	## all indeterminates, relative and base
    nr_var := ar[3];	## the number of relative indeterminates
    properties := ar[4];
    
    ## create the new ring
    if Length( var ) = 1 and HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) then
        ext_obj := homalgSendBlocking( [ "PolynomialRing(", r, ")" ], [ ], [ "<", var, ">" ], TheTypeHomalgExternalRingObjectInMAGMA, properties, "break_lists", HOMALG_IO.Pictograms.CreateHomalgRing );
    else
        ext_obj := homalgSendBlocking( [ "PolynomialRing(", r, Length( var ), ",\"grevlex\")" ], [ ], [ "<", var, ">" ], TheTypeHomalgExternalRingObjectInMAGMA, properties, "break_lists", HOMALG_IO.Pictograms.CreateHomalgRing );
    fi;
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMAGMA );
    
    var := List( var, a -> HomalgExternalRingElement( a, S ) );
    
    Perform( var, Name );
    
    SetIsFreePolynomialRing( S, true );
    
    if HasIndeterminatesOfPolynomialRing( R ) and IndeterminatesOfPolynomialRing( R ) <> [ ] then
        SetBaseRing( S, R );
        l := Length( var );
        SetRelativeIndeterminatesOfPolynomialRing( S, var{[ l - nr_var + 1 .. l ]} );
    fi;
    
    SetRingProperties( S, r, var );
    
    return S;
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings in MAGMA",
        [ IsHomalgExternalRingInMAGMARep, IsHomalgExternalRingInMAGMARep, IsHomalgExternalRingInMAGMARep, IsList ],
        
  function( R, Coeff, Base, indets )
    local ar, var, anti, comm, r, ext_obj, S;
    
    ar := _PrepareInputForExteriorRing( R, Base, indets );
    
    var := ar[3];
    anti := ar[4];
    comm := ar[5];
    
    ## create the new ring
    r := CoefficientsRing( R );
    
    ext_obj := homalgSendBlocking( [ "ExteriorAlgebra(", r, Length( anti ), ",\"grevlex\")" ], [ ], [ "<", anti, ">" ], TheTypeHomalgExternalRingObjectInMAGMA, "break_lists", HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMAGMA );
    
    anti := List( anti , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( anti, Name );
    
    comm := List( comm , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( comm, Name );
    
    SetIsExteriorRing( S, true );
    
    SetBaseRing( S, Base );
    
    SetRingProperties( S, R, anti );
    
    return S;
    
end );

##
InstallMethod( AddRationalParameters,
        "for MAGMA rings",
        [ IsHomalgExternalRingInMAGMARep and IsFieldForHomalg, IsList ],
        
  function( R, param )
    local c, par;
    
    if IsString( param ) then
        param := [ param ];
    fi;
    
    param := List( param, String );
    
    c := Characteristic( R );
    
    if HasRationalParameters( R ) then
        par := RationalParameters( R );
        par := List( par, String );
    else
        par := [ ];
    fi;
    
    par := Concatenation( par, param );
    par := JoinStringsWithSeparator( par );
    
    ## TODO: take care of the rest
    if c = 0 then
        return HomalgFieldOfRationalsInMAGMA( par, R );
    fi;
    
    return HomalgRingOfIntegersInMAGMA( c, par, R );
    
end );

##
InstallMethod( AddRationalParameters,
        "for MAGMA rings",
        [ IsHomalgExternalRingInMAGMARep and IsFreePolynomialRing, IsList ],
        
  function( R, param )
    local c, par, indets, r;
    
    if IsString( param ) then
        param := [ param ];
    fi;
    
    param := List( param, String );
    
    c := Characteristic( R );
    
    if HasRationalParameters( R ) then
        par := RationalParameters( R );
        par := List( par, String );
    else
        par := [ ];
    fi;
    
    par := Concatenation( par, param );
    par := JoinStringsWithSeparator( par );
    
    indets := Indeterminates( R );
    indets := List( indets, String );
    
    r := CoefficientsRing( R );
    
    if not IsFieldForHomalg( r ) then
        Error( "the coefficients ring is not a field\n" );
    fi;
    
    ## TODO: take care of the rest
    if c = 0 then
        return HomalgFieldOfRationalsInMAGMA( par, r ) * indets;
    fi;
    
    return HomalgRingOfIntegersInMAGMA( c, par, r ) * indets;
    
end );

##
InstallMethod( SetMatElm,
        "for homalg external matrices in MAGMA",
        [ IsHomalgExternalMatrixRep and IsMutable, IsPosInt, IsPosInt, IsString, IsHomalgExternalRingInMAGMARep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", r, c, "]:=", s ], "need_command", HOMALG_IO.Pictograms.SetMatElm );
    
end );

##
InstallMethod( AddToMatElm,
        "for homalg external matrices in MAGMA",
        [ IsHomalgExternalMatrixRep and IsMutable, IsPosInt, IsPosInt, IsHomalgExternalRingElementRep, IsHomalgExternalRingInMAGMARep ],
        
  function( M, r, c, a, R )
    
    homalgSendBlocking( [ M, "[", r, c, "]:=", a, "+", M, "[", r, c, "]" ], "need_command", HOMALG_IO.Pictograms.AddToMatElm );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg external matrices in MAGMA",
        [ IsString, IsHomalgExternalRingInMAGMARep ],
        
  function( S, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "Matrix(", R, ",", S, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg external matrices in MAGMA",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMAGMARep ],
  function( S, r, c, R )
    
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "Matrix(", R, r, c, ",", S, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( CreateHomalgBlockDiagonalMatrixFromStringList,
        "constructor for homalg external matrices in MAGMA",
        [ IsList, IsList, IsList, IsHomalgExternalRingInMAGMARep ],
  function( S, r, c, R )
    local l, ext_obj;
    
    l := Length( S );
    
    ext_obj := Concatenation( List( [ 1 .. l - 1 ], i -> [ "Matrix(", R, r[i], c[i], ",", S[i], ")," ] ) );
    
    Append( ext_obj, [ "Matrix(", R, r[l], c[l], ",", S[l], ")" ] );
    
    ext_obj := Concatenation( [ "DiagonalJoin(<" ], ext_obj, [ ">)" ] );
    
    ext_obj := homalgSendBlocking( ext_obj, HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromSparseString,
        "constructor for homalg external matrices in MAGMA",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMAGMARep ],
        
  function( S, r, c, R )
    local M, s;
    
    M := HomalgVoidMatrix( r, c, R );
    
    s := homalgSendBlocking( S, R, HOMALG_IO.Pictograms.sparse );
    
    homalgSendBlocking( [ M, " := Matrix(SparseMatrix(", R, r, c, ", [car<Integers(), Integers(), ", R, "> | <a,b,c> where a,b,c:= Explode(e): e in ", s, "] ))" ] , "need_command", HOMALG_IO.Pictograms.HomalgMatrix );
    
    return M;
    
end );

##
InstallMethod( MatElmAsString,
        "for homalg external matrices in MAGMA",
        [ IsHomalgExternalMatrixRep, IsPosInt, IsPosInt, IsHomalgExternalRingInMAGMARep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ M, "[", r, c, "]" ], "need_output", HOMALG_IO.Pictograms.MatElm );
    
end );

##
InstallMethod( MatElm,
        "for homalg external matrices in MAGMA",
        [ IsHomalgExternalMatrixRep, IsPosInt, IsPosInt, IsHomalgExternalRingInMAGMARep ],
        
  function( M, r, c, R )
    local Mrc;
    
    Mrc := homalgSendBlocking( [ M, "[", r, c, "]" ], HOMALG_IO.Pictograms.MatElm );
    
    return HomalgExternalRingElement( Mrc, R );
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for homalg external matrices in MAGMA",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMAGMARep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "Eltseq(", M, ")" ], "need_output", HOMALG_IO.Pictograms.GetListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for external matrices",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMAGMARep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "RowSequence(", M, ")" ], "need_output", HOMALG_IO.Pictograms.GetListListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for homalg external matrices in MAGMA",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMAGMARep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "[ [s[1], s[2], m[s[1], s[2] ] ] : s in Support(m)] where m:=", M ], "need_output", HOMALG_IO.Pictograms.GetSparseListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( SaveHomalgMatrixToFile,
        "for homalg external matrices in MAGMA",
        [ IsString, IsHomalgMatrix, IsHomalgExternalRingInMAGMARep ],
        
  function( filename, M, R )
    local mode, command;
    
    if not IsBound( M!.SaveAs ) then
        mode := "ListList";
    else
        mode := M!.SaveAs; #not yet supported
    fi;
    
    if mode = "ListList" then
        command := [ "_str := [ Sprint( RowSequence(", M, ")[x]) : x in [1..", NrRows( M ), "]]; ",
                     "_fs := Open(\"", filename, "\",\"w\"); ",
                     "Put( _fs, Sprint(_str) ); Flush( _fs ); delete( _fs )" ];
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.SaveHomalgMatrixToFile );
        
    fi;
    
    return true;
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for external rings in MAGMA",
        [ IsString, IsHomalgExternalRingInMAGMARep ],
        
  function( filename, R )
    local mode, command, M;
    
    if not IsBound( R!.LoadAs ) then
        mode := "ListList";
    else
        mode := R!.LoadAs; #not yet supported
    fi;
    
    M := HomalgVoidMatrix( R );
    
    if mode = "ListList" then
        
        command := [ M, ":= Matrix(", R, ", eval( Read( \"", filename ,"\" ) ) )" ];
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.LoadHomalgMatrixFromFile );
        
    fi;
    
    return M;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( DisplayRing,
        "for homalg rings in MAGMA",
        [ IsHomalgExternalRingInMAGMARep ], 1,
        
  function( o )
    
    homalgDisplay( o );
    
end );

