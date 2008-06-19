LoadPackage( "RingsForHomalg" );

Qt := HomalgFieldOfRationalsInDefaultCAS( ) * "t";
W := RingOfDerivations( Qt, "D" );

M := HomalgMatrix( "\
[\
D,0,  t,  0,\
0,D-t,t*D,0\
]", 2, 4, W );

M := HomalgMap( M, W );

C := Cokernel( M );
hC := Hom( C, W );

A := HomalgMatrix( "[\
D^2, t*D-t^2, 1+t*D+t^2*D,0\
] ", 1, 4, W );
