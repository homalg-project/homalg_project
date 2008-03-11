#############################################################################
##
##  MapleHomalgInvolutive.gi           homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
## Implementations for the rings provided by the Maple package Involutive
## accessed via the Maple implementation of homalg.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for homalg rings provided by the maple package Involutive",
        [ IsHomalgExternalObjectRep
          and IsHomalgExternalObjectWithIOStream
          and IsHomalgInvolutiveMapleRing ],

  function( arg )
    local RP, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForMapleHomalgTools );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForMapleHomalgBestBasis );
    
    RP_specific :=
          rec( 
               
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (HomalgTable gives no default value)
               
               RingName := R -> HomalgSendBlocking( [ "\"Q[", R, "[1]\"" ], "need_display" ),
               
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
                   
               Zero := HomalgExternalObject( "0", "Maple" ),
               
               One := HomalgExternalObject( "1", "Maple" ),
               
               MinusOne := HomalgExternalObject( "(-1)", "Maple" )
               
          );
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( HomalgTableType, RP );
    
    return RP;
    
end );
