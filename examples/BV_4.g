LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

Zxy := HomalgRingOfIntegersInDefaultCAS( ) * "x,y";

ZV4 := Zxy / [ "x^2 - 1", "y^2 - 1" ];

zz := HomalgMatrix( "[ x - 1, y - 1 ]", 2, 1, ZV4 );
ZZ := LeftPresentation( zz );

ext := Ext( 10, ZZ, ZZ, "a" );

ByASmallerPresentation( ext );

zt := HomalgMatrix( "[ x + 1, y - 1 ]", 2, 1, ZV4 );
ZT := LeftPresentation( zt );

extt := Ext( 10, ZZ, ZT, "a" );

ByASmallerPresentation( extt );

zc := HomalgMatrix( "[ \
x, -1, \
-1, x, \
y, 1, \
1, y \
]", 4, 2, ZV4 );
ZC := LeftPresentation( zc );

extc := Ext( 6, ZZ, ZC, "a" );

ByASmallerPresentation( extc );

z2 := HomalgMatrix( "[ 2, x - 1, y - 1 ]", 3, 1, ZV4 );
Z2 := LeftPresentation( z2 );

ext2 := Ext( 10, ZZ, Z2, "a" );

ByASmallerPresentation( ext2 );

z3 := HomalgMatrix( "[ 3, x - 1, y - 1 ]", 3, 1, ZV4 );
Z3 := LeftPresentation( z3 );

ext3 := Ext( 10, ZZ, Z3, "a" );

ByASmallerPresentation( ext3 );

z3t := HomalgMatrix( "[ 3, x + 1, y + 1 ]", 3, 1, ZV4 );
Z3T := LeftPresentation( z3t );

ext3t := Ext( 10, ZZ, Z3T, "a" );

ByASmallerPresentation( ext3t );

