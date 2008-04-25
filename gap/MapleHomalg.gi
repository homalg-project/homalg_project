#############################################################################
##
##  MapleHomalg.gi            RingsForHomalg package         Mohamed Barakat
##                                                            Simon Goertzen
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

# a new subrepresentation of the representation IshomalgExternalObjectWithIOStreamRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInMapleRep",
        IshomalgExternalObjectWithIOStreamRep,
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
BindGlobal( "TheTypeHomalgExternalRingObjectInMaple",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMapleRep ) );

# five new types:
BindGlobal( "TheTypeHomalgExternalRingInMapleUsingPIR",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInMapleUsingPIRRep ) );

BindGlobal( "TheTypeHomalgExternalRingInMapleUsingInvolutive",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInMapleUsingInvolutiveRep ) );

BindGlobal( "TheTypeHomalgExternalRingInMapleUsingJanet",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInMapleUsingJanetRep ) );

BindGlobal( "TheTypeHomalgExternalRingInMapleUsingJanetOre",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInMapleUsingJanetOreRep ) );

BindGlobal( "TheTypeHomalgExternalRingInMapleUsingOreModules",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInMapleUsingOreModulesRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( homalgLaTeX,
        "for external objects",
        [ IsHomalgExternalMatrixRep ],
        
  function( o )
    local R;
    
    R := HomalgRing( o );
    
    if IsHomalgExternalRingInMapleRep( R ) then
        
        Print( homalgSendBlocking( [ "latex(", o, ")" ], "need_display" ) );
        
    else
        
        TryNextMethod( );
        
    fi;

end );

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
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Maple );
        o := 0;
    else
        o := 1;
    fi;
    
    table := homalgSendBlocking( "copy(`PIR/homalg`)", stream );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", table, ")" ], "need_command" );
    
    ar := [ [ arg[1], ",", table ], TheTypeHomalgExternalRingObjectInMaple, IsCommutative, IsPrincipalIdealRing, stream ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInMapleUsingPIR, IsCommutative, IsPrincipalIdealRing );
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingInvolutive,
  function( arg )
    local nargs, stream, o, table, var, ar, ext_obj;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Maple );
        o := 0;
    else
        o := 1;
    fi;
    
    table := homalgSendBlocking( "copy(`Involutive/homalg`)", stream );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", table, ")" ], "need_command" );
    
    if IsString( arg[1] ) then
        var := arg[1];
    else
        var := Flat( [ "[", JoinStringsWithSeparator( arg[1] ), "]" ] );
    fi;
    
    ar := [ [ var, ",", table ], TheTypeHomalgExternalRingObjectInMaple, IsCommutative, stream ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInMapleUsingInvolutive, IsCommutative );
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingJanet,
  function( arg )
    local nargs, stream, o, table, var, ar, ext_obj;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Maple );
        o := 0;
    else
        o := 1;
    fi;
    
    table := homalgSendBlocking( "copy(`Janet/homalg`)", stream );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", table, ")" ], "need_command" );
    
    if IsString( arg[1] ) then
        var := arg[1];
    else
        var := Flat( [ "[", JoinStringsWithSeparator( arg[1] ), "]" ] );
    fi;
    
    ar := [ [ var, ",", table ], TheTypeHomalgExternalRingObjectInMaple, IsCommutative, stream ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInMapleUsingJanet );
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingJanetOre,
  function( arg )
    local nargs, stream, o, table, ar, ext_obj;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Maple );
        o := 0;
    else
        o := 1;
    fi;
    
    table := homalgSendBlocking( "copy(`JanetOre/homalg`)", stream );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", table, ")" ], "need_command" );
    
    ar := [ [ arg[1], ",", table ], TheTypeHomalgExternalRingObjectInMaple, stream ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInMapleUsingJanetOre );
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingOreModules,
  function( arg )
    local nargs, stream, o, table, ar, ext_obj;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Maple );
        o := 0;
    else
        o := 1;
    fi;
    
    table := homalgSendBlocking( "copy(`OreModules/homalg`)", stream );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", table, ")" ], "need_command" );
    
    ar := [ [ arg[1], ",", table ], TheTypeHomalgExternalRingObjectInMaple, stream ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInMapleUsingOreModules );
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInMaple,
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
        "for homalg rings in Maple",
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
                homalgSendBlocking( [ "`Involutive/InvolutiveOptions`(\"char\",", c, ")" ], "need_command", R );
            else
                Error( "the coefficients ring Z/", c, "Z is not directly supported by Involutive yet\n" );
            fi;
        elif HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
            homalgSendBlocking( [ "`Involutive/InvolutiveOptions`(\"rational\",false)" ], "need_command", R );
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
    
    var := List( var, a -> HomalgExternalRingElement( a, "Maple", S ) );
    
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
InstallGlobalFunction( MapleHomalgOptions,
  function( arg )
    local nargs, R, s, ar;
    
    nargs := Length( arg );
    
    R := arg[nargs];
    
    if not IsHomalgExternalRingInMapleRep( R ) then
        Error( "the last argument must be an external ring residing in Maple\n" );
    fi;
    
    s := "";
    
    for ar in arg{[ 1 .. nargs-1 ]} do
        if IsString( ar ) then
            s := Concatenation( s, ar, "," );
        elif IsList( ar ) and Length( ar ) = 2 and ForAll( ar, IsString ) then
            s := Concatenation( s, "\"", ar[1], "\"=", ar[2] , "," );
        else
            Error( "wrong argument: ", ar, "\n" );
        fi;
    od;
    
    Print( homalgSendBlocking( [ "`homalg/homalg_options`(", s, R, "[2])" ], "need_display" ) );
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsString, IsHomalgExternalRingInMapleRep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", r, c, "] := ", s ], "need_command" );
    
