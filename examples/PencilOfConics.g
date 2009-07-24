## http://www.math.uiuc.edu/Macaulay2/doc/Macaulay2-1.1/share/doc/Macaulay2/Macaulay2Doc/html/___Tutorial_co_sp__Canonical_sp__Embeddings_spof_sp__Plane_sp__Curves_spand_sp__Gonality.html

LoadPackage( "Sheaves" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

p1 := HomalgMatrix( "[ x, y ]", 1, 2, R );

p2 := HomalgMatrix( "[ x - z, y ]", 1, 2, R );

p3 := HomalgMatrix( "[ x, y - z ]", 1, 2, R );

p4 := HomalgMatrix( "[ x - y, y - z ]", 1, 2, R );

p1 := Subobject( p1, ( R * 1 )^0 );

p2 := Subobject( p2, ( R * 1 )^0 );

p3 := Subobject( p3, ( R * 1 )^0 );

p4 := Subobject( p4, ( R * 1 )^0 );

pencil := Iterated( [ p1, p2, p3, p4 ], Intersect );

