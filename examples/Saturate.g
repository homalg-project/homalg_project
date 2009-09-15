LoadPackage( "homalg" );

R := HomalgRingOfIntegers( );

m := LeftSubmodule( "2", R );

J := Intersect( m^3, LeftSubmodule( "3", R ) );

J_m := J - m;

Js := Saturate( J, m );

