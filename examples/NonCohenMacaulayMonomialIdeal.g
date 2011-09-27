LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z" );

LoadPackage( "GradedModules" );

I := GradedLeftSubmodule( "x", S ) * MaximalGradedLeftIdeal( S ) + GradedLeftSubmodule( "y^3", S );

M := FactorObject( I );

s := VariableForHilbertPoincareSeries( );
t := VariableForHilbertPolynomial( );

Assert( 0, ProjectiveDimension( I ) = 2 );
Assert( 0, CastelnuovoMumfordRegularity( I ) = 3 );
Assert( 0, HilbertPoincareSeries( M ) = (2*s+1)/(-s+1) );
Assert( 0, HilbertPolynomial( M ) = 3 * t^0 );
Assert( 0, AffineDimension( M ) = 1 );
Assert( 0, List( [ -2 .. 5 ], HilbertFunction( M ) ) = [ 0, 0, 1, 3, 3, 3, 3, 3 ] );
Assert( 0, DataOfHilbertFunction( M ) = [ [ [ 1 ], [ 0 ] ], 3 * t^0 ] );
Assert( 0, IndexOfRegularity( M ) = 1 );
Assert( 0, CastelnuovoMumfordRegularity( M ) = 2 );
Assert( 0, not IsCohenMacaulay( M ) );
