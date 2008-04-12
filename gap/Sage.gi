#############################################################################
##
##  Sage.gi                   RingsForHomalg package          Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system Sage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_Sage,
        rec(
            cas := "sage",		## normalized name on which the user should have no control
            name := "Sage",
            executable := "sage",
            options := [ ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_BEGIN := 7,		## these are the most
            CUT_END := 10,		## delicate values!
            eoc_verbose := "",
            eoc_quiet := ";",
            check_output := true,	## a Sage specific
            only_warning := "WARNING:",	## a Sage specific
            define := "=",
            prompt := "sage: ",
            output_prompt := "\033[1;34;43m<sage\033[0m ",
            display_color := "\033[0;34;43m",
           )
);
            
HOMALG_IO_Sage.READY_LENGTH := Length( HOMALG_IO_Sage.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInSageRep",
        IshomalgExternalObjectWithIOStreamRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInSageRep",
        IsHomalgExternalRingRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeHomalgExternalRingObjectInSage",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInSageRep ) );

# a new type:
BindGlobal( "TheTypeHomalgExternalRingInSage",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInSageRep ) );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInSage,
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
        stream := LaunchCAS( HOMALG_IO_Sage );
        o := 0;
    else
        o := 1;
    fi;
    
    ar := [ arg[1], TheTypeHomalgExternalRingObjectInSage, stream ];
    
    if Length( arg ) > 1 then
        ar := Concatenation( ar, arg{[ 2 .. Length( arg ) ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInSage );
    
end );

InstallGlobalFunction( HomalgRingOfIntegersInSage,
  function( arg )
    local nargs, stream, c, R, command;
    
    nargs := Length( arg );
    
    if nargs > 0 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if nargs = 0 or arg[1] = 0 or ( nargs = 1 and IsBound( stream ) ) then
        c := 0;
    elif IsInt( arg[1] ) then
        c := AbsInt( arg[1] );
    else
        Error( "the first argument must be an integer\n" );
    fi;
    
    if IsPrime(c) then
        command := "GF(";
    else
        command := "IntegerModRing(";
    fi;
    
    if IsBound( stream ) then
        R := RingForHomalgInSage( [ command, c, ")" ], IsPrincipalIdealRing, stream );
    else
        R := RingForHomalgInSage( [ command, c, ")" ], IsPrincipalIdealRing );
    fi;
    
    if IsPrime(c) then
        SetIsFieldForHomalg( R, true );
    else
        SetIsFieldForHomalg( R, false );
        SetIsIntegersForHomalg( R, true );
    fi;
    
    
    SetCharacteristic( R, c );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInSage,
  function( arg )
    local ar, R;
    
    ar := Concatenation( [ "QQ" ], [ IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInSage, ar );
    
    SetCharacteristic( R, 0 );
    
    SetIsFieldForHomalg( R, true );
    
    return R;
    
end );
##
InstallMethod( PolynomialRing,
        "for homalg rings",
        [ IsHomalgExternalRingInSageRep, IsList ],
        
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
    
    ext_obj := homalgSendBlocking( [ "PolynomialRing(", R, ")" ], [ ], [ ".<", var, ">" ], TheTypeHomalgExternalRingObjectInSage, properties, "break_lists" );
    
    S := CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInSage );
    
    var := List( var, a -> HomalgExternalRingElement( a, "Sage" ) );
    
    for v in var do
        SetName( v, homalgPointer( v ) );
    od;
    
    SetCoefficientsRing( S, r );
    SetCharacteristic( S, c );
    SetIndeterminatesOfPolynomialRing( S, var );
    
    return S;
    
end );

##
InstallMethod( CreateHomalgMatrixInExternalCAS,
        "for homalg matrices",
        [ IsString, IsHomalgExternalRingInSageRep ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "matrix(", R, ",", M, ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

