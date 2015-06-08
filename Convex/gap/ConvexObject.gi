#############################################################################
##
##  ConvexObject.gd               Convex package       Sebastian Gutsche
##
##  Copyright 2011-2012 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Main Object to be viewed, is almost everything that has a number ;).
##
#############################################################################

################################
##
## Attributes
##
################################

##
InstallMethod( ContainingGrid,
               " for convex objects",
               [ IsConvexObject ],
               
  function( convobj )
    
    return AmbientSpaceDimension( convobj ) * HOMALG_MATRICES.ZZ;
    
end );

################################
##
## Basic Properties
##
################################

##
InstallMethod( WeakPointerToExternalObject,
               "for external objects",
               [ IsExternalConvexObjectRep ],
               
  function( convobj )
    
    return ExternalObject( convobj );
    
end );

##
InstallMethod( DrawObject,
               " for external objects",
               [ IsExternalConvexObjectRep ],
               
  function( convobj )
    
    return EXT_DRAW( ExternalObject( convobj ) );
    
end );

##
InstallMethod( ExternalObject,
               "for convex objects",
               [ IsExternalConvexObjectRep ],
               
  function( convobj )
    
    Error( "something went wrong\n" );
    
    TryNextMethod();
    
end );
