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
            CUT_POS_BEGIN := 1,		## these are the most
            CUT_POS_END := 4,		## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ":",
            error_stdout := "Error, ",	## a Maple specific
            define := ":=",
            delete := function( var, stream ) homalgSendBlocking( [ var, " := '", var, "'"  ], "need_command", stream, HOMALG_IO.Pictograms.delete ); end,
            multiple_delete := _Maple_multiple_delete,
            garbage_collector := function( stream ) homalgSendBlocking( [ "gc()" ], "need_command", stream, HOMALG_IO.Pictograms.garbage_collector ); end,
            prompt := "\033[01mmaple>\033[0m ",
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

# five new subrepresentations of the representation IsHomalgExternalRingObjectInMapleRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInMapleUsingPIRRep",
        IsHomalgExternalRingObjectInMapleRep,
        [  ] );

DeclareRepresentation( "IsHomalgExternalRingObjectInMapleUsingInvolutiveRep",
        IsHomalgExternalRingObjectInMapleRep,
        [  ] );

DeclareRepresentation( "IsHomalgExternalRingObjectInMapleUsingJanetRep",
        IsHomalgExternalRingObjectInMapleRep,
        [  ] );

DeclareRepresentation( "IsHomalgExternalRingObjectInMapleUsingJanetOreRep",
        IsHomalgExternalRingObjectInMapleRep,
        [  ] );

DeclareRepresentation( "IsHomalgExternalRingObjectInMapleUsingOreModulesRep",
        IsHomalgExternalRingObjectInMapleRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInMapleRep",
        IsHomalgExternalRingRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# five new types:
BindGlobal( "TheTypeHomalgExternalRingObjectInMapleUsingPIR",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMapleUsingPIRRep ) );

BindGlobal( "TheTypeHomalgExternalRingObjectInMapleUsingInvolutive",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMapleUsingInvolutiveRep ) );

BindGlobal( "TheTypeHomalgExternalRingObjectInMapleUsingJanet",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMapleUsingJanetRep ) );

BindGlobal( "TheTypeHomalgExternalRingObjectInMapleUsingJanetOre",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMapleUsingJanetOreRep ) );

BindGlobal( "TheTypeHomalgExternalRingObjectInMapleUsingOreModules",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMapleUsingOreModulesRep ) );

# a new types:
BindGlobal( "TheTypeHomalgExternalRingInMaple",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInMapleRep ) );

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
        
        Print( homalgSendBlocking( [ "latex(", o, ")" ], "need_display", HOMALG_IO.Pictograms.homalgLaTeX ) );
        
    else
        
        TryNextMethod( );
        
    fi;

end );

####################################
#
# global functions:
#
####################################

