LoadPackage( "RingsForHomalg" );

Zx := HomalgRingOfIntegersInDefaultCAS( ) * "x";

rel := HomalgMatrix( "[ x^6 - 1 ]", 1, 1, Zx );
rel := HomalgRelationsForLeftModule( rel );

ZC6 := Zx / rel;

zz := HomalgMatrix( "[ x - 1 ]", 1, 1, ZC6 );
ZZ := LeftPresentation( zz );

ext := Ext( 6, ZZ, ZZ, "a" );

ByASmallerPresentation( ext );

zt := HomalgMatrix( "[ x^2 - x + 1 ]", 1, 1, ZC6 );
ZT := LeftPresentation( zt );

extt := Ext( 6, ZZ, ZT, "a" );

ByASmallerPresentation( extt );

