LoadPackage( "Modules" );

zz := HomalgRingOfIntegers( );

I := RightSubmodule( "4", zz );

J := Subobject( HomalgMatrix( "[ 6 ]", 1, 1, zz ), UnderlyingObject( I ) );

