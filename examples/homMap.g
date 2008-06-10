LoadPackage( "RingsForHomalg" );

ZZ := HomalgRingOfIntegersInExternalGAP( );
Display( ZZ );
kk := RightPresentation( TransposedMat( [[1,2,3],[3,4,5]] ), ZZ );
ll := RightPresentation( TransposedMat( [[4,5,6,0],[0,2,0,2]] ), ZZ );
HM := Hom( ll, kk );
MOR := HomalgMap( GetGenerators( HM, 1 ), ll, kk );
HOMMAP := Hom( MOR, ll );

R := HomalgRingOfIntegersInMaple( );
Display( R );
k := RightPresentation( TransposedMat( [[1,2,3],[3,4,5]] ), R );
l := RightPresentation( TransposedMat( [[4,5,6,0],[0,2,0,2]] ), R );
hm := Hom( l, k );
mor := HomalgMap( GetGenerators( hm, 1 ), l, k );
hommap := Hom( mor, l );

