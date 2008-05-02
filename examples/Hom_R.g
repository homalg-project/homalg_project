LoadPackage( "RingsForHomalg" );

A1 := RingForHomalgInMapleUsingJanetOre( "[[D,t],[],[weyl(D,t)]]" );

M := HomalgMorphism( " \
[[D,0,t,0],[0,D-t,D*t,0]] \
", A1 );
M := Cokernel( M );
hM := Hom(M,A1);
