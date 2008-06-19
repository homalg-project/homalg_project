LoadPackage( "RingsForHomalg" );

Qxy := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";
D := RingOfDerivations( Qxy, "Dx,Dy" );

A := HomalgMatrix( "[\
Dx, -Dy, \
Dy,  Dx  \
]", 2, 2, D );

A := HomalgMap( A );
CR := Cokernel( A );
u_harm := HomalgMatrix( "[ Dx^2+Dy^2, 0 ]", 1, 2, D );
v_harm := HomalgMatrix( "[ 0, Dx^2+Dy^2 ]", 1, 2, D );
expr0 := HomalgMatrix( "[ Dx^3+Dy, Dx+Dy^3 ]", 1, 2, D );
expr := HomalgMatrix( "[ Dx^3+Dy^2, Dx^2+Dy^3 ]", 1, 2, D );
