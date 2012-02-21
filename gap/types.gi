
##
InstallMethod( ViewObj, 
               "for an external polymake object",
               [ IsExternalPolymakeObject ],
  function( r )
    
    Print("<an external polymake object>");
    
end );

##
InstallMethod( ViewObj, 
               "for an external polymake object",
               [ IsExternalPolymakeCone ],
  function( r )
    
    Print("<an external polymake cone>");
    
end );

##
InstallMethod( ViewObj, 
               "for an external polymake object",
               [ IsExternalPolymakePolytope ],
  function( r )
    
    Print("<an external polymake polytope>");
    
end );

##
InstallMethod( ViewObj, 
               "for an external polymake object",
               [ IsExternalPolymakeFan ],
  function( r )
    
    Print("<an external polymake fan>");
    
end );

##
InstallMethod( Display, 
               "for an external polymake object",
               [ IsExternalPolymakeObject ],
  function( r )
    
    Print( "An external polymake object.\n");
    
end );

##
InstallMethod( Display, 
               "for an external polymake object",
               [ IsExternalPolymakeCone ],
  function( r )
    
    Print( "An external polymake cone.\n" );
    
end );

##
InstallMethod( Display, 
               "for an external polymake object",
               [ IsExternalPolymakePolytope ],
  function( r )
    
    Print( "An external polymake polytope.\n" );
    
end );

##
InstallMethod( ViewObj, 
               "for an external polymake object",
               [ IsExternalPolymakeFan ],
  function( r )
    
    Print( "An external polymake fan.\n" );
    
end );
