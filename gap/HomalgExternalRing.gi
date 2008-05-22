#############################################################################
##
##  HomalgExternalRing.gi     IO_ForHomalg package           Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for external rings.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( homalgPointer,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    
    return homalgPointer( R!.ring );
    
end );

##
InstallMethod( homalgExternalCASystem,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    
    return homalgExternalCASystem( R!.ring );
    
end );

##
InstallMethod( homalgExternalCASystemVersion,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    
    return homalgExternalCASystemVersion( R!.ring );
    
end );

##
InstallMethod( homalgStream,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    
    return homalgStream( R!.ring );
    
end );

##
InstallMethod( homalgExternalCASystemPID,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    
    return homalgExternalCASystemPID( R!.ring );
    
end );

##
InstallMethod( homalgLastWarning,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    
    homalgLastWarning( R!.ring );
    
end );

##
InstallMethod( homalgNrOfWarnings,
        "for homalg rings",
        [ IsHomalgExternalRingRep ],
        
  function( R )
    
    return homalgNrOfWarnings( R!.ring );
    
end );

##
InstallMethod( homalgSetName,
        "for homalg ring elements",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep, IsString ],
        
  function( r, name )
    
    homalgSetName( r, name, HomalgRing( r ) );
    
end );

##
InstallMethod( homalgSetName,
        "for homalg ring elements",
        [ IshomalgExternalObjectWithIOStreamRep and IsHomalgExternalRingElementRep, IsString, IsHomalgExternalRingRep ],
        
  function( r, name, R )
    
    SetName( r, homalgSendBlocking( [ r ], "need_output", HOMALG_IO.Pictograms.homalgSetName ) );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg external rings",
        [ IsHomalgExternalRingRep ],
        
  function( o )
    
    Print( "<A homalg external ring residing in the CAS " );
    
    if IsBound( homalgStream( o ).color_display ) then
        Print( "\033[1m" );
    fi;
    
    Print( homalgExternalCASystem( o ), "\033[0m running with pid ", homalgExternalCASystemPID( o ), ">" );
    
end );

InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgExternalRingRep ],
        
  function( o )
    local RP, ring, stream, cas, display_color;
    
    RP := homalgTable( o );
    
    if IsBound(RP!.RingName) then
        if IsFunction( RP!.RingName ) then
            ring := RP!.RingName( o );
        else
            ring := RP!.RingName;
        fi;
    else
        ring := RingName( o );
    fi;
    
    stream := homalgStream( o );
    
    if IsBound( stream.color_display ) then
        display_color := stream.color_display;
    else
        display_color := "";
    fi;
    
    Print( display_color, ring, "\033[0m\n" );
    
end );
