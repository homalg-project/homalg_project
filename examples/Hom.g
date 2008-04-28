LoadPackage( "RingsForHomalg" );

ZZ := HomalgRingOfIntegersInExternalGAP( );
Display( ZZ );
k := LeftPresentation( [[1,2,3],[3,4,5]], ZZ );
l := LeftPresentation( [[4,5,6,0],[0,2,0,2]], ZZ );
HOM := Hom( l, k );

R := HomalgRingOfIntegersInMaple( );
Display( R );
k := LeftPresentation( [[1,2,3],[3,4,5]], R );
l := LeftPresentation( [[4,5,6,0],[0,2,0,2]], R );
hm := Hom( l, k );

Qxyz := HomalgFieldOfRationalsInMaple( R ) * "x,y,z";
Display( Qxyz );
K := HomalgMatrix( " \
[[x,y,0],[x^2,y^2,0],[x^3,y^3,z^3]]\
", Qxyz );
K := LeftPresentation( K );
L := HomalgMatrix( " \
[[x,y]]\
", Qxyz );
L := LeftPresentation( L );
hom := Hom( L, K );
