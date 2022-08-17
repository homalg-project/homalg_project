# SPDX-License-Identifier: GPL-2.0-or-later
# ExamplesForHomalg: Examples for the GAP Package homalg
#
# Implementations
#

##  Implementation stuff for ExamplesForHomalg.

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

BindGlobal( "HOMALG_EXAMPLES",
        rec(
            OwnRingOrReadFile := 1
            )
);

####################################
#
# global functions and operations:
#
####################################

## an easy way of calling the example script ExamplesForHomalg/examples/examples.g
InstallMethod( ExamplesForHomalg,
        [ IsInt ],
        
  function( d )
    local directory, separator;
    
    if IsBound( PackageInfo("ExamplesForHomalg")[1] ) and
       IsBound( PackageInfo("ExamplesForHomalg")[1].InstallationPath ) then
        directory := PackageInfo("ExamplesForHomalg")[1].InstallationPath;
    else
        directory := "./";
    fi;
    
    if IsBound( GAPInfo.UserHome ) then
        separator := GAPInfo.UserHome{[1]};
    else
        separator := "/";
    fi;
    
    if Length( directory ) > 0 and directory{[Length( directory )]} <> separator then
        directory := Concatenation( directory, separator );
    fi;
    
    HOMALG_EXAMPLES.OwnRingOrReadFile := d;
    
    Read( Concatenation( directory, "examples", separator, "examples.g" ) );
    
end );

##
InstallMethod( ExamplesForHomalg,
        [ ],
        
  function( )
    
    if IsBound( HOMALG_EXAMPLES.OwnRingOrReadFile ) and
       IsPosInt( HOMALG_EXAMPLES.OwnRingOrReadFile ) then
        ExamplesForHomalg( HOMALG_EXAMPLES.OwnRingOrReadFile );
    else
        ExamplesForHomalg( 1 );
    fi;
    
end );
