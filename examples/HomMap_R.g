LoadPackage( "RingsForHomalg" );

R := HomalgRingOfIntegersInDefaultCAS( );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( R ) * "x,y,z";

M := HomalgMatrix( " \
[[x,y,z]] \
", Qxyz );
M := LeftPresentation( M );
N := HomalgMatrix( " \
[[x,y,z],[x^3,y^3,z^3]] \
", Qxyz );
N := LeftPresentation( N );
A := HomalgMap( HomalgIdentityMatrix( NrGenerators( M ), Qxyz ), M, N );
mor := Hom( A, Qxyz );
