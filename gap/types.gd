# Create types

PolymakeExternalObjectFamily := NewFamily( "ExternalPolymakeObjectFamily" );

## Maybe this is the wrong place, but I need this category.
## If there is time, there need to be a new package created.

DeclareCategory( "IsExternalObject", IsObject );

DeclareCategory( "IsExternalPolymakeObject", IsExternalObject );
DeclareCategory( "IsExternalPolymakeCone", IsExternalPolymakeObject );
DeclareCategory( "IsExternalPolymakeFan", IsExternalPolymakeObject );
DeclareCategory( "IsExternalPolymakePolytope", IsExternalPolymakeObject );
DeclareCategory( "IsExternalPolymakeTropicalHypersurface", IsExternalPolymakeObject );

TheTypeExternalPolymakeObject := NewType( PolymakeExternalObjectFamily, IsExternalPolymakeObject );
TheTypeExternalPolymakeCone := NewType( PolymakeExternalObjectFamily, IsExternalPolymakeCone );
TheTypeExternalPolymakeFan := NewType( PolymakeExternalObjectFamily, IsExternalPolymakeFan );
TheTypeExternalPolymakePolytope := NewType( PolymakeExternalObjectFamily, IsExternalPolymakePolytope );
TheTypeExternalPolymakeTropicalHypersurface := NewType( PolymakeExternalObjectFamily, IsExternalPolymakeTropicalHypersurface );
