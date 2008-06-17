LoadPackage( "RingsForHomalg" );

R := HomalgRingOfIntegersInDefaultCAS( );
k := LeftPresentation( [[1,2,3],[3,4,5]], R );
l := LeftPresentation( [[4,5,6,0],[0,2,0,2]], R );
hm := Hom( l, k );
mor := HomalgMap( GetGenerators( hm, 1 ), l, k );
hommap := Hom( l, mor );
