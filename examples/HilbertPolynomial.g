LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,w";

LoadPackage( "Modules" );

s := VariableForHilbertPoincareSeries( );
t := VariableForHilbertPolynomial( );

D := LeftPresentation( HomalgZeroMatrix( 0, 0, R ) );
T := LeftPresentation( HomalgMatrix( "[ 1, 0, 0, 1, 0, 0 ]", 3, 2, R ) );
F := LeftPresentation( HomalgZeroMatrix( 0, 3, R ) );
k := LeftPresentation( HomalgMatrix( "[ x, y, z, w ]", 4, 1, R ) );
M := LeftPresentation( HomalgMatrix( "[ y^2-x*z,x*y-z*w,x^2-y*w ]", 3, 1, R ) );
N := LeftPresentation( HomalgMatrix( "[ x, 0, 0, y, 0, 0 ]", 2, 3, R ) );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( D ) = [ ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( D ) = [ ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( D ) = 0 * s );
Assert( 0, NumeratorOfHilbertPoincareSeries( D ) = 0 * s );
Assert( 0, HilbertPoincareSeries( D ) = 0 * s );
Assert( 0, HilbertPolynomial( D ) = 0 * t );
Assert( 0, AffineDimension( D ) = -1 );
Assert( 0, AffineDegree( D ) = 0 );
Assert( 0, ProjectiveDegree( D ) = 0 );
Assert( 0, ConstantTermOfHilbertPolynomial( D ) = 0 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( T ) = [ ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( T ) = [ ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( T ) = 0 * s );
Assert( 0, NumeratorOfHilbertPoincareSeries( T ) = 0 * s );
Assert( 0, HilbertPoincareSeries( T ) = 0 * s );
Assert( 0, HilbertPolynomial( T ) = 0 * t );
Assert( 0, AffineDimension( T ) = -1 );
Assert( 0, AffineDegree( T ) = 0 );
Assert( 0, ProjectiveDegree( T ) = 0 );
Assert( 0, ConstantTermOfHilbertPolynomial( T ) = 0 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( F ) = [ 3 ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( F ) = [ 3 ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( F ) = 3 * s^0 );
Assert( 0, NumeratorOfHilbertPoincareSeries( F ) = 3 * s^0 );
Assert( 0, HilbertPoincareSeries( F ) = (3)/(s^4-4*s^3+6*s^2-4*s+1) );
Assert( 0, HilbertPolynomial( F ) = 1/2*t^3+3*t^2+11/2*t+3 );
Assert( 0, AffineDimension( F ) = 4 );
Assert( 0, AffineDegree( F ) = 3 );
Assert( 0, ProjectiveDegree( F ) = 3 );
Assert( 0, ConstantTermOfHilbertPolynomial( F ) = 3 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( k ) = [ 1, -4, 6, -4, 1 ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( k ) = [ 1 ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( k ) = s^4-4*s^3+6*s^2-4*s+1 );
Assert( 0, NumeratorOfHilbertPoincareSeries( k ) = s^0 );
Assert( 0, HilbertPoincareSeries( k ) = s^0 );
Assert( 0, HilbertPolynomial( k ) = 0 * t );
Assert( 0, AffineDimension( k ) = 0 );
Assert( 0, AffineDegree( k ) = 1 );
Assert( 0, ProjectiveDegree( k ) = 0 );
Assert( 0, ConstantTermOfHilbertPolynomial( k ) = 0 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( M ) = [ 1, 0, -3, 2 ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( M ) = [ 1, 2 ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( M ) = 2*s^3-3*s^2+1 );
Assert( 0, NumeratorOfHilbertPoincareSeries( M ) = 2*s+1 );
Assert( 0, HilbertPoincareSeries( M ) = (2*s+1)/(s^2-2*s+1) );
Assert( 0, HilbertPolynomial( M ) = 3*t+1 );
Assert( 0, AffineDimension( M ) = 2 );
Assert( 0, AffineDegree( M ) = 3 );
Assert( 0, ProjectiveDegree( M ) = 3 );
Assert( 0, ConstantTermOfHilbertPolynomial( M ) = 1 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( N ) = [ 3, -2, 1 ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( N ) = [ 3, -2, 1 ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( N ) = s^2-2*s+3 );
Assert( 0, NumeratorOfHilbertPoincareSeries( N ) = s^2-2*s+3 );
Assert( 0, HilbertPoincareSeries( N ) = (s^2-2*s+3)/(s^4-4*s^3+6*s^2-4*s+1) );
Assert( 0, HilbertPolynomial( N ) = 1/3*t^3+2*t^2+14/3*t+3 );
Assert( 0, AffineDimension( N ) = 4 );
Assert( 0, AffineDegree( N ) = 2 );
Assert( 0, ProjectiveDegree( N ) = 2 );
Assert( 0, ConstantTermOfHilbertPolynomial( N ) = 3 );
