#############################################################################
##
##  RingsForHomalg.gi         RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for RingsForHomalg.
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
            color_display := "false"
           )
);

####################################
#
# constructor functions:
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
        ext_obj := HomalgSendBlocking( [ "CreateHomalgRing(", arg[1], ")" ], IsHomalgRingInExternalGAP, init );
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
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        Print( display_color, ring, "\033[0m\n" );
        
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
    
    if IsBound( stream.color_display ) then
        display_color := stream.color_display;
    else
        display_color := "";
    fi;
    
    cas := stream.cas;
    
    if cas = "gap" then
        Print( display_color, HomalgSendBlocking( [ "Display(", o, ")" ], "need_display" ) );
    elif cas = "maple" then
        Print( display_color, HomalgSendBlocking( [ "convert(", o, ",matrix)" ], "need_display" ) );
    else
        Print( display_color, HomalgSendBlocking( [ o ], "need_display" ) );
    fi;
    
end);

