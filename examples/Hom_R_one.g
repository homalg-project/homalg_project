LoadPackage( "RingsForHomalg" );

Qt := HomalgFieldOfRationalsInDefaultCAS( ) * "t";
A1 := RingOfDerivations( Qt, "D" );

M := HomalgMatrix( "\
[\
D,0,t,0,\
0,D-t,D*t,0\
]\
", 2, 4, A1 );
M := HomalgMap( Involution ( M ), "r" );
C := Cokernel( M );
hC := Hom( C, A1 );
