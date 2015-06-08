# Create types

PolymakeExternalObjectFamily := NewFamily( "ExternalPolymakeObjectFamily" );

## Maybe this is the wrong place, but I need this category.
## If there is time, there need to be a new package created.

DeclareCategory( "IsExternalObject", IsObject );

DeclareCategory( "IsExternalPolymakeObject", IsExternalObject );
DeclareCategory( "IsExternalPolymakeCone", IsExternalPolymakeObject );
DeclareCategory( "IsExternalPolymakeFan", IsExternalPolymakeObject );
DeclareCategory( "IsExternalPolymakePolytope", IsExternalPolymakeObject );

TheTypeExternalPolymakeObject := NewType( PolymakeExternalObjectFamily, IsExternalPolymakeObject );
TheTypeExternalPolymakeCone := NewType( PolymakeExternalObjectFamily, IsExternalPolymakeCone );
TheTypeExternalPolymakeFan := NewType( PolymakeExternalObjectFamily, IsExternalPolymakeFan );
TheTypeExternalPolymakePolytope := NewType( PolymakeExternalObjectFamily, IsExternalPolymakePolytope );

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