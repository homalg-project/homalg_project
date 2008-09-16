LoadPackage( "RingsForHomalg" );

ZX := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,a,X,Y,A";

rel := HomalgMatrix( "[ x*X-1, y*Y-1, a*A-1 ]", 3, 1, ZX );
rel := HomalgRelationsForLeftModule( rel );

ZZ3 := ZX / rel;

zz := HomalgMatrix( "[ x - 1, y - 1, a - 1 ]", 3, 1, ZZ3 );

ZZ := LeftPresentation( zz );

ext := Ext( 5, ZZ, ZZ, "a" );

ByASmallerPresentation( ext );
