#############################################################################
##
##  MAGMA.gi                  RingsForHomalg package         Mohamed Barakat
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
            CUT_BEGIN := 1,		## these are the most
            CUT_END := 2,		## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";",
            remove_enter := true,       ## a MAGMA specific
            define := ":=",
            prompt := "magma> ",
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
    
    ar := [ arg[1], TheTypeHomalgExternalRingObjectInMAGMA, stream ];
    
    if Length( arg ) > 1 then
        ar := Concatenation( ar, arg{[ 2 .. Length( arg ) ]} );
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
        "for homalg rings",
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
    
    ext_obj := homalgSendBlocking( [ "PolynomialRing(", R, ")" ], [ ], [ "<", var, ">" ], TheTypeHomalgExternalRingObjectInMAGMA, properties, "break_lists" );
    
    S := CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInMAGMA );
    
    var := List( var, a -> HomalgExternalRingElement( a, "MAGMA" ) );
    
    for v in var do
        SetName( v, homalgPointer( v ) );
    od;
    
    SetCoefficientsRing( S, r );
    SetCharacteristic( S, c );
    SetIndeterminatesOfPolynomialRing( S, var );
    
    return S;
    
end );

##
InstallMethod( CreateHomalgMatrix,
        "for homalg matrices",
        [ IsString, IsHomalgExternalRingInMAGMARep ],
        
  function( S, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "Matrix(", R, ",", S, ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgMatrix,
        "for a list of an (external) matrix",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMAGMARep ],
  function( S, r, c, R )
    
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "Matrix(", R, r, c, ",", S, ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgSparseMatrix,
        "for homalg matrices",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMAGMARep ],
        
  function( S, r, c, R )
    local M, l;
    
    M := HomalgVoidMatrix( r, c, R );
    
    l := homalgSendBlocking( S, R );
    
    homalgSendBlocking( [ M, " := Matrix(SparseMatrix(", R, r, c, ", [<a,b,c> where a,b,c:= Explode(e): e in ", S, "] ))" ] , "need_command" );
    
    return M;
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for maple matrices",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMAGMARep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "Eltseq(", M, ")" ], "need_output" );
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for maple matrices",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMAGMARep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "RowSequence(", M, ")" ], "need_output" );
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for maple matrices",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMAGMARep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "[ [s[1], s[2], m[s[1], s[2] ] ] : s in Support(m)] where m:=", M ], "need_output" );
    
end );

