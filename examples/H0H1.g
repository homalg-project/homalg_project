LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

ZZ := HomalgRingOfIntegersInDefaultCAS( );

## the line
deltaL := HomalgMap( [[1,-1]], ZZ );
## the 1-sphere
deltaS := HomalgMap( [[0,-1,1],[1,0,-1],[-1,1,0]], ZZ );

## the 0-th homology of L:
H0_L := Cokernel( deltaL );
## the 1-st homology of L:
H1_L := Kernel( deltaL );

ByASmallerPresentation(H0_L);

#Display( H0_L );
#Display( H1_L );

## the 0-th homology of S:
H0_S := Cokernel( deltaS );
## the 1-st homology of S:
H1_S := Kernel( deltaS );

ByASmallerPresentation(H0_S);
ByASmallerPresentation(H1_S);

#Display( H0_S );
#Display( H1_S );

L := HomalgComplex( deltaL );
S := HomalgComplex( deltaS );

HL := Homology( L );
HS := Homology( S );
