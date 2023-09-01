LoadPackage( "Modules" );

zz := HomalgRingOfIntegers( );

I := RightSubmodule( "4", zz ); ## or I := RightSubmodule( HomalgMatrix( "[ 4 ]", 1, 1, zz ) );
J := RightSubmodule( "6", zz ); ## or J := RightSubmodule( HomalgMatrix( "[ 6 ]", 1, 1, zz ) );

IpJ := I + J;

IJ := I * J;

IiJ := Intersect( I, J );
