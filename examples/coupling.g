# sys:=Ind2Diff([u[x,x]-u[x,y],u[x,y,y],u[x,y,z]],[x,y,z],[u]);

LoadPackage( "RingsForHomalg" );

A3 := RingForHomalgInMapleUsingJanetOre( "[[Dx,Dy,Dz,x,y,z],[],[weyl(Dx,x),weyl(Dy,y),weyl(Dz,z)]]" );

M1 := HomalgMatrix( " \
[[ Dx ]] \
", A3 );
M2 := HomalgMatrix( " \
[[ Dx ], [ Dy ]] \
", A3 );
M3 := HomalgMatrix( " \
[[ Dx ], [ Dy ], [ Dz ]] \
", A3 );
M := DiagMat( [ M1, M2, M3 ] );
M := HomalgMatrix( M, A3 );	## copy M before setting entries
SetEntryOfHomalgMatrix( M, 1, 2, "1" );
SetEntryOfHomalgMatrix( M, 2, 3, "1" );
SetEntryOfHomalgMatrix( M, 3, 3, "1" );
M := HomalgMap( M );
M := Cokernel( M );
id := HomalgIdentityMap( M );

hM := Hom( M, A3 );

