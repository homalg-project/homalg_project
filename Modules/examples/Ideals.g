LoadPackage( "Modules" );

ZZ := HomalgRingOfIntegers( );

I := RightSubmodule( "4", ZZ ); ## or I := RightSubmodule( HomalgMatrix( "[ 4 ]", 1, 1, ZZ ) );
J := RightSubmodule( "6", ZZ ); ## or J := RightSubmodule( HomalgMatrix( "[ 6 ]", 1, 1, ZZ ) );

IpJ := I + J;

IJ := I * J;

IiJ := Intersect( I, J );
