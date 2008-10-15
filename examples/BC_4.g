LoadPackage( "RingsForHomalg" );

Zx := HomalgRingOfIntegersInDefaultCAS( ) * "x";

rel := HomalgMatrix( "[ x^4 - 1 ]", 1, 1, Zx );
rel := HomalgRelationsForLeftModule( rel );

ZC4 := Zx / rel;

zz := HomalgMatrix( "[ x - 1 ]", 1, 1, ZC4 );
ZZ := LeftPresentation( zz );

ext := Ext( 6, ZZ, ZZ, "a" );

ByASmallerPresentation( ext );

zt := HomalgMatrix( "[ x^2 + 1 ]", 1, 1, ZC4 );
ZT := LeftPresentation( zt );

extt := Ext( 6, ZZ, ZT, "a" );

ByASmallerPresentation( extt );

