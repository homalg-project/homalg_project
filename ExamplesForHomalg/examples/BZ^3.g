LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

ZX := HomalgRingOfIntegersInDefaultCAS( ) * "x,y,a,X,Y,A";

ZZ3 := ZX / [ "x*X-1", "y*Y-1", "a*A-1" ];

zz := HomalgMatrix( "[ x - 1, y - 1, a - 1 ]", 3, 1, zz3 );

zz := LeftPresentation( zz );

ext := Ext( 5, zz, zz, "a" );

ByASmallerPresentation( ext );
