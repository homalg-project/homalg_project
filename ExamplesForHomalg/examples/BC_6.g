LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

Zx := HomalgRingOfIntegersInDefaultCAS( ) * "x";

ZC6 := Zx / "x^6 - 1";

zz := HomalgMatrix( "[ x - 1 ]", 1, 1, ZC6 );
zz := LeftPresentation( zz );

ext := Ext( 6, zz, zz, "a" );

ByASmallerPresentation( ext );

zt := HomalgMatrix( "[ x^2 - x + 1 ]", 1, 1, ZC6 );
ZT := LeftPresentation( zt );

extt := Ext( 6, zz, ZT, "a" );

ByASmallerPresentation( extt );

