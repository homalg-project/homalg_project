LoadPackage( "homalg" );

ZZ := HomalgRingOfIntegers( );

J := RightSubmodule( "4", ZZ );

K := Subobject( HomalgMatrix( "[ 6 ]", 1, 1, ZZ ), UnderlyingObject( J ) );

