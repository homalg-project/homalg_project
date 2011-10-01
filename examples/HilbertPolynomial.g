LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x,y" );

LoadPackage( "GradedModules" );

s := VariableForHilbertPoincareSeries( );
t := VariableForHilbertPolynomial( );

D := LeftPresentationWithDegrees( HomalgZeroMatrix( 0, 0, S ) );
T := LeftPresentationWithDegrees( HomalgMatrix( "[ 1, 0, 0, 1, 0, 0 ]", 3, 2, S ), [ -2, -2 ] );
F := FreeLeftModuleWithDegrees( [ -2, -2 ], S );
k := LeftPresentationWithDegrees( HomalgMatrix( "[ x, y ]", 2, 1, S ), [ -2 ] );
M := LeftPresentationWithDegrees( HomalgMatrix( "[ x^2 - y^2 ]", 1, 1, S ), [ -2 ] );
N := LeftPresentationWithDegrees( HomalgMatrix( "[ x, 0, 0, y, 0, 0 ]", 2, 3, S ), [ -2, -2, -2 ] );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( D ) = [ [ ], [ ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( D ) = [ [ ], [ ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( D ) = 0 * s );
Assert( 0, NumeratorOfHilbertPoincareSeries( D ) = 0 * s );
Assert( 0, HilbertPoincareSeries( D ) = 0 * s );
Assert( 0, HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution( D ) = 0 * s );
Assert( 0, HilbertPolynomial( D ) = 0 * t );
Assert( 0, AffineDimension( D ) = -1 );
Assert( 0, AffineDegree( D ) = 0 );
Assert( 0, ProjectiveDegree( D ) = 0 );
Assert( 0, ConstantTermOfHilbertPolynomial( D ) = 0 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( T ) = [ [ ], [ ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( T ) = [ [ ], [ ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( T ) = 0 * s );
Assert( 0, NumeratorOfHilbertPoincareSeries( T ) = 0 * s );
Assert( 0, HilbertPoincareSeries( T ) = 0 * s );
Assert( 0, HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution( T ) = 0 * s );
Assert( 0, HilbertPolynomial( T ) = 0 * t );
Assert( 0, AffineDimension( T ) = -1 );
Assert( 0, AffineDegree( T ) = 0 );
Assert( 0, ProjectiveDegree( T ) = 0 );
Assert( 0, ConstantTermOfHilbertPolynomial( T ) = 0 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( F ) = [ [ 2 ], [ -2 ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( F ) = [ [ 2 ], [ -2 ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( F ) = 2*s^(-2) );
Assert( 0, NumeratorOfHilbertPoincareSeries( F ) = 2*s^(-2) );
Assert( 0, HilbertPoincareSeries( F ) = (2)/(s^4-2*s^3+s^2) );
Assert( 0, HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution( F ) = (2)/(s^4-2*s^3+s^2) );
Assert( 0, HilbertPolynomial( F ) = 2*t+6 );
Assert( 0, AffineDimension( F ) = 2 );
Assert( 0, AffineDegree( F ) = 2 );
Assert( 0, ProjectiveDegree( F ) = 2 );
Assert( 0, ConstantTermOfHilbertPolynomial( F ) = 6 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( k ) = [ [ 1, -2, 1 ], [ -2 .. 0 ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( k ) = [ [ 1 ], [ -2 ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( k ) = 1-2*s^(-1)+s^(-2) );
Assert( 0, NumeratorOfHilbertPoincareSeries( k ) = s^(-2) );
Assert( 0, HilbertPoincareSeries( k ) = s^(-2) );
Assert( 0, HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution( k ) = s^(-2) );
Assert( 0, HilbertPolynomial( k ) = 0 * t );
Assert( 0, AffineDimension( k ) = 0 );
Assert( 0, AffineDegree( k ) = 1 );
Assert( 0, ProjectiveDegree( k ) = 0 );
Assert( 0, ConstantTermOfHilbertPolynomial( k ) = 0 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( M ) = [ [ 1, 0, -1 ], [ -2 .. 0 ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( M ) = [ [ 1, 1 ], [ -2, -1 ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( M ) = -1+s^(-2) );
Assert( 0, NumeratorOfHilbertPoincareSeries( M ) = s^(-1)+s^(-2) );
Assert( 0, HilbertPoincareSeries( M ) = (-s-1)/(s^3-s^2) );
Assert( 0, HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution( M ) = (-s-1)/(s^3-s^2) );
Assert( 0, HilbertPolynomial( M ) = 2 * t^0 );
Assert( 0, AffineDimension( M ) = 1 );
Assert( 0, AffineDegree( M ) = 2 );
Assert( 0, ProjectiveDegree( M ) = 2 );
Assert( 0, ConstantTermOfHilbertPolynomial( M ) = 2 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( N ) = [ [ 3, -2, 1 ], [ -2 .. 0 ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( N ) = [ [ 3, -2, 1 ], [ -2 .. 0 ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( N ) = 1-2*s^(-1)+3*s^(-2) );
Assert( 0, NumeratorOfHilbertPoincareSeries( N ) = 1-2*s^(-1)+3*s^(-2) );
Assert( 0, HilbertPoincareSeries( N ) = (s^2-2*s+3)/(s^4-2*s^3+s^2) );
Assert( 0, HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution( N ) = (s^2-2*s+3)/(s^4-2*s^3+s^2) );
Assert( 0, HilbertPolynomial( N ) = 2*t+6 );
Assert( 0, AffineDimension( N ) = 2 );
Assert( 0, AffineDegree( N ) = 2 );
Assert( 0, ProjectiveDegree( N ) = 2 );
Assert( 0, ConstantTermOfHilbertPolynomial( N ) = 6 );

T2 := LeftPresentationWithDegrees( HomalgMatrix( "[ 1, 0, 0, 1, 0, 0 ]", 3, 2, S ), [ -2, 3 ] );
F2 := FreeLeftModuleWithDegrees( [ -2, 3 ], S );
M2 := LeftPresentationWithDegrees( HomalgMatrix( "[ x, 0, 0, y, 0, 0 ]", 2, 3, S ), [ 2, 3, 2 ] );
N2 := LeftPresentationWithDegrees( HomalgMatrix( "[ x, 0, 0, y, 0, 0 ]", 2, 3, S ), [ -2, 3, -2 ] );
L2 := LeftPresentationWithDegrees( HomalgMatrix( "[ x, 0, 0, 0, y, 0 ]", 2, 3, S ), [ -2, 3, -4 ] );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( T2 ) = [ [ ], [ ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( T2 ) = [ [ ], [ ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( T2 ) = 0 * s );
Assert( 0, NumeratorOfHilbertPoincareSeries( T2 ) = 0 * s );
Assert( 0, HilbertPoincareSeries( T2 ) = 0 * s );
Assert( 0, HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution( T2 ) = 0 * s );
Assert( 0, HilbertPolynomial( T2 ) = 0 * t );
Assert( 0, AffineDimension( T2 ) = -1 );
Assert( 0, AffineDegree( T2 ) = 0 );
Assert( 0, ProjectiveDegree( T2 ) = 0 );
Assert( 0, ConstantTermOfHilbertPolynomial( T2 ) = 0 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( F2 ) = [ [ 1, 0, 0, 0, 0, 1 ], [ -2 .. 3 ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( F2 ) = [ [ 1, 0, 0, 0, 0, 1 ], [ -2 .. 3 ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( F2 ) = s^3+s^(-2) );
Assert( 0, NumeratorOfHilbertPoincareSeries( F2 ) = s^3+s^(-2) );
Assert( 0, HilbertPoincareSeries( F2 ) = (s^5+1)/(s^4-2*s^3+s^2) );
Assert( 0, HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution( F2 ) = (s^5+1)/(s^4-2*s^3+s^2) );
Assert( 0, HilbertPolynomial( F2 ) = 2*t+1 );
Assert( 0, AffineDimension( F2 ) = 2 );
Assert( 0, AffineDegree( F2 ) = 2 );
Assert( 0, ProjectiveDegree( F2 ) = 2 );
Assert( 0, ConstantTermOfHilbertPolynomial( F2 ) = 1 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( M2 ) = [ [ 2, -1, 1 ], [ 2 .. 4 ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( M2 ) = [ [ 2, -1, 1 ], [ 2 .. 4 ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( M2 ) = s^4-s^3+2*s^2 );
Assert( 0, NumeratorOfHilbertPoincareSeries( M2 ) = s^4-s^3+2*s^2 );
Assert( 0, HilbertPoincareSeries( M2 ) = (s^4-s^3+2*s^2)/(s^2-2*s+1) );
Assert( 0, HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution( M2 ) = (s^4-s^3+2*s^2)/(s^2-2*s+1) );
Assert( 0, HilbertPolynomial( M2 ) = 2*t-3 );
Assert( 0, AffineDimension( M2 ) = 2 );
Assert( 0, AffineDegree( M2 ) = 2 );
Assert( 0, ProjectiveDegree( M2 ) = 2 );
Assert( 0, ConstantTermOfHilbertPolynomial( M2 ) = -3 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( N2 ) = [ [ 2, -2, 1, 0, 0, 1 ], [ -2 .. 3 ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( N2 ) = [ [ 2, -2, 1, 0, 0, 1 ], [ -2 .. 3 ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( N2 ) = s^3+1-2*s^(-1)+2*s^(-2) );
Assert( 0, NumeratorOfHilbertPoincareSeries( N2 ) = s^3+1-2*s^(-1)+2*s^(-2) );
Assert( 0, HilbertPoincareSeries( N2 ) = (s^5+s^2-2*s+2)/(s^4-2*s^3+s^2) );
Assert( 0, HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution( N2 ) = (s^5+s^2-2*s+2)/(s^4-2*s^3+s^2) );
Assert( 0, HilbertPolynomial( N2 ) = 2*t+1 );
Assert( 0, AffineDimension( N2 ) = 2 );
Assert( 0, AffineDegree( N2 ) = 2 );
Assert( 0, ProjectiveDegree( N2 ) = 2 );
Assert( 0, ConstantTermOfHilbertPolynomial( N2 ) = 1 );

Assert( 0, CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries( L2 ) = [ [ 1, 0, 1, -1, 0, 0, 0, 1, -1 ], [ -4 .. 4 ] ] );
Assert( 0, CoefficientsOfNumeratorOfHilbertPoincareSeries( L2 ) = [ [ 1, 0, 1, -1, 0, 0, 0, 1, -1 ], [ -4 .. 4 ] ] );
Assert( 0, UnreducedNumeratorOfHilbertPoincareSeries( L2 ) = -s^4+s^3-s^(-1)+s^(-2)+s^(-4) );
Assert( 0, NumeratorOfHilbertPoincareSeries( L2 ) = -s^4+s^3-s^(-1)+s^(-2)+s^(-4) );
Assert( 0, HilbertPoincareSeries( L2 ) = (-s^8+s^7-s^3+s^2+1)/(s^6-2*s^5+s^4) );
Assert( 0, HilbertPoincareSeries_ViaBettiDiagramOfMinimalFreeResolution( L2 ) = (-s^8+s^7-s^3+s^2+1)/(s^6-2*s^5+s^4) );
Assert( 0, HilbertPolynomial( L2 ) = t+7 );
Assert( 0, AffineDimension( L2 ) = 2 );
Assert( 0, AffineDegree( L2 ) = 1 );
Assert( 0, ProjectiveDegree( L2 ) = 1 );
Assert( 0, ConstantTermOfHilbertPolynomial( L2 ) = 7 );
