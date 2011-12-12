#############################################################################
##
##  Polymake.gd               ConvexForHomalg package           Sebastian Gutsche
##
##  Copyright 2011-2012 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Gives the Methods for Polymake
##
#############################################################################

####################################
#
# Cone Methods
#
####################################

##
InstallMethod( EXT_CREATE_CONE_BY_RAYS,
               "Create Cone in Polymake",
               [ IsList ],
               
  function( rays )
    
    return POLYMAKE_CREATE_CONE_BY_RAYS( rays );
    
end );

##
InstallMethod( EXT_CREATE_DUAL_CONE_OF_CONE,
               "Create Cone in Polymake",
               [ IsPolymakeConeRep ],
               
  function( cone )
    
    return POLYMAKE_CREATE_DUAL_CONE_OF_CONE( cone );
    
end );


##
InstallMethod( EXT_GENERATING_RAYS_OF_CONE,
               "Create Cone in Polymake",
               [ IsPolymakeConeRep ],
               
  function( cone )
    
    return POLYMAKE_GENERATING_RAYS_OF_CONE( cone );
    
end );


####################################
##
## Property functions
##
####################################

##
InstallMethod( EXT_IS_POINTED_CONE,
                "Checks if some cone is pointed",
                [ IsPolymakeConeRep ],
                
  function( cone )
    
    return POLYMAKE_IS_STRICTLY_CONVEX_CONE( WeakPointerToExternalObject( cone ) );
    
end );