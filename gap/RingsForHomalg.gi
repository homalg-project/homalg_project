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

##
InstallValue( HOMALG_RINGS,
        rec(
            RingOfIntegersDefaultCAS := "Maple",
            FieldOfRationalsDefaultCAS := "Singular",
           )
);

##
InstallValue( CommonHomalgTableForRings,
        rec(
            RingName :=
              function( R )
                local var,der;
                
                if HasName( R ) then
                    return Name( R );
                fi;
                
                ## the Weyl-Algebra:
                if HasIndeterminateCoordinatesOfRingOfDerivations( R ) and
                   HasIndeterminateDerivationsOfRingOfDerivations( R ) then
                    
                    var := JoinStringsWithSeparator( List( IndeterminateCoordinatesOfRingOfDerivations( R ), String ) );
                    der := JoinStringsWithSeparator( List( IndeterminateDerivationsOfRingOfDerivations( R ), String ) );
                    
                    return String( Concatenation( [ RingName( CoefficientsRing( R ) ), "[", var, "]<", der, ">" ] ) );
                    
                ## the exterior algebra:
                elif HasIndeterminatesOfExteriorRing( R ) then
                    
                    var := JoinStringsWithSeparator( List( IndeterminatesOfExteriorRing( R ), String ) );
                    
                    return String( Concatenation( [ RingName( CoefficientsRing( R ) ), "{", var, "}" ] ) );
                    
                ## the (free) polynomial ring:
                elif HasIndeterminatesOfPolynomialRing( R ) then
                    
                    var := JoinStringsWithSeparator( List( IndeterminatesOfPolynomialRing( R ), String ) );
                    
                    return String( Concatenation( [ RingName( CoefficientsRing( R ) ), "[", var, "]" ] ) );
                    
                ## certain fields:
                elif HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
                    
                    if Characteristic( R ) = 0 then
                       return "Q";
                   else
                       return Concatenation( "GF(", String( Characteristic( R ) ), ")" );
                   fi;
                   
               else
                   
                   return "some Ring";
                   
               fi;
               
           end,
         
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
