#############################################################################
##
##  Polymake.gd               ConvexForHomalg package           Sebastian Gutsche
##
##  Copyright 2011-2012 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Gives the Methods for Polymake
##
#############################################################################

## Making shure, package is Loaded.

LoadPackage("PolymakeForHomalg");

####################################
#
# Cone Methods
#
####################################

##
InstallMethod( EXT_GENERATE_CONE_BY_RAYS,
               "Create Cone in Polymake",
               [ IsList ],
               
  function( rays )
    
    return POLYMAKE_CREATE_CONE_BY_RAYS( rays );
    
end );

##
InstallMethod( EXT_CREATE_DUAL_CONE_OF_CONE,
               "Create Cone in Polymake",
               [ IsInt ],
               
  function( cone )
    
    return POLYMAKE_CREATE_DUAL_CONE_OF_CONE( cone );
    
end );


##
InstallMethod( EXT_GENERATING_RAYS_OF_CONE,
               "Create Cone in Polymake",
               [ IsInt ],
               
  function( cone )
    
    return POLYMAKE_GENERATING_RAYS_OF_CONE( cone );
    
end );