end );

##
InstallMethod( CreateHomalgMatrix,
        "for homalg matrices in Maple",
        [ IsString, IsHomalgExternalRingInMapleRep ],
        
  function( S, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ R, "[2][matrix](", S, ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgMatrix,
        "for homalg matrices in Maple",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMapleRep ],
        
  function( S, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ R, "[2][matrix](matrix(", r, c, ",", S, "))" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgSparseMatrix,
        "for a list of an external matrix in Maple",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMapleRep ],
        
  function( S, r, c, R )
    local M, l;
    
    M := HomalgInitialMatrix( r, c, R );
    
    l := homalgSendBlocking( S, R );
    
    homalgSendBlocking( [ "for i in ", l, " do ", M, "[i[1],i[2]]:=i[3]: od" ] , "need_command" );
    
    return M;
    
end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInMapleRep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ "convert(", M, "[", r, c, "],symbol)" ], "need_output" );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInMapleRep ],
        
  function( M, r, c, R )
    local Mrc;
    
    Mrc := GetEntryOfHomalgMatrixAsString( M, r, c, R );
    
    return HomalgExternalRingElement( Mrc, "Maple", R );
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMapleRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "convert(map(op,convert(", M, ",listlist)),symbol)" ], "need_output" );
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMapleRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "convert(convert(", M, ",listlist),symbol)" ], "need_output" );
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMapleRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "map(i->op(map(j->if ", M, "[i,j]<>", Zero( R ), " then [i,j,convert(", M, "[i,j],symbol)] fi, [$1..", NrColumns( M ),"])), [$1..", NrRows( M ),"])" ], "need_output" );
    
end );

##
InstallMethod( SaveDataOfHomalgMatrixToFile,
        "for external matrices in Maple",
        [ IsString, IsHomalgMatrix, IsHomalgExternalRingInMapleRep ],
        
  function( filename, M, R )
    local mode, command;
    
    if not IsBound( M!.SaveAs ) then
        mode := "ListList";
    else
        mode := M!.SaveAs; #not yet supported
    fi;
    
    if mode = "ListList" then
        command := [ "_fs := fopen(\"", filename, "\",WRITE): ",
                     "fprintf( _fs, %s, convert(convert(", M, ",listlist),string)): ",
		     "fflush( _fs ): ",
                     "fclose( _fs )" ];
        
        homalgSendBlocking( command, "need_command" );
        
    fi;
    
    return true;
    
end );

##
InstallMethod( LoadDataOfHomalgMatrixFromFile,
        "for external rings in Maple",
        [ IsString, IsHomalgExternalRingInMapleRep ],
        
  function( filename, R )
    local mode, command, M;
    
    if not IsBound( R!.LoadAs ) then
        mode := "ListList";
    else
        mode := R!.LoadAs; #not yet supported
    fi;
    
    M := HomalgVoidMatrix( R );
    
    if mode = "ListList" then
        
        command := [ "_fs := fopen(\"", filename, "\",READ): ",
                     "_str := readbytes( _fs, infinity, TEXT ): ",
                     "fclose( _fs ): ",
                     M, ":=", R, "[2][matrix]( parse( _str ))" ];
        
        homalgSendBlocking( command, "need_command" );
        
    fi;
    
    return M;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( Display,
        "for homalg matrices in Maple",
        [ IsHomalgExternalMatrixRep ], 1,
        
  function( o )
    
    if IsHomalgExternalRingInMapleRep( HomalgRing( o ) ) then
        
        Print(  homalgSendBlocking( [ HomalgRing( o ), "[2][matrix](", o, ")" ], "need_display" ) );
        
    else
        
        TryNextMethod( );
        
    fi;
    
end );
