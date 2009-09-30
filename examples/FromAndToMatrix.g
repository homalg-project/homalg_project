LoadPackage( "RingsForHomalg" );

A1 := RingForHomalgInMapleUsingJanetOre( "[[D,t],[],[weyl(D,t)]]" );

wmat := HomalgMatrix( " \
[[D,0,t,0],[0,D-t,D*t,0]] \
", A1 );
Display( wmat );
r := NrRows( wmat );
c := NrColumns( wmat );
kmat := ConvertMatrixToRow( wmat );
Display( kmat );
hmat := ConvertRowToMatrix( kmat, r, c );
Display( hmat );
kmat := ConvertMatrixToColumn( wmat );
Display( kmat );
hmat := ConvertColumnToMatrix( kmat, r, c );
Display( hmat );
