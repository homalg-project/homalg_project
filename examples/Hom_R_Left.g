LoadPackage( "RingsForHomalg" );

Qt := HomalgFieldOfRationalsInDefaultCAS( ) * "t";
W := RingOfDerivations( Qt, "D" );

M := HomalgMatrix( "[ \
D,   0,   t, 0, \
0, D-t, t*D, 0  \
]", 2, 4, W );

M := HomalgMap( M );

C := Cokernel( M );
hC := Hom( C, W );
