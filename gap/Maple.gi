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
            cas := "maple",	## normalized name on which the user should have no control
            name := "Maple",
            executable := "maple_for_homalg",
            executable_alt1 := "maple9",
            executable_alt2 := "maple10",
            executable_alt3 := "maple11",
            executable_alt4 := "maple",
            options := [ "-q" ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
	    CUT_BEGIN := 1,	## these is the most
            CUT_END := 4,	## delicate values!
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
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInPIRMaple,
  function( arg )
    local stream, init, table, ext_obj;
    
    stream := LaunchCAS( HOMALG_IO_Maple );
    
    init := HomalgExternalObject( "", "Maple", stream );
    
    HomalgSendBlocking( "with(PIR): with(homalg)", "need_command", init );
    
    table := HomalgSendBlocking( "`PIR/homalg`", init );
    
    HomalgSendBlocking( [ "homalg_options(", table, ")" ], "need_command" );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], arg[2] );
    else
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], IsHomalgRingInMaplePIR );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallGlobalFunction( RingForHomalgInInvolutiveMaple,
  function( arg )
    local stream, init, table, ext_obj;
    
    stream := LaunchCAS( HOMALG_IO_Maple );
    
    init := HomalgExternalObject( "", "Maple", stream );
    
    HomalgSendBlocking( "with(Involutive): with(homalg)", "need_command", init );
    
    table := HomalgSendBlocking( "`Involutive/homalg`", init );
    
    HomalgSendBlocking( [ "homalg_options(", table, ")" ], "need_command" );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], arg[2] );
    else
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], IsHomalgRingInMapleInvolutive );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallGlobalFunction( RingForHomalgInJanetMaple,
  function( arg )
    local stream, init, table, ext_obj;
    
    stream := LaunchCAS( HOMALG_IO_Maple );
    
    init := HomalgExternalObject( "", "Maple", stream );
    
    HomalgSendBlocking( "with(Janet): with(homalg)", "need_command", init );
    
    table := HomalgSendBlocking( "`Janet/homalg`", init );
    
    HomalgSendBlocking( [ "homalg_options(", table, ")" ], "need_command" );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], arg[2] );
    else
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], IsHomalgRingInMapleJanet );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallGlobalFunction( RingForHomalgInJanetOreMaple,
  function( arg )
    local stream, init, table, ext_obj;
    
    stream := LaunchCAS( HOMALG_IO_Maple );
    
    init := HomalgExternalObject( "", "Maple", stream );
    
    HomalgSendBlocking( "with(JanetOre): with(homalg)", "need_command", init );
    
    table := HomalgSendBlocking( "`JanetOre/homalg`", init );
    
    HomalgSendBlocking( [ "homalg_options(", table, ")" ], "need_command" );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], arg[2] );
    else
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], IsHomalgRingInMapleJanetOre );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallGlobalFunction( RingForHomalgInOreModulesMaple,
  function( arg )
    local stream, init, table, ext_obj;
    
    stream := LaunchCAS( HOMALG_IO_Maple );
    
    init := HomalgExternalObject( "", "Maple", stream );
    
    HomalgSendBlocking( "with(OreModules): with(homalg)", "need_command", init );
    
    table := HomalgSendBlocking( "`OreModules/homalg`", init );
    
    HomalgSendBlocking( [ "homalg_options(", table, ")" ], "need_command" );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], arg[2] );
    else
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], IsHomalgRingInMapleOreModules );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallMethod( HomalgMatrixInMaple,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgExternalRingRep and IsHomalgExternalObjectWithIOStream ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ R, "[2][matrix](", String( Eval( M ) ), ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( HomalgMatrixInMaple,
        "for homalg matrices",
        [ IsString, IsHomalgExternalRingRep and IsHomalgExternalObjectWithIOStream ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ R, "[2][matrix](", M, ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

