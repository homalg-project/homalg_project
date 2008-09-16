LoadPackage( "RingsForHomalg" );

Zx := HomalgRingOfIntegersInDefaultCAS( ) * "x";

rel := HomalgMatrix( "[ x^2 - 1 ]", 1, 1, Zx );
rel := HomalgRelationsForLeftModule( rel );

ZC2 := Zx / rel;

zz := HomalgMatrix( "[ x - 1 ]", 1, 1, ZC2 );
ZZ := LeftPresentation( zz );

ext := Ext( 6, ZZ, ZZ, "a" );

ByASmallerPresentation( ext );

zt := HomalgMatrix( "[ x + 1 ]", 1, 1, ZC2 );
ZT := LeftPresentation( zt );

extt := Ext( 6, ZZ, ZT, "a" );

ByASmallerPresentation( extt );

z2 := HomalgMatrix( "[ 2, x - 1 ]", 2, 1, ZC2 );
Z2 := LeftPresentation( z2 );

ext2 := Ext( 6, ZZ, Z2, "a" );

ByASmallerPresentation( ext2 );

