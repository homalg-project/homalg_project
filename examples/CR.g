LoadPackage( "RingsForHomalg" );

D := RingForHomalgInMapleUsingJanetOre( "[[Dx,Dy,x,y],[],[weyl(Dx,x),weyl(Dy,y)]]" );

A := HomalgMorphism( " \
[ \
[ Dx, -Dy ], \
[ Dy,  Dx ] \
] \
", D );
CR := Cokernel( A );
u_harm := HomalgMatrix( "[[ Dx^2+Dy^2, 0 ]]", D );
v_harm := HomalgMatrix( "[[ 0, Dx^2+Dy^2 ]]", D );
expr0 := HomalgMatrix( "[[ Dx^3+Dy, Dx+Dy^3 ]]", D );
expr := HomalgMatrix( "[[ Dx^3+Dy^2, Dx^2+Dy^3 ]]", D );
