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
    local str;
    
    str := [ "delete ", var_list ];
    
    homalgSendBlocking( str, "need_command", stream, "break_lists", HOMALG_IO.Pictograms.multiple_delete );
    
end );

##
InstallGlobalFunction( InitializeMAGMATools,
  function( stream )
    local IsDiagonalMatrix, BasisOfRowModule, BasisOfRowsCoeff,
          DecideZeroRows, DecideZeroRowsEffectively,
          SyzygiesGeneratorsOfRows;
    
    IsDiagonalMatrix := "\n\
IsDiagonalMatrix := function(M)\n\
  n:= Nrows(M);\n\
  m:= Ncols(M);\n\
  for i:= 1 to Min(n,m) do M[i,i]:= 0; end for;\n\
  return IsZero(M);\n\
end function;\n\n";
 
    
    BasisOfRowModule := "\n\
BasisOfRowModule := function(M)\n\
  S := Rowspace(M);\n\
  Groebner(S);\n\
  return BasisMatrix(S);\n\
end function;\n\n";
    
    BasisOfRowsCoeff := "\n\
BasisOfRowsCoeff:= function(M)\n\
  B := BasisOfRowModule(M);\n\
  T := Solution(M, B);\n\
  return B, T;\n\
end function;\n\n";
    
    DecideZeroRows := "\n\
DecideZeroRows:= function(A, B)\n\
  S := Rowspace(B);\n\
  F := Generic(S);\n\
  return Matrix( [Eltseq(NormalForm(F ! A[i], S)): i in [1..Nrows(A)]] );\n\
end function;\n\n";
    
    DecideZeroRowsEffectively := "\n\
DecideZeroRowsEffectively:= function(A, B)\n\
  S := Rowspace(B);\n\
  F := Generic(S);\n\
  M := Matrix( [Eltseq(NormalForm(F ! A[i], S)): i in [1..Nrows(A)]] );\n\
  MA := M-A;\n\
  T:= Matrix(BaseRing(A), [ Coordinates(S, S ! MA[i]): i in [1..Nrows(MA)]] );\n\
  return M, T;\n\
end function;\n\n";

    SyzygiesGeneratorsOfRows := "\n\
SyzygiesGeneratorsOfRows:= function(M1, M2)\n\
  if M2 cmpeq [] then\n\
    S := Rowspace(M1);\n\
  else\n\
    S := Rowspace( VerticalJoin(M1, M2) );\n\
  end if;\n\
  SM := SyzygyModule(S);\n\
  T := BasisMatrix(SM);\n\
  return ColumnSubmatrix(T, 1, Nrows(M1));\n\
end function;\n\n";

    homalgSendBlocking( IsDiagonalMatrix, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfRowModule, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( BasisOfRowsCoeff, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroRows, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( DecideZeroRowsEffectively, "need_command", stream, HOMALG_IO.Pictograms.define );
    homalgSendBlocking( SyzygiesGeneratorsOfRows, "need_command", stream, HOMALG_IO.Pictograms.define );
    
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
    
    return CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInMAGMA );
    
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
    
    if IsBound( stream ) then
        R := RingForHomalgInMAGMA( [ "IntegerRing(", m, ")" ], IsPrincipalIdealRing, stream );
    else
        R := RingForHomalgInMAGMA( [ "IntegerRing(", m, ")" ], IsPrincipalIdealRing );
    fi;
    
    SetCharacteristic( R, c );
    
    if IsPrime( c ) then
        SetIsFieldForHomalg( R, true );
    else
        SetIsFieldForHomalg( R, false );
        SetIsIntegersForHomalg( R, true );
    fi;
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInMAGMA,
  function( arg )
    local ar, R;
    
    ar := Concatenation( [ "Rationals()" ], [ IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInMAGMA, ar );
    
    SetCharacteristic( R, 0 );
    
    SetIsFieldForHomalg( R, true );
    
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
    
    if Length( var ) = 1 and IsFieldForHomalg( R ) then
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
    
    if Length( var ) = 1 then
        ext_obj := homalgSendBlocking( [ "PolynomialRing(", R, ")" ], [ ], [ "<", var, ">" ], TheTypeHomalgExternalRingObjectInMAGMA, properties, "break_lists", HOMALG_IO.Pictograms.CreateHomalgRing );
    else
        ext_obj := homalgSendBlocking( [ "PolynomialRing(", R, Length( var ), ")" ], [ ], [ "<", var, ">" ], TheTypeHomalgExternalRingObjectInMAGMA, properties, "break_lists", HOMALG_IO.Pictograms.CreateHomalgRing );
    fi;
    
    S := CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInMAGMA );
    
    var := List( var, a -> HomalgExternalRingElement( a, "MAGMA", S ) );
    
    for v in var do
        SetName( v, homalgPointer( v ) );
    od;
    
    SetCoefficientsRing( S, r );
    SetCharacteristic( S, c );
    SetIsCommutative( S, true );
    SetIndeterminatesOfPolynomialRing( S, var );
    
    return S;
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for external matrices in MAGMA",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsString, IsHomalgExternalRingInMAGMARep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", r, c, "] := ", s ], "need_command", HOMALG_IO.Pictograms.SetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( CreateHomalgMatrix,
        "for homalg matrices in MAGMA",
        [ IsString, IsHomalgExternalRingInMAGMARep ],
        
  function( S, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "Matrix(", R, ",", S, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgMatrix,
        "for a list of an external matrix in MAGMA",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMAGMARep ],
  function( S, r, c, R )
    
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "Matrix(", R, r, c, ",", S, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( CreateHomalgSparseMatrix,
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
    
    return HomalgExternalRingElement( Mrc, "MAGMA", R );
    
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

