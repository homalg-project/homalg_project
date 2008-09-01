#LoadPackage( "RingsForHomalg" );
LoadPackage( "alexander" );

R := HomalgRingOfIntegers( );

Torus := [[1,2,5],[1,4,5],[2,3,6],[2,5,6],[1,3,4],[3,4,6],[4,7,8],[4,5,8],[5,8,9],[5,6,9],[6,7,9],[4,6,7],[1,2,7],[2,7,8],[2,3,8],[3,8,9],[1,3,9],[1,7,9]];

Torus := SimplicialComplex( Torus );

#cyc := SimplicialCycle( Torus, 1, 1 );
cyc := [[3, 6], [3, 9], [6, 9]];

S1 := SimplicialComplex( cyc, Dimension( Torus ) );

d := SimplicialData( Torus, S1, R );

T := ExactTriangle( d );

lehs := LongSequence( T );

ByASmallerPresentation( lehs );

IsExactSequence( lehs );

dd := Hom( d );

## FIXME: make the following line obsolete
SetIsShortExactSequence( dd, true );

t := ExactTriangle ( dd );

lecs := LongSequence( t );

ByASmallerPresentation( lecs );

IsExactSequence( lecs );
