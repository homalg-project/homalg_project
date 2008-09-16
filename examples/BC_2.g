LoadPackage( "RingsForHomalg" );

Zx := HomalgRingOfIntegersInDefaultCAS( ) * "x";

rel := HomalgMatrix( "[ x^2 - 1 ]", 1, 1, Zx );
rel := HomalgRelationsForLeftModule( rel );

ZC2 := Zx / rel;

zz := HomalgMatrix( "[ x - 1 ]", 1, 1, ZC2 );

ZZ := LeftPresentation( zz );

ext := rec( );

ext.0 := Ext( 0, ZZ, ZZ );
ext.1 := Ext( 1, ZZ, ZZ );
ext.2 := Ext( 2, ZZ, ZZ );
ext.3 := Ext( 3, ZZ, ZZ );
ext.4 := Ext( 4, ZZ, ZZ );
ext.5 := Ext( 5, ZZ, ZZ );
ext.6 := Ext( 6, ZZ, ZZ );

z2 := HomalgMatrix( "[ 2, x - 1 ]", 2, 1, ZC2 );
Z2 := LeftPresentation( z2 );

ext2 := rec( );

ext2.0 := Ext( 0, ZZ, Z2 );
ext2.1 := Ext( 1, ZZ, Z2 );
ext2.2 := Ext( 2, ZZ, Z2 );
ext2.3 := Ext( 3, ZZ, Z2 );
ext2.4 := Ext( 4, ZZ, Z2 );
ext2.5 := Ext( 5, ZZ, Z2 );
ext2.6 := Ext( 6, ZZ, Z2 );


