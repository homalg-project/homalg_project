LoadPackage( "homalg" );

ZZ := HomalgRingOfIntegers( );

J := RightSubmodule( "4", ZZ ); ## or J := RightSubmodule( HomalgMatrix( "[ 4 ]", 1, 1, ZZ ) );
K := RightSubmodule( "6", ZZ ); ## or K := RightSubmodule( HomalgMatrix( "[ 6 ]", 1, 1, ZZ ) );

JpK := J + K;

JK := J * K;

JiK := Intersect( J, K );
