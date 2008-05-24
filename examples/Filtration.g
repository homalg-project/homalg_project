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

tau1 := HomalgMatrix( " \
[[1,Dx,Dz],[0,0,1],[0,1,Dy]] \
", A3 );

tau2 := HomalgMatrix( " \
[[0,1,Dz+x*y],[0,0,1],[1,Dz,x-y]] \
", A3 );

tau3 := HomalgMatrix( " \
[[1,0,0],[1,1,0],[0,-1,1]] \
", A3 );

tau := tau1 * tau2 * tau3;

N := LeftPresentation( M * tau );

M := LeftPresentation( M );

tau := HomalgMorphism( tau, M, N );

OnLessGenerators( N );

BasisOfModule( N );

OnLessGenerators( N );

BasisOfModule( N );

OnLessGenerators( N );

BasisOfModule( N );

DecideZero( tau );

id := HomalgIdentityMorphism( M );

#hM := Hom( M, A3 );