##
InstallGlobalFunction( _Maple_multiple_delete,
  function( var_list, stream )
    local str;
    
    str := [ "for _del in ", String( var_list ), " do unassign(convert(_del,symbol)) od" ];
    
    homalgSendBlocking( str, "need_command", stream, HOMALG_IO.Pictograms.multiple_delete );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInMapleUsingPIR,
  function( arg )
    local nargs, stream, o, display_color, homalg_version, package_version,
          ar, ext_obj, R, RP;
    
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
        if not IsBound( stream.path_to_maple_packages ) then	## each component in HOMALG_IO_Maple is now in the stream
            stream.path_to_maple_packages := Concatenation( PackageInfo( "RingsForHomalg" )[1].InstallationPath, "/maple" );
        fi;
        homalgSendBlocking( [ "libname := \"", stream.path_to_maple_packages, "\",libname" ], "need_command", stream, HOMALG_IO.Pictograms.initialize );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "with(PIR)", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ){[ 3 .. 8 ]};
        package_version := homalgSendBlocking("\`PIR/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ){[ 3 .. 8 ]};
        
        Print( "----------------------------------------------------------------\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     PIR - Maple package loaded (version: ", package_version, ")\n\
     Copyright (C) (2004-2006)\n\
     Lehrstuhl B fuer Mathematik, RWTH Aachen, Germany\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
----------------------------------------------------------------\n\n" );
        
    fi;
    
    ar := [ [ arg[1], ",", "copy(`PIR/homalg`)" ], TheTypeHomalgExternalRingObjectInMapleUsingPIR, IsCommutative, IsPrincipalIdealRing, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMaple, IsCommutative, IsPrincipalIdealRing );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", R, "[-1])" ], "need_command", HOMALG_IO.Pictograms.initialize );
    
    RP := homalgTable( R );
    
    RP!.Sum :=
      function( a, b )
        
        return homalgSendBlocking( [ "convert(", a, "+(", b, "),symbol)" ], "need_output", HOMALG_IO.Pictograms.Sum );
        
      end;
    
    RP!.Product :=
      function( a, b )
        
        return homalgSendBlocking( [ "convert((", a, ")*(", b, "),symbol)" ], "need_output", HOMALG_IO.Pictograms.Product );
        
      end;
    
    return R;
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingInvolutive,
  function( arg )
    local nargs, stream, o, display_color, homalg_version, package_version,
          var, ar, ext_obj, R, RP;
    
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
        if not IsBound( stream.path_to_maple_packages ) then	## each component in HOMALG_IO_Maple is now in the stream
            stream.path_to_maple_packages := Concatenation( PackageInfo( "RingsForHomalg" )[1].InstallationPath, "/maple" );
        fi;
        homalgSendBlocking( [ "libname := \"", stream.path_to_maple_packages, "\",libname" ], "need_command", stream, HOMALG_IO.Pictograms.initialize );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "with(Involutive)", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ){[ 3 .. 8 ]};
        package_version := EvalString( homalgSendBlocking("\`Involutive/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ) );
        
        Print( "----------------------------------------------------------------\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     Involutive - Maple package loaded (version: ", package_version, ")\n\
     Copyright (C) (2000-2009) Carlos F. Cid and Daniel Robertz\n\
     Lehrstuhl B fuer Mathematik, RWTH Aachen, Germany\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
----------------------------------------------------------------\n\n" );
        
    fi;
    
    if IsString( arg[1] ) then
        var := arg[1];
    else
        var := Flat( [ "[", JoinStringsWithSeparator( arg[1] ), "]" ] );
    fi;
    
    ar := [ [ var, ",", "copy(`Involutive/homalg`)" ], TheTypeHomalgExternalRingObjectInMapleUsingInvolutive, IsCommutative, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMaple, IsCommutative );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", R, "[-1])" ], "need_command", HOMALG_IO.Pictograms.initialize );
    
    RP := homalgTable( R );
    
    RP!.Sum :=
      function( a, b )
        
        return homalgSendBlocking( [ "convert(", a, "+(", b, "),symbol)" ], "need_output", HOMALG_IO.Pictograms.Sum );
        
      end;
    
    RP!.Product :=
      function( a, b )
        
        return homalgSendBlocking( [ "convert((", a, ")*(", b, "),symbol)" ], "need_output", HOMALG_IO.Pictograms.Product );
        
      end;
    
    return R;
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingInvolutiveLocal,
  function( arg )
    local nargs, stream, o, display_color, homalg_version, package_version,
          var, ar, ext_obj, R, RP;
    
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
        if not IsBound( stream.path_to_maple_packages ) then	## each component in HOMALG_IO_Maple is now in the stream
            stream.path_to_maple_packages := Concatenation( PackageInfo( "RingsForHomalg" )[1].InstallationPath, "/maple" );
        fi;
        homalgSendBlocking( [ "libname := \"", stream.path_to_maple_packages, "\",libname" ], "need_command", stream, HOMALG_IO.Pictograms.initialize );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "with(Involutive)", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ){[ 3 .. 8 ]};
        package_version := EvalString( homalgSendBlocking("\`Involutive/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ) );
        
        Print( "----------------------------------------------------------------\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     Involutive - Maple package loaded (version: ", package_version, ")\n\
     Copyright (C) (2000-2009) Carlos F. Cid and Daniel Robertz\n\
     The support for local rings was contributed by\n\
     Markus Lange-Hegermann\n\
     Lehrstuhl B fuer Mathematik, RWTH Aachen, Germany\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
----------------------------------------------------------------\n\n" );
        
    fi;
    
    if IsString( arg[1] ) then
        var := arg[1];
    else
        var := Flat( [ "[", JoinStringsWithSeparator( arg[1] ), "]" ] );
    fi;
    
    ar := [ [ var, ",", "copy(`LocalInvolutive/homalg`)" ], TheTypeHomalgExternalRingObjectInMapleUsingInvolutive, IsCommutative, IsLocalRing, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMaple, IsCommutative );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", R, "[-1])" ], "need_command", HOMALG_IO.Pictograms.initialize );
    
    RP := homalgTable( R );
    
    RP!.Sum :=
      function( a, b )
        
        return homalgSendBlocking( [ "convert(", a, "+(", b, "),symbol)" ], "need_output", HOMALG_IO.Pictograms.Sum );
        
      end;
    
    RP!.Product :=
      function( a, b )
        
        return homalgSendBlocking( [ "convert((", a, ")*(", b, "),symbol)" ], "need_output", HOMALG_IO.Pictograms.Product );
        
      end;
    
    return R;
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingInvolutiveLocalBasisfree,
  function( arg )
    local nargs, stream, o, display_color, homalg_version, package_version,
          var, ar, ext_obj, R, RP;
    
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
        if not IsBound( stream.path_to_maple_packages ) then	## each component in HOMALG_IO_Maple is now in the stream
            stream.path_to_maple_packages := Concatenation( PackageInfo( "RingsForHomalg" )[1].InstallationPath, "/maple" );
        fi;
        homalgSendBlocking( [ "libname := \"", stream.path_to_maple_packages, "\",libname" ], "need_command", stream, HOMALG_IO.Pictograms.initialize );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "with(Involutive)", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ){[ 3 .. 8 ]};
        package_version := EvalString( homalgSendBlocking("\`Involutive/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ) );
        
        Print( "----------------------------------------------------------------\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     Involutive - Maple package loaded (version: ", package_version, ")\n\
     Copyright (C) (2000-2009) Carlos F. Cid and Daniel Robertz\n\
     The support for local rings was contributed by\n\
     Markus Lange-Hegermann\n\
     Lehrstuhl B fuer Mathematik, RWTH Aachen, Germany\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
----------------------------------------------------------------\n\n" );
        
    fi;
    
    if IsString( arg[1] ) then
        var := arg[1];
    else
        var := Flat( [ "[", JoinStringsWithSeparator( arg[1] ), "]" ] );
    fi;
    
    ar := [ [ var, ",", "copy(`LocalInvolutiveBasisfree/homalg`)" ], TheTypeHomalgExternalRingObjectInMapleUsingInvolutive, IsCommutative, IsLocalRing, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMaple, IsCommutative );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", R, "[-1])" ], "need_command", HOMALG_IO.Pictograms.initialize );
    
    RP := homalgTable( R );
    
    RP!.Sum :=
      function( a, b )
        
        return homalgSendBlocking( [ "convert(", a, "+(", b, "),symbol)" ], "need_output", HOMALG_IO.Pictograms.Sum );
        
      end;
    
    RP!.Product :=
      function( a, b )
        
        return homalgSendBlocking( [ "convert((", a, ")*(", b, "),symbol)" ], "need_output", HOMALG_IO.Pictograms.Product );
        
      end;
    
    return R;
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingInvolutiveLocalBasisfreeGINV,
  function( arg )
    local nargs, stream, o, display_color, homalg_version, package_version,
          var, ar, ext_obj, R, RP;
    
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
        if not IsBound( stream.path_to_maple_packages ) then	## each component in HOMALG_IO_Maple is now in the stream
            stream.path_to_maple_packages := Concatenation( PackageInfo( "RingsForHomalg" )[1].InstallationPath, "/maple" );
        fi;
        homalgSendBlocking( [ "libname := \"", stream.path_to_maple_packages, "\",libname" ], "need_command", stream, HOMALG_IO.Pictograms.initialize );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "with(Involutive)", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ){[ 3 .. 8 ]};
        package_version := EvalString( homalgSendBlocking("\`Involutive/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ) );
        
        Print( "----------------------------------------------------------------\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     Involutive - Maple package loaded (version: ", package_version, ")\n\
     Copyright (C) (2000-2009) Carlos F. Cid and Daniel Robertz\n\
     The support for local rings was contributed by\n\
     Markus Lange-Hegermann\n\
     Lehrstuhl B fuer Mathematik, RWTH Aachen, Germany\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
----------------------------------------------------------------\n\n" );
        
    fi;
    
    if IsString( arg[1] ) then
        var := arg[1];
    else
        var := Flat( [ "[", JoinStringsWithSeparator( arg[1] ), "]" ] );
    fi;
    
    ar := [ [ var, ",", "copy(`LocalInvolutiveBasisfreeGINV/homalg`)" ], TheTypeHomalgExternalRingObjectInMapleUsingInvolutive, IsCommutative, IsLocalRing, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMaple, IsCommutative );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", R, "[-1])" ], "need_command", HOMALG_IO.Pictograms.initialize );
    
    RP := homalgTable( R );
    
    RP!.Sum :=
      function( a, b )
        
        return homalgSendBlocking( [ "convert(", a, "+(", b, "),symbol)" ], "need_output", HOMALG_IO.Pictograms.Sum );
        
      end;
    
    RP!.Product :=
      function( a, b )
        
        return homalgSendBlocking( [ "convert((", a, ")*(", b, "),symbol)" ], "need_output", HOMALG_IO.Pictograms.Product );
        
      end;
    
    return R;
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingJanet,
  function( arg )
    local nargs, stream, o, display_color, homalg_version, package_version,
          var, ar, ext_obj, R;
    
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
        if not IsBound( stream.path_to_maple_packages ) then	## each component in HOMALG_IO_Maple is now in the stream
            stream.path_to_maple_packages := Concatenation( PackageInfo( "RingsForHomalg" )[1].InstallationPath, "/maple" );
        fi;
        homalgSendBlocking( [ "libname := \"", stream.path_to_maple_packages, "\",libname" ], "need_command", stream, HOMALG_IO.Pictograms.initialize );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "with(Janet)", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ){[ 3 .. 8 ]};
        package_version := EvalString( homalgSendBlocking("\`Janet/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ) );
        
        Print( "----------------------------------------------------------------\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     Janet - Maple package loaded (version: ", package_version, ")\n\
     Copyright (C) (2000-2009) Carlos F. Cid and Daniel Robertz\n\
     Lehrstuhl B fuer Mathematik, RWTH Aachen, Germany\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
----------------------------------------------------------------\n\n" );
        
    fi;
    
    if IsString( arg[1] ) then
        var := arg[1];
    else
        var := Flat( [ "[", JoinStringsWithSeparator( arg[1] ), "]" ] );
    fi;
    
    ar := [ [ var, ",", "copy(`Janet/homalg`)" ], TheTypeHomalgExternalRingObjectInMapleUsingJanet, IsCommutative, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMaple );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", R, "[-1])" ], "need_command", HOMALG_IO.Pictograms.initialize );
    
    SetIsCommutative( R, false );
    
    return R;
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingJanetOre,
  function( arg )
    local nargs, stream, o, display_color, homalg_version, package_version,
          ar, ext_obj, R, RP;
    
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
        if not IsBound( stream.path_to_maple_packages ) then	## each component in HOMALG_IO_Maple is now in the stream
            stream.path_to_maple_packages := Concatenation( PackageInfo( "RingsForHomalg" )[1].InstallationPath, "/maple" );
        fi;
        homalgSendBlocking( [ "libname := \"", stream.path_to_maple_packages, "\",libname" ], "need_command", stream, HOMALG_IO.Pictograms.initialize );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "with(JanetOre)", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ){[ 3 .. 8 ]};
        package_version := EvalString( homalgSendBlocking("\`JanetOre/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ) );
        
        Print( "----------------------------------------------------------------\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     JanetOre - Maple package loaded (version: ", package_version, ")\n\
     Copyright (C) (2003-2009) Daniel Robertz\n\
     Lehrstuhl B fuer Mathematik, RWTH Aachen, Germany\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
----------------------------------------------------------------\n\n" );
        
    fi;
    
    ar := [ [ arg[1], ",", "copy(`JanetOre/homalg`)" ], TheTypeHomalgExternalRingObjectInMapleUsingJanetOre, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMaple );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", R, "[-1])" ], "need_command", HOMALG_IO.Pictograms.initialize );
    
    RP := homalgTable( R );
    
    RP!.Sum :=
      function( a, b )
        
        return homalgSendBlocking( [ "convert(", a, "+(", b, "),symbol)" ], "need_output", HOMALG_IO.Pictograms.Sum );
        
      end;
    
    return R;
    
end );

##
InstallGlobalFunction( RingForHomalgInMapleUsingOreModules,
  function( arg )
    local nargs, stream, o, display_color, homalg_version, package_version,
          ar, ext_obj, R, RP;
    
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
        if not IsBound( stream.path_to_maple_packages ) then	## each component in HOMALG_IO_Maple is now in the stream
            stream.path_to_maple_packages := Concatenation( PackageInfo( "RingsForHomalg" )[1].InstallationPath, "/maple" );
        fi;
        homalgSendBlocking( [ "libname := \"", stream.path_to_maple_packages, "\",libname" ], "need_command", stream, HOMALG_IO.Pictograms.initialize );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "with(OreModules)", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        homalg_version := homalgSendBlocking("\`homalg/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ){[ 3 .. 8 ]};
        package_version := EvalString( homalgSendBlocking("\`OreModules/version\`", "need_output", stream, HOMALG_IO.Pictograms.initialize ) );
        
        Print( "----------------------------------------------------------------\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
     OreModules - Maple package loaded (version: ", package_version, ")\n\
     F. Chyzak, A. Quadrat, D. Robertz\033[0m\n\
     (will be used as a ring package via Maple's homalg (ver: ", homalg_version, "))\033[0m\n\
----------------------------------------------------------------\n\n" );
        
    fi;
    
    ar := [ [ arg[1], ",", "copy(`OreModules/homalg`)" ], TheTypeHomalgExternalRingObjectInMapleUsingOreModules, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMaple );
    
    homalgSendBlocking( [ "`homalg/homalg_options`(", R, "[-1])" ], "need_command", HOMALG_IO.Pictograms.initialize );
    
    RP := homalgTable( R );
    
    RP!.Sum :=
      function( a, b )
        
        return homalgSendBlocking( [ "convert(", a, "+(", b, "),symbol)" ], "need_output", HOMALG_IO.Pictograms.Sum );
        
      end;
    
    return R;
    
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
    
    SetIsResidueClassRingOfTheIntegers( R, true );
    
    SetRingProperties( R, c );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInMaple,
  function( arg )
    local ar, R;
    
    ar := Concatenation( [ "[0]" ], arg );
    
    R := CallFuncList( RingForHomalgInMapleUsingPIR, ar );
    
    SetIsFieldForHomalg( R, true );
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings in Maple",
        [ IsHomalgExternalRingInMapleRep, IsList ],
        
  function( R, indets )
    local var, c, r, stream, show_banner, var_of_coeff_ring, S, v;
    
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
        stream := homalgStream( R );
        if IsBound( stream.show_banner ) then
            show_banner := stream.show_banner;
        fi;
        stream.show_banner := false;
        S := RingForHomalgInMapleUsingPIR( Flat( [ "[", Flat( var ), ",", String( c ), "]" ] ), R );
        if IsBound( show_banner ) then
            stream.show_banner := show_banner;
        else
            Unbind( stream.show_banner );
        fi;
    else
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
        if c > 0 then
            if IsPrime( c ) then
                homalgSendBlocking( [ "`Involutive/InvolutiveOptions`(\"char\",", c, ")" ], "need_command", R, HOMALG_IO.Pictograms.initialize );
            else
                Error( "the coefficients ring Z/", c, "Z is not directly supported by Involutive yet\n" );
            fi;
        elif HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
            homalgSendBlocking( [ "`Involutive/InvolutiveOptions`(\"rational\",false)" ], "need_command", R, HOMALG_IO.Pictograms.initialize );
        fi;
    fi;
    
    var := List( var, a -> HomalgExternalRingElement( a, S ) );
    
    Perform( var, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsFreePolynomialRing( S, true );
    
    if HasIndeterminatesOfPolynomialRing( R ) and IndeterminatesOfPolynomialRing( R ) <> [ ] then
        SetBaseRing( S, R );
    fi;
    
    SetRingProperties( S, r, var );
    
    return S;
    
end );

##
InstallMethod( RingOfDerivations,
        "for homalg rings in Maple",
        [ IsHomalgExternalRingInMapleRep, IsList ],
        
  function( R, indets )
    local var, nr_var, der, nr_der, properties, stream, ar, S, v;

    #check whether base ring is polynomial and then extract needed data
    if HasIndeterminatesOfPolynomialRing( R ) and IsCommutative( R ) then
      var := IndeterminatesOfPolynomialRing( R );
      nr_var := Length( var );
    else
      Error( "base ring is not a polynomial ring" );
    fi;
    
    ##compute the new indeterminates (the derivatives) for the ring and save them in der
    if IsString( indets ) and indets <> "" then
        der := SplitString( indets, "," );
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        der := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    nr_der := Length( der );
    
    if not(nr_var=nr_der) then
      Error( "number of indeterminates in base ring does not equal the number of given derivations" );
    fi;
    
    if Intersection2( der , var ) <> [ ] then
      Error( "the following indeterminates are already elements of the base ring: ", Intersection2( der , var ), "\n" );
    fi;
    
    if not ForAll( var, HasName ) then
      Error( "the indeterminates of base ring must all have a name (use SetName)\n" );
    fi;
    
    properties := [ ];
    
    stream := homalgStream( R );
    
    ar := JoinStringsWithSeparator( Concatenation( der, List( var, Name ) ) );
    ar := Concatenation( "[ [ ", ar, " ], [ ], [ " );
    ar := Concatenation( ar, JoinStringsWithSeparator( List( [ 1 .. nr_var ], i -> Concatenation( "weyl(", der[i], ",", Name( var[i] ), ")" ) ) ), " ] ]" );
    
    S := RingForHomalgInMapleUsingJanetOre( ar, stream );
    
    der := List( der , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( der, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsWeylRing( S, true );
    
    SetBaseRing( S, R );
    
    SetRingProperties( S, R, der );
    
    return S;
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings in Maple",
        [ IsHomalgExternalRingInMapleRep, IsHomalgExternalRingInMapleRep, IsList ],
        
  function( R, T, indets )
    local ar, var, anti, comm, stream, S;
    
    ar := _PrepareInputForExteriorRing( R, T, indets );
    
    var := ar[1];
    anti := ar[2];
    comm := ar[3];
    
    stream := homalgStream( R );
    
    ar := JoinStringsWithSeparator( Concatenation( comm, anti ) );
    ar := Concatenation( "[ [ ", ar, " ], [ ], [ " );
    ar := Concatenation( ar, Concatenation( "exterior(", JoinStringsWithSeparator( anti ), ")" ), " ] ]" );
    
    S := RingForHomalgInMapleUsingJanetOre( ar, stream );
    
    anti := List( anti , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( anti, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    comm := List( comm , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( comm, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsExteriorRing( S, true );
    
    SetBaseRing( S, T );
    
    SetRingProperties( S, R, anti );
    
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
    
    Print( homalgSendBlocking( [ "`homalg/homalg_options`(", s, R, "[-1])" ], "need_display", HOMALG_IO.Pictograms.initialize ) );
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsString, IsHomalgExternalRingInMapleRep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", r, c, "]:=", s ], "need_command", HOMALG_IO.Pictograms.SetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( AddToEntryOfHomalgMatrix,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgExternalRingElementRep, IsHomalgExternalRingInMapleRep ],
        
  function( M, r, c, a, R )
    
    homalgSendBlocking( [ M, "[", r, c, "]:=", a, "+", M, "[", r, c, "]" ], "need_command", HOMALG_IO.Pictograms.AddToEntryOfHomalgMatrix );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "for homalg matrices in Maple",
        [ IsString, IsHomalgExternalRingInMapleRep ],
        
  function( S, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ R, "[-1][matrix](", S, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "for homalg matrices in Maple",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMapleRep ],
        
  function( S, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ R, "[-1][matrix](`homalg/ConvertToListList`(", r, c, ",", S, ",", R, "[-1]))" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( CreateHomalgSparseMatrixFromString,
        "for a list of an external matrix in Maple",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMapleRep ],
        
  function( S, r, c, R )
    local M, s;
    
    M := HomalgInitialMatrix( r, c, R );
    
    s := homalgSendBlocking( S, R, HOMALG_IO.Pictograms.sparse );
    
    homalgSendBlocking( [ "for i in ", s, " do ", M, "[i[1],i[2]]:=i[3]: od" ] , "need_command", HOMALG_IO.Pictograms.HomalgMatrix );
    
    return M;
    
end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInMapleRep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ "convert(", M, "[", r, c, "],symbol)" ], "need_output", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInMapleRep ],
        
  function( M, r, c, R )
    local Mrc;
    
    Mrc := GetEntryOfHomalgMatrixAsString( M, r, c, R );
    
    return HomalgExternalRingElement( Mrc, R );
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMapleRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "convert(map(op,convert(", M, ",listlist)),symbol)" ], "need_output", HOMALG_IO.Pictograms.GetListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMapleRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "convert(convert(", M, ",listlist),symbol)" ], "need_output", HOMALG_IO.Pictograms.GetListListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInMapleRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "map(i->op(map(j->if ", M, "[i,j]<>", Zero( R ), " then [i,j,convert(", M, "[i,j],symbol)] fi, [$1..", NrColumns( M ),"])), [$1..", NrRows( M ),"])" ], "need_output", HOMALG_IO.Pictograms.GetSparseListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( SaveHomalgMatrixToFile,
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
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.SaveHomalgMatrixToFile );
        
    fi;
    
    return true;
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
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
                     M, ":=", R, "[-1][matrix](parse( _str ))" ];
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.LoadHomalgMatrixFromFile );
        
    fi;
    
    return M;
    
end );

##
InstallMethod( homalgSetName,
        "for homalg ring elements",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep, IsString, IsHomalgExternalRingInMapleRep ],
        
  function( r, name, R )
    
    SetName( r, homalgSendBlocking( [ "convert( ", r, ", symbol )" ], "need_output", HOMALG_IO.Pictograms.homalgSetName ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( Display,
        "for homalg matrices in Maple",
        [ IsHomalgExternalMatrixRep ], 1,
        
  function( o )
    
    if IsHomalgExternalRingInMapleRep( HomalgRing( o ) ) then
        
        Print(  homalgSendBlocking( [ "eval(", HomalgRing( o ), "[-1][matrix](", o, "))" ], "need_display", HOMALG_IO.Pictograms.Display ) );
        
    else
        
        TryNextMethod( );
        
    fi;
    
end );

##
InstallMethod( DisplayRing,
        "for homalg rings in Maple",
        [ IsHomalgExternalRingInMapleRep ], 1,
        
  function( o )
    
    homalgDisplay( [ o, "[1]" ] );
    
end );

