LoadPackage( "RingsForHomalg" );

A1 := RingForHomalgInMapleUsingJanetOre( "[[D,t],[],[weyl(D,t)]]" );

wmat := HomalgMatrix( " \
[[D,0,t,0],[0,D-t,D*t,0]] \
", A1 );
Display( wmat );
r := NumberRows( wmat );
c := NumberColumns( wmat );
kmat := ConvertTransposedMatrixToRow( wmat );
Display( kmat );
hmat := ConvertRowToTransposedMatrix( kmat, r, c );
Display( hmat );
kmat := ConvertTransposedMatrixToColumn( wmat );
Display( kmat );
hmat := ConvertColumnToTransposedMatrix( kmat, r, c );
Display( hmat );
