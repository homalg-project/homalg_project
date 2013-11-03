LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,l,m";

var := Indeterminates( R );

x := var[1]; y := var[2]; z := var[3]; l := var[4]; m := var[5];

LoadPackage( "Modules" );

L := LeftSubmodule( [ x*m+l-4, y*m+l-2, z*m-l+1, x^2+y^2+z^2-1, x+y-z ] );

I := IntersectWithSubalgebra( L, [ x, y, z ] );

J := LeftSubmodule( "x+y-z, -2*z-3*y+x, x^2+y^2+z^2-1", HomalgRing( I ) );

Assert( 0, I = J );
