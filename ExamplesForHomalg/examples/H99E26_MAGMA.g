LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

LoadPackage( "Modules" );

P1 := LeftSubmodule( "x*y+y*z+z*x", R );
P2 := LeftSubmodule( "x^2+y,y*z+2", R );
P3 := LeftSubmodule( "x*y-1,y+z", R );

I := Intersect( P1, P2, P3 );

W := 1 * R / I;
