LoadPackage( "RingsForHomalg" );

Q := HomalgFieldOfRationalsInSingular( );
R := Q * "t";
W := RingOfDerivations( R, "D" );

M := HomalgMatrix( "[ D,0,t,0, 0,D-t,D*t,0 ]", 2, 4, W );
M := HomalgMorphism( M );
C := Cokernel( M );
hC := Hom( C, W );
