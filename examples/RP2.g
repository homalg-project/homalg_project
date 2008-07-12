LoadPackage( "homalg" );

ZZ := HomalgRingOfIntegers( );

b1 := HomalgMap( [[-1, 1, 0, 0, 0, 0], [-1, 0, 1, 0, 0, 0], [-1, 0, 0, 1, 0, 0], [-1, 0, 0, 0, 1, 0], [-1, 0, 0, 0, 0, 1], [0, -1, 1, 0, 0, 0], [0, -1, 0, 1, 0, 0], [0, -1, 0, 0, 1, 0], [0, -1, 0, 0, 0, 1], [0, 0, -1, 1, 0, 0], [0, 0, -1, 0, 1, 0], [0, 0, -1, 0, 0, 1], [0, 0, 0, -1, 1, 0], [0, 0, 0, -1, 0, 1], [0, 0, 0, 0, -1, 1]], ZZ );

b2 := HomalgMatrix( [[1, -1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0], [0, 1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], [0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0], [0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 0, 1, -1, 0, 0, 1, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 1], [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 1, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 1]], ZZ );

d := HomalgComplex( b1 );
Add( d, b2 );

UCT_Homology := function( H, G )
  return ByASmallerPresentation( H * G + Tor( 1, Shift( H, -1 ), G ) );
end;

UCT_Cohomology := function( H, G )
  return ByASmallerPresentation( Hom( H, G ) + Ext( 1, Shift( H, -1 ), G ) );
end;

#HZ_RP2 := Homology( d );
#ByASmallerPresentation( HZ_RP2 );
#Display( HZ_RP2 );

#dd := Hom( d, ZZ );
#CZ_RP2 := Cohomology( dd );
#ByASmallerPresentation( CZ_RP2 );
#Display( CZ_RP2 );

Z2 := LeftPresentation( [ 2 ], ZZ );

#d2 := d * Z2;
#HZ2_RP2 := Homology( d2 );
#ByASmallerPresentation( HZ2_RP2 );
#Display( HZ2_RP2 );

#dd2 := Hom( d, Z2 );
#CZ2_RP2 := Cohomology( dd2 );
#ByASmallerPresentation( CZ2_RP2 );
#Display( CZ2_RP2 );
