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
            RingOfIntegersDefaultCAS := "Maple",
            FieldOfRationalsDefaultCAS := "Singular",
           )
);

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgRingOfIntegersInDefaultCAS,
  function( arg )
    local nargs, integers;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsHomalgRing( arg[nargs] ) then
        integers := ValueGlobal( Concatenation( "HomalgRingOfIntegersIn", homalgExternalCASystem( arg[nargs] ) ) );
    elif not IsBound( HOMALG_RINGS.RingOfIntegersDefaultCAS ) or HOMALG_RINGS.RingOfIntegersDefaultCAS = "" then
        integers := HomalgRingOfIntegers;
    else
        integers := ValueGlobal( Concatenation( "HomalgRingOfIntegersIn", HOMALG_RINGS.RingOfIntegersDefaultCAS ) );
    fi;
    
    return CallFuncList( integers, arg );
    
end );

InstallGlobalFunction( HomalgFieldOfRationalsInDefaultCAS,
  function( arg )
    local nargs, rationals;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsHomalgRing( arg[nargs] ) then
        rationals := ValueGlobal( Concatenation( "HomalgFieldOfRationalsIn", homalgExternalCASystem( arg[nargs] ) ) );
    elif not IsBound( HOMALG_RINGS.FieldOfRationalsDefaultCAS ) or HOMALG_RINGS.FieldOfRationalsDefaultCAS = "" then
        rationals := HomalgFieldOfRationals;
    else
        rationals := ValueGlobal(  Concatenation( "HomalgFieldOfRationalsIn", HOMALG_RINGS.FieldOfRationalsDefaultCAS ) );
    fi;
    
    return CallFuncList( rationals, arg );
    
end );
