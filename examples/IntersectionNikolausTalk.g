LoadPackage("RingsForHomalg");;
R := HomalgFieldOfRationalsInSingular() * "w,x,y,z";;

LoadPackage("LocalizeRingForHomalg");;
RMora := LocalizePolynomialRingAtZeroWithMora( R );;
R0 := LocalizeAtZero( R );;
R1 := LocalizeAt( R ,[ HomalgRingElement( "w-1" , R ) , HomalgRingElement( "x-1" , R ) , HomalgRingElement( "y" , R ) , HomalgRingElement( "z" , R ) ]);;

M1 := HomalgMatrix( "[\
       (w-x^2)*y, \
       (w-x^2)*z, \
       (x-w^2)*y, \
       (x-w^2)*z  \
     ]", 1, 4, R );;
M2 := HomalgMatrix( "[\
       (w-x^2)-y, \
       (x-w^2)-z  \
     ]", 1, 2, R );;

LoadPackage( "Modules" );
RmodI1 := RightPresentation( M1 );;
RmodI2 := RightPresentation( M2 );;
T:=Tor( RmodI1, RmodI2 );
Assert( 0, List( ObjectsOfComplex( T ), AffineDegree ) = [ 12, 4, 0, 0 ] );
#We read, that the intersection multiplicity is 12-4=8 globally.

M10 := R0 * M1;
M20 := R0 * M2;
R0modI10 := RightPresentation( M10 );;
R0modI20 := RightPresentation( M20 );;
T0 := Tor( R0modI10, R0modI20 );
T0Mora := RMora * T0;
Assert( 0, List( ObjectsOfComplex( T0Mora ), AffineDegree ) = [ 3, 1, 0, 0 ] );
#The intersection multiplicity at zero is 3-1=2.

M11 := R1 * M1;
M21 := R1 * M2;
R1modI11 := RightPresentation( M11 );;
R1modI21 := RightPresentation( M21 );;
T1 := Tor( R1modI11, R1modI21 );
#The intersection multiplicity cannot be read ofwithout affine transformation
