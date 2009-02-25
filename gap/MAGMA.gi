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
            executable := "magma",
            options := [ ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_POS_BEGIN := 1,		## these are the most
            CUT_POS_END := 2,		## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";",
            remove_enter := true,	## a MAGMA specific
            error_stdout := " error",	## a MAGMA specific
            define := ":=",
            delete := function( var, stream ) homalgSendBlocking( [ "delete ", var ], "need_command", stream, HOMALG_IO.Pictograms.delete ); end,
            multiple_delete := _MAGMA_multiple_delete,
            prompt := "\033[01mmagma>\033[0m ",
            output_prompt := "\033[1;31;47m<magma\033[0m ",
            display_color := "\033[0;30;47m",
           )
);

HOMALG_IO_MAGMA.READY_LENGTH := Length( HOMALG_IO_MAGMA.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalObjectWithIOStreamRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInMAGMARep",
        IshomalgExternalObjectWithIOStreamRep,
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
InstallGlobalFunction( InitializeMAGMATools,
  function( stream )
    local IsDiagonalMatrix, ZeroRows, ZeroColumns,
          GetColumnIndependentUnitPositions, GetRowIndependentUnitPositions,
          GetUnitPosition, DivideRowByUnit, DivideColumnByUnit,
          CopyRowToIdentityMatrix, CopyRowToIdentityMatrix2,
          CopyColumnToIdentityMatrix, CopyColumnToIdentityMatrix2,
          SetColumnToZero, GetCleanRowsPositions, MyRowspace,
          BasisOfRowModule, BasisOfColumnModule,
          BasisOfRowsCoeff, BasisOfColumnsCoeff,
          DecideZeroRows, DecideZeroColumns,
          DecideZeroRowsEffectively, DecideZeroColumnsEffectively,
          SyzygiesGeneratorsOfRows, SyzygiesGeneratorsOfColumns,
          NonTrivialDegreePerRow, NonTrivialDegreePerRowWithColPosition,
          NonTrivialDegreePerColumn, NonTrivialDegreePerColumnWithRowPosition;

    IsDiagonalMatrix := "\n\
IsDiagonalMatrix := function(M)\n\
  for i:= 1 to Min(Nrows(M),Ncols(M)) do M[i,i]:= 0; end for;\n\
  return IsZero(M);\n\
end function;\n\n";
    
    ZeroRows := "\n\
ZeroRows := function(M)\n\
  return [i: i in [ 1 .. Nrows(M) ] | IsZero(M[i]) ];\n\
end function;\n\n";
    
    ZeroColumns := "\n\
ZeroColumns := function(M)\n\
  return [i: i in [ 1 .. Ncols(M) ] | IsZero(ColumnSubmatrixRange(M,i,i)) ];\n\
end function;\n\n";
    
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
end function;\n\n";
    
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
end function;\n\n";
    
    GetUnitPosition := "\n\
GetUnitPosition:= function(M, pos_list)\n\
  collist:= [ x : x in [1 .. Ncols(M)] | x notin pos_list ];\n\
  ok:= exists(l){ [i, j]: i in [1 .. Nrows(M) ], j in collist | IsUnit( M[i, j] ) };\n\
  return ok select l else \"fail\";\n\
end function;\n\n";
    
    DivideRowByUnit := "\n\
DivideRowByUnit:= procedure( ~M, i, u, j )\n\
  R := BaseRing(M);\n\
  M[i] *:= 1/(R ! u);\n\
  // to be sure:\n\
  if j gt 0 then\n\
    M[i, j]:= R ! 1;\n\
  end if;\n\
end procedure;\n\n";
    
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
end procedure;\n\n";
    
    CopyRowToIdentityMatrix := "\n\
CopyRowToIdentityMatrix := procedure( M, i, ~I, j, e)\n\
  I[j]:= M[i];\n\
  if e eq -1 then I[j] *:= -1; end if;\n\
  I[j,j]:= 1;\n\
end procedure;\n\n";

    CopyRowToIdentityMatrix2 := "\n\
CopyRowToIdentityMatrix2 := procedure( M, i, ~I1, ~I2, j)\n\
  I1[j]:= -M[i];\n\
  I1[j,j]:= 1;\n\
  I2[j]:= M[i];\n\
  I2[j,j]:= 1;\n\
end procedure;\n\n";

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
end procedure;\n\n";
    
    CopyColumnToIdentityMatrix2 := "\n\
CopyColumnToIdentityMatrix2 := procedure( M, j, ~I1, ~I2, i )\n\
  rowlist:= [ 1..i-1 ] cat [ i+1 .. Nrows(M)];\n\
  for k in rowlist do\n\
    x:= M[k,j];\n\
    I1[k,i] := -x;\n\
    I2[k,i] := x;\n\
  end for;\n\
end procedure;\n\n";
    
    SetColumnToZero := "\n\
SetColumnToZero:= procedure( ~M, i, j )\n\
  rowlist:= [ 1..i-1 ] cat [ i+1 .. Nrows(M)];\n\
  for k in rowlist do\n\
    M[k,j]:= 0;\n\
  end for;\n\
end procedure;\n\n";
    
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
end function;\n\n";
    
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
end function;\n\n";
    
    BasisOfRowModule := "\n\
BasisOfRowModule := function(M)\n\
  S := MyRowspace(M);\n\
  Groebner(S);\n\
  return BasisMatrix(S);\n\
end function;\n\n";
    
    BasisOfColumnModule := "\n\
BasisOfColumnModule := function(M)\n\
  return Transpose(BasisOfRowModule(Transpose(M)));\n\
end function;\n\n";
    
    BasisOfRowsCoeff := "\n\
BasisOfRowsCoeff:= function(M)\n\
  B := BasisOfRowModule(M);\n\
  T := Solution(M, B);\n\
  return B, T;\n\
end function;\n\n";
    
    BasisOfColumnsCoeff := "\n\
BasisOfColumnsCoeff:= function(M)\n\
  B, T := BasisOfRowsCoeff(Transpose(M));\n\
  return Transpose(B), Transpose(T);\n\
end function;\n\n";
    
    DecideZeroRows := "\n\
DecideZeroRows:= function(A, B)\n\
  S := MyRowspace(B);\n\
  F := Generic(S);\n\
  return Matrix( [Eltseq(NormalForm(F ! A[i], S)): i in [1..Nrows(A)]] );\n\
end function;\n\n";
    
    DecideZeroColumns := "\n\
DecideZeroColumns:= function(A, B)\n\
  return Transpose(DecideZeroRows(Transpose(A),Transpose(B)));\n\
end function;\n\n";
    
    DecideZeroRowsEffectively := "\n\
DecideZeroRowsEffectively:= function(A, B)\n\
  S := MyRowspace(B);\n\
  F := Generic(S);\n\
  M := Matrix( [Eltseq(NormalForm(F ! A[i], S)): i in [1..Nrows(A)]] );\n\
  return M, Solution( B, M-A );\n\
end function;\n\n";
    
    DecideZeroColumnsEffectively := "\n\
DecideZeroColumnsEffectively:= function(A, B)\n\
  M, T := DecideZeroRowsEffectively(Transpose(A),Transpose(B));\n\
  return Transpose(M), Transpose(T);\n\
end function;\n\n";
    
    SyzygiesGeneratorsOfRows := "\n\
SyzygiesGeneratorsOfRows:= function(M1, M2)\n\
  if M2 cmpeq [] then\n\
    S := MyRowspace(M1);\n\
    SM := SyzygyModule(S);\n\
  else\n\
    S := MyRowspace( VerticalJoin(M1, M2) );\n\
    SM := SyzygyModule(S);\n\
    SM := MyRowspace( ColumnSubmatrix( BasisMatrix(SM), 1, Nrows(M1) ) );\n\
  end if;\n\
  return Matrix( BaseRing(M1), Degree(SM), &cat [Eltseq(x) : x in MinimalBasis(SM)] );\n\
end function;\n\n";
    
    SyzygiesGeneratorsOfColumns := "\n\
SyzygiesGeneratorsOfColumns:= function(M1, M2)\n\
  if M2 cmpeq [] then\n\
    return Transpose(SyzygiesGeneratorsOfRows(Transpose(M1),[]));\n\
  else\n\
    return Transpose(SyzygiesGeneratorsOfRows(Transpose(M1),Transpose(M2)));\n\
  end if;\n\
end function;\n\n";

    NonTrivialDegreePerRow := "\n\
NonTrivialDegreePerRow := function(M)\n\
  X:= [ Degree(m[Depth(m)]) where m:= M[i] : i in [1..Nrows(M)] ];\n\
  if exists{ x : x in X | x ne X[1] } then\n\
    return X;\n\
  else\n\
    return X[1];\n\
  end if;\n\
end function;\n\n";

    NonTrivialDegreePerRowWithColPosition := "\n\
NonTrivialDegreePerRowWithColPosition := function(M)\n\
  X:= [];\n\
  Y:= [];\n\
  for i in [1..Nrows(M)] do\n\
    d:= Depth(M[i]);\n\
    Append(~X, Degree(M[i,d]));\n\
    Append(~Y, d);\n\
  end for;\n\
  return X cat Y;\n\
end function;\n\n";

    NonTrivialDegreePerColumn := "\n\
NonTrivialDegreePerColumn := function(M)\n\
  X:= [];\n\
  m:= Nrows(M);\n\
  for j in [1..Ncols(M)] do\n\
    i:= rep{ i: i in [1..m] | not IsZero(M[i,j]) };\n\
    Append(~X, Degree(M[i,j]));\n\
  end for;\n\
  if exists{ x : x in X | x ne X[1] } then\n\
    return X;\n\
  else\n\
    return X[1];\n\
  end if;\n\
end function;\n\n";

    NonTrivialDegreePerColumnWithRowPosition := "\n\
NonTrivialDegreePerColumnWithRowPosition := function(M)\n\
  X:= [];\n\
  Y:= [];\n\
  m:= Nrows(M);\n\
  for j in [1..Ncols(M)] do\n\
    i:= rep{ i: i in [1..m] | not IsZero(M[i,j]) };\n\
    Append(~X, Degree(M[i,j]));\n\
    Append(~Y, i);\n\
  end for;\n\
  return X cat Y;\n\
end function;\n\n";


    homalgSendBlocking( "SetHistorySize(0);\n\n", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    homalgSendBlocking( IsDiagonalMatrix, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( ZeroRows, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( ZeroColumns, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( GetColumnIndependentUnitPositions, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( GetRowIndependentUnitPositions, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( GetUnitPosition, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DivideRowByUnit, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DivideColumnByUnit, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( CopyRowToIdentityMatrix, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( CopyRowToIdentityMatrix2, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( CopyColumnToIdentityMatrix, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( CopyColumnToIdentityMatrix2, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( SetColumnToZero, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( GetCleanRowsPositions, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( MyRowspace, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfRowModule, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfColumnModule, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfRowsCoeff, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfColumnsCoeff, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroRows, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroColumns, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroRowsEffectively, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroColumnsEffectively, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( SyzygiesGeneratorsOfRows, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( SyzygiesGeneratorsOfColumns, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( NonTrivialDegreePerRow, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( NonTrivialDegreePerRowWithColPosition, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( NonTrivialDegreePerColumn, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( NonTrivialDegreePerColumnWithRowPosition, "need_command", stream, HOMALG_IO.Pictograms.define );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInMAGMA,
  function( arg )
    local nargs, stream, o, ar, ext_obj;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_MAGMA );
        o := 0;
    else
        o := 1;
    fi;
    
    InitializeMAGMATools( stream );
    
    ar := [ arg[1], TheTypeHomalgExternalRingObjectInMAGMA, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    return CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMAGMA );
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInMAGMA,
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
        m := "";
        c := 0;
    elif IsInt( arg[1] ) then
        m := AbsInt( arg[1] );
        c := m;
    else
        Error( "the first argument must be an integer\n" );
    fi;
    
    if not ( IsZero( c ) or IsPrime( c ) ) then
        Error( "the ring Z/nZ, n nonprime, is not yet fully supported in MAGMA!\n" );
    fi;
    
    if IsBound( stream ) then
        R := RingForHomalgInMAGMA( [ "IntegerRing(", m, ")" ], IsPrincipalIdealRing, stream );
    else
        R := RingForHomalgInMAGMA( [ "IntegerRing(", m, ")" ], IsPrincipalIdealRing );
    fi;
    
    SetIsResidueClassRingOfTheIntegers( R, true );
    
    SetRingProperties( R, c );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInMAGMA,
  function( arg )
    local ar, R;
    
    ar := Concatenation( [ "Rationals()" ], [ IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInMAGMA, ar );
    
    SetIsFieldForHomalg( R, true );
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings in MAGMA",
        [ IsHomalgExternalRingInMAGMARep, IsList ],
        
  function( R, indets )
    local var, c, properties, r, var_of_coeff_ring, ext_obj, S, v;
    
    if IsString( indets ) and indets <> "" then
        var := SplitString( indets, "," ); 
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        var := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    c := Characteristic( R );
    
    properties := [ IsCommutative ];
    
    if Length( var ) = 1 and HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
        Add( properties, IsPrincipalIdealRing );
    fi;
    
    r := R;
    
    if HasIndeterminatesOfPolynomialRing( R ) then
        r := CoefficientsRing( R );
        var_of_coeff_ring := IndeterminatesOfPolynomialRing( R );
        if not ForAll( var_of_coeff_ring, HasName ) then
            Error( "the indeterminates of coefficients ring must all have a name (use SetName)\n" );
        fi;
        var_of_coeff_ring := List( var_of_coeff_ring, Name );
        if Intersection2( var_of_coeff_ring, var ) <> [ ] then
            Error( "the following indeterminates are already elements of the coefficients ring: ", Intersection2( var_of_coeff_ring, var ), "\n" );
        fi;
        var := Concatenation( var_of_coeff_ring, var );
    fi;
    
    if Length( var ) = 1 and HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) then
        ext_obj := homalgSendBlocking( [ "PolynomialRing(", r, ")" ], [ ], [ "<", var, ">" ], TheTypeHomalgExternalRingObjectInMAGMA, properties, "break_lists", HOMALG_IO.Pictograms.CreateHomalgRing );
    else
        ext_obj := homalgSendBlocking( [ "PolynomialRing(", r, Length( var ), ")" ], [ ], [ "<", var, ">" ], TheTypeHomalgExternalRingObjectInMAGMA, properties, "break_lists", HOMALG_IO.Pictograms.CreateHomalgRing );
    fi;
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMAGMA );
    
    var := List( var, a -> HomalgExternalRingElement( a, S ) );
    
    Perform( var, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsFreePolynomialRing( S, true );
    
    SetRingProperties( S, r, var );
    
    return S;
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings in MAGMA",
        [ IsHomalgExternalRingInMAGMARep, IsList ],
        
  function( R, indets )
    local var, nr_var, anti, nr_anti, properties, stream, r,
          ext_obj, S, v, RP;
    
    #check whether base ring is polynomial and then extract needed data
    if HasIndeterminatesOfPolynomialRing( R ) and IsCommutative( R ) then
        var := IndeterminatesOfPolynomialRing( R );
        nr_var := Length( var );
    else
        Error( "base ring is not a polynomial ring" );
    fi;
    
    ##get the new indeterminates (the anti commuting variables) for the ring and save them in anti
    if IsString( indets ) and indets <> "" then
        anti := SplitString( indets, "," );
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        anti := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    nr_anti := Length( anti );
    
    if nr_var <> nr_anti then
        Error( "number of indeterminates in base ring does not equal the number of anti commuting variables\n" );
    fi;
    
    if Intersection2( anti, var ) <> [ ] then
        Error( "the following indeterminate(s) are already elements of the base ring: ", Intersection2( anti, var ), "\n" );
    fi;
    
    if not ForAll( var, HasName ) then
        Error( "the indeterminates of base ring must all have a name (use SetName)\n" );
    fi;
    
    properties := [ ];
    
    stream := homalgStream( R );
    
    r := CoefficientsRing( R );
    
    ext_obj := homalgSendBlocking( [ "ExteriorAlgebra(", r, Length( anti ), ")" ], [ ], [ "<", anti, ">" ], TheTypeHomalgExternalRingObjectInMAGMA, "break_lists", HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMAGMA );
    
    anti := List( anti , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( anti, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsExteriorRing( S, true );
    
    SetRingProperties( S, R, anti );
    
    RP := homalgTable( S );
    
#    RP!.SetInvolution :=
#      function( R )
#        homalgSendBlocking( Concatenation(
#                [ "\nproc Involution (matrix M)\n{\n" ],
#                [ "  map F = ", R ],
#                Concatenation( List( IndeterminatesOfExteriorRing( R ), a -> [ a ] ) ),
#                [ ";\n  return( transpose( involution( M, F ) ) );\n}\n\n" ]
#                ), "need_command", HOMALG_IO.Pictograms.define );
#    end;
#    
#    RP!.SetInvolution( S );
    
    return S;
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for external matrices in MAGMA",
        [ IsHomalgExternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsString, IsHomalgExternalRingInMAGMARep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", r, c, "]:=", s ], "need_command", HOMALG_IO.Pictograms.SetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( AddToEntryOfHomalgMatrix,
        "for external matrices in MAGMA",
        [ IsHomalgExternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgExternalRingElementRep, IsHomalgExternalRingInMAGMARep ],
        
  function( M, r, c, a, R )
    
    homalgSendBlocking( [ M, "[", r, c, "]:=", a, "+", M, "[", r, c, "]" ], "need_command", HOMALG_IO.Pictograms.AddToEntryOfHomalgMatrix );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "for homalg matrices in MAGMA",
        [ IsString, IsHomalgExternalRingInMAGMARep ],
        
  function( S, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "Matrix(", R, ",", S, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "for a list of an external matrix in MAGMA",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMAGMARep ],
  function( S, r, c, R )
    
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "Matrix(", R, r, c, ",", S, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( CreateHomalgSparseMatrixFromString,
        "for a sparse list of an external matrix in MAGMA",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMAGMARep ],
        
  function( S, r, c, R )
    local M, s;
    
    M := HomalgVoidMatrix( r, c, R );
    
    s := homalgSendBlocking( S, R, HOMALG_IO.Pictograms.sparse );
    
    homalgSendBlocking( [ M, " := Matrix(SparseMatrix(", R, r, c, ", [<a,b,c> where a,b,c:= Explode(e): e in ", s, "] ))" ] , "need_command", HOMALG_IO.Pictograms.HomalgMatrix );
    
    return M;
    
end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for external matrices in MAGMA",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInMAGMARep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ M, "[", r, c, "]" ], "need_output", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for external matrices in MAGMA",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInMAGMARep ],
        
  function( M, r, c, R )
    local Mrc;
    
    Mrc := GetEntryOfHomalgMatrixAsString( M, r, c, R );
    
    return HomalgExternalRingElement( Mrc, R );
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for external matrices in MAGMA",
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
        "for external matrices in MAGMA",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMAGMARep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "[ [s[1], s[2], m[s[1], s[2] ] ] : s in Support(m)] where m:=", M ], "need_output", HOMALG_IO.Pictograms.GetSparseListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( SaveDataOfHomalgMatrixToFile,
        "for external matrices in MAGMA",
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
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.SaveDataOfHomalgMatrixToFile );
        
    fi;
    
    return true;
    
end );

##
InstallMethod( LoadDataOfHomalgMatrixFromFile,
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
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.LoadDataOfHomalgMatrixFromFile );
        
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

