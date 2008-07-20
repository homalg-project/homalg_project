#LoadPackage( "RingsForHomalg" );
LoadPackage( "alexander" );

R := HomalgRingOfIntegers( );

RP2 := [[1, 2, 3], [1, 3, 6], [2, 5, 6], [1, 2, 5], [1, 4, 6], [2, 4, 6], [3, 5, 6], [1, 4, 5], [2, 3, 4], [3, 4, 5]];

RP2 := SimplicialComplex( RP2 );

d := SimplicialData( RP2, R );

HZ_RP2 := Homology( d );
ByASmallerPresentation( HZ_RP2 );
#Display( HZ_RP2 );

S1 := SimplicialCycle( HZ_RP2, RP2, 1, 1 );

dd := Hom( d, R );
CZ_RP2 := Cohomology( dd );
ByASmallerPresentation( CZ_RP2 );
#Display( CZ_RP2 );

Z2 := LeftPresentation( [ 2 ], R );

d2 := d * Z2;
HZ2_RP2 := Homology( d2 );
ByASmallerPresentation( HZ2_RP2 );
#Display( HZ2_RP2 );

dd2 := Hom( d, Z2 );
CZ2_RP2 := Cohomology( dd2 );
ByASmallerPresentation( CZ2_RP2 );
#Display( CZ2_RP2 );

#Print( _UCT_Homology, "\n" );
#Print( _UCT_Cohomology, "\n" );

