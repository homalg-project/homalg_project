LoadPackage( "RingsForHomalg" );
LoadPackage( "alexander" );

R := HomalgRingOfIntegersInDefaultCAS( );

Torus := [[1,2,5],[1,4,5],[2,3,6],[2,5,6],[1,3,4],[3,4,6],[4,7,8],[4,5,8],[5,8,9],[5,6,9],[6,7,9],[4,6,7],[1,2,7],[2,7,8],[2,3,8],[3,8,9],[1,3,9],[1,7,9]];

Torus := SimplicialComplex( Torus );

d := SimplicialData( Torus, R );

HZ_Torus := Homology( d );
ByASmallerPresentation( HZ_Torus );
#Display( HZ_Torus );

cyc := SimplicialCycle( HZ_Torus, Torus, 1, 1 );

dd := Hom( d, R );
CZ_Torus := Cohomology( dd );
ByASmallerPresentation( CZ_Torus );
#Display( CZ_Torus );

Z2 := LeftPresentation( [ 2 ], R );

d2 := d * Z2;
HZ2_Torus := Homology( d2 );
ByASmallerPresentation( HZ2_Torus );
#Display( HZ2_Torus );

dd2 := Hom( d, Z2 );
CZ2_Torus := Cohomology( dd2 );
ByASmallerPresentation( CZ2_Torus );
#Display( CZ2_Torus );

#Print( _UCT_Homology, "\n" );
#Print( _UCT_Cohomology, "\n" );

