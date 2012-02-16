# Create types

PolymakeExternalObjectFamily := NewFamily( "ExternalPolymakeObjectFamily" );

DeclareCategory( "IsExternalPolymakeObject", IsObject );
DeclareCategory( "IsExternalPolymakeCone", IsExternalPolymakeObject );
DeclareCategory( "IsExternalPolymakeFan", IsExternalPolymakeObject );
DeclareCategory( "IsExternalPolymakePolytope", IsExternalPolymakeObject );

TheTypeExternalPolymakeObject := NewType( PolymakeExternalObjectFamily, IsExternalPolymakeObject );
TheTypeExternalPolymakeCone := NewType( PolymakeExternalObjectFamily, IsExternalPolymakeCone );
TheTypeExternalPolymakeFan := NewType( PolymakeExternalObjectFamily, IsExternalPolymakeFan );
TheTypeExternalPolymakePolytope := NewType( PolymakeExternalObjectFamily, IsExternalPolymakePolytope );
