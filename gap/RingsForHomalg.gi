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
        rec( DefaultCAS := "Singular"
           )
);

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( HomalgRingOfIntegersInDefaultCAS,
        [ IsInt ],
  function( int )
    if not IsBound( HOMALG_RINGS.DefaultCAS ) or HOMALG_RINGS.DefaultCAS = "" then
        return HomalgRingOfIntegers( int );
    else
        return EvalString( Concatenation( "HomalgRingOfIntegersIn", HOMALG_RINGS.DefaultCAS, "(", String( int ), ")" ) );
    fi;
  end
);
  
InstallMethod( HomalgFieldOfRationalsInDefaultCAS,
        [ ],
  function( )
    if not IsBound( HOMALG_RINGS.DefaultCAS ) or HOMALG_RINGS.DefaultCAS = "" then
        return HomalgFieldOfRationals( );
    else
        return EvalString( Concatenation( "HomalgFieldOfRationalsIn", HOMALG_RINGS.DefaultCAS, "()" ) );
    fi;
  end
);
  
