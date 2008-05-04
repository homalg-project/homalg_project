LoadPackage( "RingsForHomalg" );

ZZ := HomalgRingOfIntegersInExternalGAP( );
Display( ZZ );
k := RightPresentation( TransposedMat( [[1,2,3],[3,4,5]] ), ZZ );
l := RightPresentation( TransposedMat( [[4,5,6,0],[0,2,0,2]] ), ZZ );
HM := Hom( l, k );
mor := HomalgMorphism( GetGenerators( HM, 1 ), l, k );
hommap := Hom( l, mor );
