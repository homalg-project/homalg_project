#############################################################################
##
##  HomalgRings.gi            HomalgRings package            Mohamed Barakat
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

InstallValue( HOMALG_RINGS, rec( SaveHomalgMaximumBackStream := false, color_display := "false", maple_display := "\033[0;34m" ) );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( o )
    local stream, cas, display_color;
    
    stream := HomalgStream( o );
    
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

