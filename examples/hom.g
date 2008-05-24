LoadPackage( "RingsForHomalg" );

ZZ := HomalgRingOfIntegersInExternalGAP( );
Display( ZZ );
kk := RightPresentation( TransposedMat( [[1,2,3],[3,4,5]] ), ZZ );
ll := RightPresentation( TransposedMat( [[4,5,6,0],[0,2,0,2]] ), ZZ );
HM := Hom( ll, kk );

R := HomalgRingOfIntegersInMaple( );
Display( R );
k := RightPresentation( TransposedMat( [[1,2,3],[3,4,5]] ), R );
l := RightPresentation( TransposedMat( [[4,5,6,0],[0,2,0,2]] ), R );
hm := Hom( l, k );

Qxyz := HomalgFieldOfRationalsInMaple( R ) * "x,y,z";
Display( Qxyz );
K := HomalgMatrix( " \
[[x,y,0],[x^2,y^2,0],[x^3,y^3,z^3]] \
", Qxyz );
K := RightPresentation( Involution( K ) );
L := HomalgMatrix( " \
[[x,y]] \
", Qxyz );
L := RightPresentation( Involution( L ) );
hom := Hom( L, K );
