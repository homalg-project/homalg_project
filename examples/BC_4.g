LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

Zx := HomalgRingOfIntegersInDefaultCAS( ) * "x";

ZC4 := Zx / "x^4 - 1";

zz := HomalgMatrix( "[ x - 1 ]", 1, 1, ZC4 );
ZZ := LeftPresentation( zz );

ext := Ext( 6, ZZ, ZZ, "a" );

ByASmallerPresentation( ext );

zt := HomalgMatrix( "[ x^2 + 1 ]", 1, 1, ZC4 );
ZT := LeftPresentation( zt );

extt := Ext( 6, ZZ, ZT, "a" );

ByASmallerPresentation( extt );

