LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x,y" );
A := KoszulDualRing( S, "e,f" );

s := HomalgMatrix( "[ x*y, 1, x, 0 ]", 2, 2, S );
a := HomalgMatrix( "[ e*f, 1, e, 0 ]", 2, 2, A );

Assert( 0, DegreesOfEntries( s ) = [ [ 2, 0 ], [ 1, -1 ] ] );
Assert( 0, NonTrivialDegreePerRow( s ) = [ 2, 1 ] );
Assert( 0, NonTrivialDegreePerColumn( s ) = [ 2, 0 ] );

Assert( 0, DegreesOfEntries( a ) = [ [ -2, 0 ], [ -1, 1 ] ] );
Assert( 0, NonTrivialDegreePerRow( a ) = [ -2, -1 ] );
Assert( 0, NonTrivialDegreePerColumn( a ) = [ -2, 0 ] );
