#############################################################################
##
##  Maple.gi                  RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system Maple.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_Maple,
        rec(
            cas := "maple",		## normalized name on which the user should have no control
            name := "Maple",
            executable := "maple_for_homalg",
            executable_alt1 := "maple10",
            executable_alt2 := "maple11",
            executable_alt3 := "maple9",
            executable_alt4 := "maple",
            options := [ "-q" ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_BEGIN := 1,		## these are the most
            CUT_END := 4,		## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ":",
            define := ":=",
            prompt := "maple> ",
            output_prompt := "\033[1;34;47m<maple\033[0m ",
            display_color := "\033[0;34m",
           )
);

HOMALG_IO_Maple.READY_LENGTH := Length( HOMALG_IO_Maple.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IsHomalgExternalObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInMapleRep",
        IsHomalgExternalObjectWithIOStreamRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInMapleRep",
        IsHomalgExternalRingRep,
        [  ] );

# five new subrepresentations of the representation IsHomalgExternalRingInMapleRep:
DeclareRepresentation( "IsHomalgExternalRingInMapleUsingPIRRep",
        IsHomalgExternalRingInMapleRep,
        [  ] );

DeclareRepresentation( "IsHomalgExternalRingInMapleUsingInvolutiveRep",
        IsHomalgExternalRingInMapleRep,
        [  ] );

DeclareRepresentation( "IsHomalgExternalRingInMapleUsingJanetRep",
        IsHomalgExternalRingInMapleRep,
        [  ] );

DeclareRepresentation( "IsHomalgExternalRingInMapleUsingJanetOreRep",
        IsHomalgExternalRingInMapleRep,
        [  ] );

DeclareRepresentation( "IsHomalgExternalRingInMapleUsingOreModulesRep",
        IsHomalgExternalRingInMapleRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "HomalgExternalRingObjectInMapleType",
        NewType( HomalgRingsFamily,
                IsHomalgExternalRingObjectInMapleRep ) );

# five new types:
BindGlobal( "HomalgExternalRingInMapleUsingPIRType",
        NewType( HomalgRingsFamily,
                IsHomalgExternalRingInMapleUsingPIRRep ) );

BindGlobal( "HomalgExternalRingInMapleUsingInvolutiveType",
        NewType( HomalgRingsFamily,
                IsHomalgExternalRingInMapleUsingInvolutiveRep ) );

BindGlobal( "HomalgExternalRingInMapleUsingJanetType",
        NewType( HomalgRingsFamily,
                IsHomalgExternalRingInMapleUsingJanetRep ) );

BindGlobal( "HomalgExternalRingInMapleUsingJanetOreType",
        NewType( HomalgRingsFamily,
                IsHomalgExternalRingInMapleUsingJanetOreRep ) );

