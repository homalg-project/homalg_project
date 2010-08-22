LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

R := HomalgRingOfIntegersInDefaultCAS( );
M := 1 * R;
N := LeftPresentation( [ 3 ], R );
a := HomalgMap( [ 2 ], M, M );
c := HomalgMap( [ 2 ], M, N );
b := HomalgMap( [ 1 ], M, M );
d := HomalgMap( [ 1 ], M, N );
C1 := HomalgComplex( a );
C2 := HomalgComplex( c );
cm := HomalgChainMap( d, C1, C2 );
Add( cm, b );
## induces the zero map on homology, but
## is not zero in the derived category D(A)
hcm := DefectOfExactness( cm );
ByASmallerPresentation( hcm );
IsZero( hcm );
IsZero( Source( hcm ) );
IsZero( Range( hcm ) );
