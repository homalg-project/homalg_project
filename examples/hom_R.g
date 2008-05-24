LoadPackage( "RingsForHomalg" );

A1 := RingForHomalgInMapleUsingJanetOre( "[[D,t],[],[weyl(D,t)]]" );

M := HomalgMatrix( " \
[[D,0,t,0],[0,D-t,D*t,0]] \
", A1 );
M := HomalgMorphism( Involution ( M ), "r" );
C := Cokernel( M );
hC := Hom( C, A1 );
