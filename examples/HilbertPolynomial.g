LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x,y" );

LoadPackage( "GradedModules" );

s := HOMALG_MODULES.variable_for_Hilbert_polynomial;

D := LeftPresentationWithDegrees( HomalgZeroMatrix( 0, 0, S ) );
T := LeftPresentationWithDegrees( HomalgMatrix( "[ 1, 0, 0, 1, 0, 0 ]", 3, 2, S ), [ -2, -2 ] );
F := FreeLeftModuleWithDegrees( [ -2, -2 ], S );
k := LeftPresentationWithDegrees( HomalgMatrix( "[ x, y ]", 2, 1, S ), [ -2 ] );
M := LeftPresentationWithDegrees( HomalgMatrix( "[ x^2 - y^2 ]", 1, 1, S ), [ -2 ] );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( D ) = [ [ ], [ ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( D ) = [ [ ], [ ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( D ) = 0 * s );
Assert( 0, NumeratorOfHilbertPoincareSeries( D ) = 0 * s );
Assert( 0, HilbertPoincareSeries( D ) = 0 * s );
Assert( 0, HilbertPolynomial( D ) = 0 * s );
Assert( 0, AffineDimension( D ) = -1 );
Assert( 0, AffineDegree( D ) = 0 );
Assert( 0, ProjectiveDegree( D ) = 0 );
Assert( 0, ConstantTermOfHilbertPolynomial( D ) = 0 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( T ) = [ [ ], [ ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( T ) = [ [ ], [ ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( T ) = 0 * s );
Assert( 0, NumeratorOfHilbertPoincareSeries( T ) = 0 * s );
Assert( 0, HilbertPoincareSeries( T ) = 0 * s );
Assert( 0, HilbertPolynomial( T ) = 0 * s );
Assert( 0, AffineDimension( T ) = -1 );
Assert( 0, AffineDegree( T ) = 0 );
Assert( 0, ProjectiveDegree( T ) = 0 );
Assert( 0, ConstantTermOfHilbertPolynomial( T ) = 0 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( F ) = [ [ 2 ], [ -2 ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( F ) = [ [ 2 ], [ -2 ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( F ) = 2*s^-2 );
Assert( 0, NumeratorOfHilbertPoincareSeries( F ) = 2*s^-2 );
Assert( 0, HilbertPoincareSeries( F ) = (2)/(s^4-2*s^3+s^2) );
Assert( 0, HilbertPolynomial( F ) = 2*s+6 );
Assert( 0, AffineDimension( F ) = 2 );
Assert( 0, AffineDegree( F ) = 2 );
Assert( 0, ProjectiveDegree( F ) = 2 );
Assert( 0, ConstantTermOfHilbertPolynomial( F ) = 6 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( k ) = [ [ 1, -2, 1 ], [ -2 .. 0 ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( k ) = [ [ 1 ], [ -2 ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( k ) = 1-2*s^(-1)+s^(-2) );
Assert( 0, NumeratorOfHilbertPoincareSeries( k ) = s^(-2) );
Assert( 0, HilbertPoincareSeries( k ) = s^-2 );
Assert( 0, HilbertPolynomial( k ) = 0 * s );
Assert( 0, AffineDimension( k ) = 0 );
Assert( 0, AffineDegree( k ) = 1 );
Assert( 0, ProjectiveDegree( k ) = 0 );
Assert( 0, ConstantTermOfHilbertPolynomial( k ) = 0 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( M ) = [ [ 1, 0, -1 ], [ -2 .. 0 ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( M ) = [ [ 1, 1 ], [ -2, -1 ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( M ) = -1+s^(-2) );
Assert( 0, NumeratorOfHilbertPoincareSeries( M ) = s^(-1)+s^(-2) );
Assert( 0, HilbertPoincareSeries( M ) = (-s-1)/(s^3-s^2) );
Assert( 0, HilbertPolynomial( M ) = 2 * s^0 );
Assert( 0, AffineDimension( M ) = 1 );
Assert( 0, AffineDegree( M ) = 2 );
Assert( 0, ProjectiveDegree( M ) = 2 );
Assert( 0, ConstantTermOfHilbertPolynomial( M ) = 2 );
