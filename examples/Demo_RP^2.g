LoadPackage( "RingsForHomalg" );
LoadPackage( "alexander" );

R := HomalgRingOfIntegersInDefaultCAS( );

RP2 := [[1, 2, 3], [1, 3, 6], [2, 5, 6], [1, 2, 5], [1, 4, 6], [2, 4, 6], [3, 5, 6], [1, 4, 5], [2, 3, 4], [3, 4, 5]];

RP2 := SimplicialComplex( RP2 );

d := SimplicialData( RP2, R );

Z2 := LeftPresentation( [ 2 ], R );