BindGlobal( "HomalgExternalRingInMapleUsingOreModulesType",
        NewType( HomalgRingsFamily,
                IsHomalgExternalRingInMapleUsingOreModulesRep ) );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInMapleUsingPIR,
  function( arg )
    local nargs, stream, o, table, ar, ext_obj;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IsHomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := HomalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Maple );
        o := 0;
    else
        o := 1;
    fi;
    
    table := HomalgSendBlocking( "copy(`PIR/homalg`)", stream );
    
    HomalgSendBlocking( [ "`homalg/homalg_options`(", table, ")" ], "need_command" );
    
    ar := [ [ arg[1], ",", table ], HomalgExternalRingObjectInMapleType, IsCommutative, IsPrincipalIdealRing, stream ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( HomalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, HomalgExternalRingInMapleUsingPIRType, IsCommutative, IsPrincipalIdealRing );
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingInvolutive,
  function( arg )
    local nargs, stream, o, table, var, ar, ext_obj;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IsHomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := HomalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Maple );
        o := 0;
    else
        o := 1;
    fi;
    
    table := HomalgSendBlocking( "copy(`Involutive/homalg`)", stream );
    
    HomalgSendBlocking( [ "`homalg/homalg_options`(", table, ")" ], "need_command" );
    
    if IsString( arg[1] ) then
        var := arg[1];
    else
        var := Flat( [ "[", JoinStringsWithSeparator( arg[1] ), "]" ] );
    fi;
    
    ar := [ [ var, ",", table ], HomalgExternalRingObjectInMapleType, IsCommutative, stream ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( HomalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, HomalgExternalRingInMapleUsingInvolutiveType, IsCommutative );
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingJanet,
  function( arg )
    local nargs, stream, o, table, var, ar, ext_obj;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IsHomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := HomalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Maple );
        o := 0;
    else
        o := 1;
    fi;
    
    table := HomalgSendBlocking( "copy(`Janet/homalg`)", stream );
    
    HomalgSendBlocking( [ "`homalg/homalg_options`(", table, ")" ], "need_command" );
    
    if IsString( arg[1] ) then
        var := arg[1];
    else
        var := Flat( [ "[", JoinStringsWithSeparator( arg[1] ), "]" ] );
    fi;
    
    ar := [ [ var, ",", table ], HomalgExternalRingObjectInMapleType, IsCommutative, stream ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( HomalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, HomalgExternalRingInMapleUsingJanetType );
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingJanetOre,
  function( arg )
    local nargs, stream, o, table, ar, ext_obj;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IsHomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := HomalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Maple );
        o := 0;
    else
        o := 1;
    fi;
    
    table := HomalgSendBlocking( "copy(`JanetOre/homalg`)", stream );
    
    HomalgSendBlocking( [ "`homalg/homalg_options`(", table, ")" ], "need_command" );
    
    ar := [ [ arg[1], ",", table ], HomalgExternalRingObjectInMapleType, stream ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( HomalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, HomalgExternalRingInMapleUsingJanetOreType );
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingOreModules,
  function( arg )
    local nargs, stream, o, table, ar, ext_obj;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IsHomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := HomalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Maple );
        o := 0;
    else
        o := 1;
    fi;
    
    table := HomalgSendBlocking( "copy(`OreModules/homalg`)", stream );
    
    HomalgSendBlocking( [ "`homalg/homalg_options`(", table, ")" ], "need_command" );
    
    ar := [ [ arg[1], ",", table ], HomalgExternalRingObjectInMapleType, stream ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( HomalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, HomalgExternalRingInMapleUsingOreModulesType );
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInMaple,
  function( arg )
    local nargs, stream, m, c, R;
    
    nargs := Length( arg );
    
    if nargs > 0 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IsHomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := HomalgStream( arg[nargs] );
        fi;
    fi;
    
    if nargs = 0 or arg[1] = 0 or ( nargs = 1 and IsBound( stream ) ) then
        m := "";
        c := 0;
        R := "[ ]";
    elif IsInt( arg[1] ) then
        m := AbsInt( arg[1] );
        c := m;
        if IsPrime( c ) then
            R := [ c ];
        else
            R := [ [ ], [ c ] ];
        fi;
    else
        Error( "the first argument must be an integer\n" );
    fi;
    
    if IsBound( stream ) then
        R := RingForHomalgInMapleUsingPIR( R, stream );
    else
        R := RingForHomalgInMapleUsingPIR( R );
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
InstallGlobalFunction( HomalgFieldOfRationalsInMaple,
  function( arg )
    local ar, R;
    
    ar := Concatenation( [ "[0]" ], arg );
    
    R := CallFuncList( RingForHomalgInMapleUsingPIR, ar );
    
    SetCharacteristic( R, 0 );
    
    SetIsFieldForHomalg( R, true );
    
    return R;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings",
        [ IsHomalgExternalRingInMapleRep, IsList ],
        
  function( R, indets )
    local var, c, r, var_of_coeff_ring, S, v;
    
    if IsString( indets ) and indets <> "" then
        var := SplitString( indets, "," ); 
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        var := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    c := Characteristic( R );
    
    r := R;
    
    if Length( var ) = 1 and HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
        S := RingForHomalgInMapleUsingPIR( Flat( [ "[", Flat( var ), ",", String( c ), "]" ] ), R );
    else
        if c > 0 then
            if IsPrime( c ) then
                HomalgSendBlocking( [ "`Involutive/InvolutiveOptions`(\"char\",", c, ")" ], "need_command", R );
            else
                Error( "the coefficients ring Z/", c, "Z is not directly supported by Involutive yet\n" );
            fi;
        elif HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
            HomalgSendBlocking( [ "`Involutive/InvolutiveOptions`(\"rational\",false)" ], "need_command", R );
        fi;
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
        S := RingForHomalgInMapleUsingInvolutive( var, R );
    fi;
    
    var := List( var, a -> HomalgExternalRingElement( a, "Maple" ) );
    
    for v in var do
        SetName( v, HomalgPointer( v ) );
    od;
    
    SetCoefficientsRing( S, r );
    SetCharacteristic( S, c );
    SetIndeterminatesOfPolynomialRing( S, var );
    
    return S;
    
end );

##
InstallMethod( \*,
        "for homalg rings",
        [ IsHomalgExternalRingInMapleRep, IsString ],
        
  function( R, indets )
    
    return PolynomialRing( R, SplitString( indets, "," ) );
    
end );

##
InstallMethod( HomalgMatrixInMaple,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgExternalRingRep ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ R, "[2][matrix](", String( Eval( M ) ), ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( HomalgMatrixInMaple,
        "for homalg matrices",
        [ IsString, IsHomalgExternalRingRep ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ R, "[2][matrix](", M, ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ], 1,
        
  function( o )
    local cas, stream, display_color;
    
    stream := HomalgStream( o );
    
    cas := stream.cas;
    
    if cas = "maple" then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        Print( display_color, HomalgSendBlocking( [ "convert(", o, ",matrix)" ], "need_display" ) );
        
    else
        
        TryNextMethod( );
        
    fi;
    
end);
