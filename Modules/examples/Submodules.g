LoadPackage( "Modules" );

ZZ := HomalgRingOfIntegers( );

I := RightSubmodule( "4", ZZ );

J := Subobject( HomalgMatrix( "[ 6 ]", 1, 1, ZZ ), UnderlyingObject( I ) );

