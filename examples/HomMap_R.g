LoadPackage( "RingsForHomalg" );

R := HomalgRingOfIntegersInMaple( );
Display( R );

Qxyz := HomalgFieldOfRationalsInMaple( R ) * "x,y,z";
Display( Qxyz );
M := HomalgMatrix( " \
[[x,y,z]] \
", Qxyz );
M := LeftPresentation( M );
N := HomalgMatrix( " \
[[x,y,z],[x^3,y^3,z^3]] \
", Qxyz );
N := LeftPresentation( N );
A := HomalgMorphism( HomalgIdentityMatrix( NrGenerators( M ), Qxyz ), M, N );
mor := Hom( A, Qxyz );
