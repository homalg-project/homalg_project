LoadPackage( "Modules" );

t := VariableForHilbertPolynomial( );

chi := 1/12*t^4+2/3*t^3-1/12*t^2-17/3*t-5;

P := CreateElementOfGrothendieckGroupOfProjectiveSpace( chi, 4 );

Assert( 0, AmbientDimension( P ) = 4 );
Assert( 0, Dimension( P ) = 4 );
Assert( 0, Degree( P ) = 2 );

c := ChernPolynomial( P );
ch := ChernCharacter( c );
Assert( 0, HilbertPolynomial( ch ) = chi );
