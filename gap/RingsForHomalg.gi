#############################################################################
##
##  RingsForHomalg.gi         RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG_RINGS,
        rec(
            SaveHomalgMaximumBackStream := false,
            color_display := "false",
            gap_display := "\033[0;35m",
            singular_display := "\033[0;30;47m",
	    sage_display  := "\033[0;34;43m",
	    magma_display  := "\033[0;30;47m",
            maple_display := "\033[0;34m" ) );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalg,
  function( arg )
    local nargs, properties, ar, stream, init, table, ext_obj;
    
    nargs := Length( arg );
    
    properties := [ ];
    
    for ar in arg{[ 2 .. nargs ]} do
        if not IsBound( init ) and IsHomalgExternalRingRep( ar ) then
            init := ar;
        elif not IsBound( init ) and IsHomalgExternalObject( ar )
          and HasIsHomalgExternalObjectWithIOStream( ar ) and IsHomalgExternalObjectWithIOStream( ar ) then
            init := ar;
        elif IsFilter( ar ) then
            Add( properties, ar );
        else
            Error( "this argument should be in { IsString, IsFilter, IsHomalgExternalRingRep, IsHomalgExternalObjectWithIOStream } bur recieved: ", ar,"\n" );
        fi;
    od;
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ "CreateHomalgRing(", arg[1], ")" ], init );
    else
        ext_obj := HomalgSendBlocking( [ "CreateHomalgRing(", arg[1], ")" ], IsHomalgGAPRing, init );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallGlobalFunction( RingForHomalgInExternalGAP,
  function( arg )
    local stream, init, table, ext_obj;
    
    stream := LaunchGAP( );
    
    init := HomalgExternalObject( "", "GAP", stream );
    
    HomalgSendBlocking( "LoadPackage(\"homalg\")", "need_command", init );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ "CreateHomalgRing(", arg[1], ")" ], arg[2], init );
    else
        ext_obj := HomalgSendBlocking( [ "CreateHomalgRing(", arg[1], ")" ], IsHomalgGAPRing, init );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallGlobalFunction( RingForHomalgInSage,
  function( arg )
    local stream, ext_obj;
    
    stream := LaunchSage( );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgExternalObject( arg[1], "Sage", stream, arg[2] );
    else
        ext_obj := HomalgExternalObject( arg[1], "Sage", stream, IsHomalgSageRing );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallGlobalFunction( RingForHomalgInMagma,
  function( arg )
    local stream, ext_obj;
    
    stream := LaunchMagma( );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgExternalObject( arg[1], "MAGMA", stream, arg[2] );
    else
        ext_obj := HomalgExternalObject( arg[1], "MAGMA", stream, IsHomalgMagmaRing );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallGlobalFunction( RingForHomalgInPIRMaple9,
  function( arg )
    local stream, init, table, ext_obj;
    
    stream := LaunchMaple9( );
    
    init := HomalgExternalObject( "", "Maple", stream );
    
    HomalgSendBlocking( "with(PIR): with(homalg)", "need_command", init );
    
    table := HomalgSendBlocking( "`PIR/homalg`", init );
    
    HomalgSendBlocking( [ "homalg_options(", table, ")" ], "need_command" );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], arg[2] );
    else
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], IsHomalgPIRMapleRing );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallGlobalFunction( RingForHomalgInInvolutiveMaple9,
  function( arg )
    local stream, init, table, ext_obj;
    
    stream := LaunchMaple9( );
    
    init := HomalgExternalObject( "", "Maple", stream );
    
    HomalgSendBlocking( "with(Involutive): with(homalg)", "need_command", init );
    
    table := HomalgSendBlocking( "`Involutive/homalg`", init );
    
    HomalgSendBlocking( [ "homalg_options(", table, ")" ], "need_command" );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], arg[2] );
    else
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], IsHomalgInvolutiveMapleRing );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallGlobalFunction( RingForHomalgInJanetMaple9,
  function( arg )
    local stream, init, table, ext_obj;
    
    stream := LaunchMaple9( );
    
    init := HomalgExternalObject( "", "Maple", stream );
    
    HomalgSendBlocking( "with(Janet): with(homalg)", "need_command", init );
    
    table := HomalgSendBlocking( "`Janet/homalg`", init );
    
    HomalgSendBlocking( [ "homalg_options(", table, ")" ], "need_command" );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], arg[2] );
    else
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], IsHomalgJanetMapleRing );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallGlobalFunction( RingForHomalgInJanetOreMaple9,
  function( arg )
    local stream, init, table, ext_obj;
    
    stream := LaunchMaple9( );
    
    init := HomalgExternalObject( "", "Maple", stream );
    
    HomalgSendBlocking( "with(JanetOre): with(homalg)", "need_command", init );
    
    table := HomalgSendBlocking( "`JanetOre/homalg`", init );
    
    HomalgSendBlocking( [ "homalg_options(", table, ")" ], "need_command" );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], arg[2] );
    else
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], IsHomalgJanetOreMapleRing );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallGlobalFunction( RingForHomalgInOreModulesMaple9,
  function( arg )
    local stream, init, table, ext_obj;
    
    stream := LaunchMaple9( );
    
    init := HomalgExternalObject( "", "Maple", stream );
    
    HomalgSendBlocking( "with(OreModules): with(homalg)", "need_command", init );
    
    table := HomalgSendBlocking( "`OreModules/homalg`", init );
    
    HomalgSendBlocking( [ "homalg_options(", table, ")" ], "need_command" );
    
    if Length( arg ) > 1 and IsFilter( arg[2] ) then
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], arg[2] );
    else
        ext_obj := HomalgSendBlocking( [ arg[1], ",", table ], IsHomalgOreModulesMapleRing );
    fi;
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgExternalRingRep ],
        
  function( o )
    local RP, ring, stream, cas, display_color;
    
    RP := HomalgTable( o );
    
    if IsBound(RP!.RingName) then
        
        if IsFunction( RP!.RingName ) then
            ring := RP!.RingName( o );
        else
            ring := RP!.RingName;
        fi;
        
        stream := HomalgStream( o );
        
        if not IsBound( stream.cas ) then ## enforce saving the normalized name of the CAS in the stream
            HomalgSendBlocking( "\"hello world\"", o, "need_command" );
        fi;
        
        ## the normalized name of the CAS is now saved in the stream
        cas := stream.cas;
        
        if IsBound( stream.display_color ) then
            display_color := stream.display_color;
        else
            display_color := "";
        fi;
        
        if cas = "gap" then
            Print( display_color, ring, "\n\033[0m" );
        elif cas = "maple" then
            Print( display_color, ring, "\n\033[0m" );
        else
            Print( display_color, ring, "\n\033[0m" );
        fi;
        
    else
        
        TryNextMethod( );
        
    fi;
    
end);

InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( o )
    local stream, cas, display_color;
    
    stream := HomalgStream( o );
    
    if not IsBound( stream.cas ) then ## enforce saving the normalized name of the CAS in the stream
        HomalgSendBlocking( "\"hello world\"", HomalgRing( o ), "need_command" );
    fi;
    
    ## the normalized name of the CAS is now saved in the stream
    cas := stream.cas;
    
    if IsBound( stream.display_color ) then
        display_color := stream.display_color;
    else
        display_color := "";
    fi;
    
    if cas = "gap" then
        Print( display_color, HomalgSendBlocking( [ "Display(", o, ")" ], "need_display" ), "\033[0m" );
    elif cas = "maple" then
        Print( display_color, HomalgSendBlocking( [ "convert(", o, ",matrix)" ], "need_display" ), "\033[0m" );
    else
        Print( display_color, HomalgSendBlocking( [ o ], "need_display" ), "\033[0m" );
    fi;
    
end);

