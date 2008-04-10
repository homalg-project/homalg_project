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
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalg,
  function( arg )
    local nargs, properties, ar, stream, init, ext_obj;
    
    nargs := Length( arg );
    
    properties := [ ];
    
    ## FIXME: COMPLETE ME
    
end );

##
InstallMethod( \*,
        "for homalg rings",
        [ IsHomalgExternalRingRep, IsString ],
        
  function( R, indets )
    
    return PolynomialRing( R, SplitString( indets, "," ) );
    
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
        [ IsHomalgExternalMatrixRep ], 0, ## never higher!!!
        
  function( o )
    local stream, display_color;
    
    stream := HomalgStream( o );
    
    if IsBound( stream.color_display ) then
        display_color := stream.color_display;
    else
        display_color := "";
    fi;
    
    Print( display_color, HomalgSendBlocking( [ o ], "need_display" ) );
    
end);

