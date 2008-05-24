LoadPackage( "RingsForHomalg" );

ZZ := HomalgRingOfIntegersInExternalGAP( );
Display( ZZ );
kk := LeftPresentation( [[1,2,3],[3,4,5]], ZZ );
ll := LeftPresentation( [[4,5,6,0],[0,2,0,2]], ZZ );
HM := Hom( ll, kk );
MOR := HomalgMorphism( GetGenerators( HM, 1 ), ll, kk );
HOMMAP := Hom( ll, MOR );

R := HomalgRingOfIntegersInMaple( );
Display( R );
k := LeftPresentation( [[1,2,3],[3,4,5]], R );
l := LeftPresentation( [[4,5,6,0],[0,2,0,2]], R );
hm := Hom( l, k );
mor := HomalgMorphism( GetGenerators( hm, 1 ), l, k );
hommap := Hom( l, mor );

