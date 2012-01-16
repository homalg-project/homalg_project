# Create types

DeclareCategory( "IsExternalPolymakeObject", IsExternalPointerObject );
DeclareCategory( "IsExternalPolymakeCone", IsExternalPolymakeObject );
DeclareCategory( "IsExternalPolymakeFan", IsExternalPolymakeObject );
DeclareCategory( "IsExternalPolymakePolytope", IsExternalPolymakeObject );

TheTypeExternalPolymakeObject := NewType( ExternalPointerObjectFamily, IsExternalPolymakeObject );
TheTypeExternalPolymakeCone := NewType( ExternalPointerObjectFamily, IsExternalPolymakeCone );
TheTypeExternalPolymakeFan := NewType( ExternalPointerObjectFamily, IsExternalPolymakeFan );
TheTypeExternalPolymakePolytope := NewType( ExternalPointerObjectFamily, IsExternalPolymakePolytope );
