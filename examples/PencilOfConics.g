LoadPackage( "Sheaves" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

O := n -> ( 1 * R )^n;

p1 := HomalgMatrix( "[ x, y ]", 2, 1, R );

p2 := HomalgMatrix( "[ x - z, y ]", 2, 1, R );

p3 := HomalgMatrix( "[ x, y - z ]", 2, 1, R );

p4 := HomalgMatrix( "[ x - y, y - z ]", 2, 1, R );

p1 := Subobject( p1, O( 0 ) );

p2 := Subobject( p2, O( 0 ) );

p3 := Subobject( p3, O( 0 ) );

p4 := Subobject( p4, O( 0 ) );

pencil := Intersect( p1, p2, p3, p4 );

pencil := HomogeneousPartOverCoefficientsRing( 2, pencil );

pencil := AsLinearSystem( pencil );
