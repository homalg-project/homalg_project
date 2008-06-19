LoadPackage( "RingsForHomalg" );

R := HomalgRingOfIntegersInDefaultCAS( );
k := RightPresentation( TransposedMat( [[1,2,3],[3,4,5]] ), R );
l := RightPresentation( TransposedMat( [[4,5,6,0],[0,2,0,2]] ), R );
hm := Hom( l, k );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( R ) * "x,y,z";

K := HomalgMatrix( "\
[\
x,y,0,\
x^2,y^2,0,\
x^3,y^3,z^3\
]\
", 3, 3, Qxyz );
K := RightPresentation( Involution( K ) );
L := HomalgMatrix( "\
[
x,y
]\
", 1, 2, Qxyz );
L := RightPresentation( Involution( L ) );
hom := Hom( L, K );
