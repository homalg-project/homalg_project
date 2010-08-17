LoadPackage( "GradeModules" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

p1 := GradedLeftSubmodule( "[ x, y ]", R );

p2 := GradedLeftSubmodule( "[ x - z, y ]", R );

p3 := GradedLeftSubmodule( "[ x, y - z ]", R );

p4 := GradedLeftSubmodule( "[ x - y, y - z ]", R );

pencil := Intersect( p1, p2, p3, p4 );

pencil := HomogeneousPartOverCoefficientsRing( 2, pencil );

pencil := AsLinearSystem( pencil );
