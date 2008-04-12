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

