LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

Zx := HomalgRingOfIntegersInDefaultCAS( ) * "x";

ZC4 := Zx / "x^4 - 1";

zz := HomalgMatrix( "[ x - 1 ]", 1, 1, ZC4 );
zz := LeftPresentation( zz );

ext := Ext( 6, zz, zz, "a" );

ByASmallerPresentation( ext );

zt := HomalgMatrix( "[ x^2 + 1 ]", 1, 1, ZC4 );
ZT := LeftPresentation( zt );

extt := Ext( 6, zz, ZT, "a" );

ByASmallerPresentation( extt );

