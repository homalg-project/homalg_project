LoadPackage( "RingsForHomalg" );

Zx := HomalgRingOfIntegersInDefaultCAS( ) * "x";

ZC2 := Zx / "x^2 - 1";

zz := HomalgMatrix( "[ x - 1 ]", 1, 1, ZC2 );
ZZ := LeftPresentation( zz );

ext := Ext( 6, ZZ, ZZ, "a" );

ByASmallerPresentation( ext );

zt := HomalgMatrix( "[ x + 1 ]", 1, 1, ZC2 );
ZT := LeftPresentation( zt );

extt := Ext( 6, ZZ, ZT, "a" );

ByASmallerPresentation( extt );

zc := HomalgMatrix( "[ \
x, -1, \
-1, x \
]", 2, 2, ZC2 );
ZC := LeftPresentation( zc );

extc := Ext( 6, ZZ, ZC, "a" );

ByASmallerPresentation( extc );

z2 := HomalgMatrix( "[ 2, x - 1 ]", 2, 1, ZC2 );
Z2 := LeftPresentation( z2 );

ext2 := Ext( 6, ZZ, Z2, "a" );

ByASmallerPresentation( ext2 );

z3 := HomalgMatrix( "[ 3, x + 1 ]", 2, 1, ZC2 );
Z3 := LeftPresentation( z3 );

ext3 := Ext( 6, ZZ, Z3, "a" );

ByASmallerPresentation( ext3 );

z4 := HomalgMatrix( "[ 4, x - 1 ]", 2, 1, ZC2 );
Z4 := LeftPresentation( z4 );

ext4 := Ext( 6, ZZ, Z4, "a" );

ByASmallerPresentation( ext4 );

z4t := HomalgMatrix( "[ 4, x + 1 ]", 2, 1, ZC2 );
Z4T := LeftPresentation( z4t );

ext4t := Ext( 6, ZZ, Z4T, "a" );

ByASmallerPresentation( ext4t );

zv4 := HomalgMatrix( "[ \
2, 0, \
0, 2, \
x, -1, \
-1, x  \
]", 4, 2, ZC2 );
ZV4 := LeftPresentation( zv4 );

extv4 := Ext( 6, ZZ, ZV4, "a" );

ByASmallerPresentation( extv4 );

