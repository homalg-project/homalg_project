LoadPackage( "RingsForHomalg" );

Qt := HomalgFieldOfRationalsInDefaultCAS( ) * "t";
W := RingOfDerivations( Qt, "D" );

M := HomalgMap( " [\
[D,0,  t,  0], \
[0,D-t,t*D,0] \
]", W );
C := Cokernel( M );
hC := Hom( C, W );

A := HomalgMatrix( "[ \
D^2, t*D-t^2, 1+t*D+t^2*D,0 \
] ", 1, 4, W );
