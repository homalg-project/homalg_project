LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,w";

empty := HomalgZeroMatrix( 0, 0, R );
one := HomalgMatrix( "[ 1, 0, 0, 1, 0, 0 ]", 3, 2, R );
zero := HomalgZeroMatrix( 0, 3, R );
max := HomalgMatrix( "[ x, y, z, w ]", 4, 1, R );
mat := HomalgMatrix( "[ y^2-x*z,x*y-z*w,x^2-y*w ]", 3, 1, R );
mix := HomalgMatrix( "[ x, 0, 0, y, 0, 0 ]", 2, 3, R );

LoadPackage( "Modules" );

s := HOMALG_MODULES.variable_for_Hilbert_polynomial;

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( empty ) = [ ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( empty ) = [ ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( empty ) = 0 * s );
Assert( 0, NumeratorOfHilbertPoincareSeries( empty ) = 0 * s );
Assert( 0, HilbertPoincareSeries( empty ) = 0 * s );
Assert( 0, HilbertPolynomial( empty ) = 0 * s );
Assert( 0, AffineDimension( empty ) = -1 );
Assert( 0, AffineDegree( empty ) = 0 );
Assert( 0, ProjectiveDegree( empty ) = 0 );
Assert( 0, ConstantTermOfHilbertPolynomial( empty ) = 0 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( one ) = [ ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( one ) = [ ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( one ) = 0 * s );
Assert( 0, NumeratorOfHilbertPoincareSeries( one ) = 0 * s );
Assert( 0, HilbertPoincareSeries( one ) = 0 * s );
Assert( 0, HilbertPolynomial( one ) = 0 * s );
Assert( 0, AffineDimension( one ) = -1 );
Assert( 0, AffineDegree( one ) = 0 );
Assert( 0, ProjectiveDegree( one ) = 0 );
Assert( 0, ConstantTermOfHilbertPolynomial( one ) = 0 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( zero ) = [ 3 ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( zero ) = [ 3 ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( zero ) = 3 * s^0 );
Assert( 0, NumeratorOfHilbertPoincareSeries( zero ) = 3 * s^0 );
Assert( 0, HilbertPoincareSeries( zero ) = (3)/(s^4-4*s^3+6*s^2-4*s+1) );
Assert( 0, HilbertPolynomial( zero ) = 1/2*s^3+3*s^2+11/2*s+3 );
Assert( 0, AffineDimension( zero ) = 4 );
Assert( 0, AffineDegree( zero ) = 3 );
Assert( 0, ProjectiveDegree( zero ) = 3 );
Assert( 0, ConstantTermOfHilbertPolynomial( zero ) = 3 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( max ) = [ 1, -4, 6, -4, 1 ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( max ) = [ 1 ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( max ) = s^4-4*s^3+6*s^2-4*s+1 );
Assert( 0, NumeratorOfHilbertPoincareSeries( max ) = s^0 );
Assert( 0, HilbertPoincareSeries( max ) = s^0 );
Assert( 0, HilbertPolynomial( max ) = 0 * s );
Assert( 0, AffineDimension( max ) = 0 );
Assert( 0, AffineDegree( max ) = 1 );
Assert( 0, ProjectiveDegree( max ) = 0 );
Assert( 0, ConstantTermOfHilbertPolynomial( max ) = 0 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( mat ) = [ 1, 0, -3, 2 ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( mat ) = [ 1, 2 ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( mat ) = 2*s^3-3*s^2+1 );
Assert( 0, NumeratorOfHilbertPoincareSeries( mat ) = 2*s+1 );
Assert( 0, HilbertPoincareSeries( mat ) = (2*s+1)/(s^2-2*s+1) );
Assert( 0, HilbertPolynomial( mat ) = 3*s+1 );
Assert( 0, AffineDimension( mat ) = 2 );
Assert( 0, AffineDegree( mat ) = 3 );
Assert( 0, ProjectiveDegree( mat ) = 3 );
Assert( 0, ConstantTermOfHilbertPolynomial( mat ) = 1 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( mix ) = [ 3, -2, 1 ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( mix ) = [ 3, -2, 1 ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( mix ) = s^2-2*s+3 );
Assert( 0, NumeratorOfHilbertPoincareSeries( mix ) = s^2-2*s+3 );
Assert( 0, HilbertPoincareSeries( mix ) = (s^2-2*s+3)/(s^4-4*s^3+6*s^2-4*s+1) );
Assert( 0, HilbertPolynomial( mix ) = 1/3*s^3+2*s^2+14/3*s+3 );
Assert( 0, AffineDimension( mix ) = 4 );
Assert( 0, AffineDegree( mix ) = 2 );
Assert( 0, ProjectiveDegree( mix ) = 2 );
Assert( 0, ConstantTermOfHilbertPolynomial( mix ) = 3 );
