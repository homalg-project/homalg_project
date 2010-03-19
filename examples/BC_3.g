LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

Zx := HomalgRingOfIntegersInDefaultCAS( ) * "x";

ZC3 := Zx / "x^3 - 1";

zz := HomalgMatrix( "[ x - 1 ]", 1, 1, ZC3 );
ZZ := LeftPresentation( zz );

ext := Ext( 6, ZZ, ZZ, "a" );

ByASmallerPresentation( ext );

zt := HomalgMatrix( "[ x^2 + x + 1 ]", 1, 1, ZC3 );
ZT := LeftPresentation( zt );

extt := Ext( 6, ZZ, ZT, "a" );

ByASmallerPresentation( extt );

