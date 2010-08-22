LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

R := HomalgRingOfIntegersInDefaultCAS( );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( R ) * "x,y,z";

M := HomalgMatrix( "[ x, y, z ]", 1, 3, Qxyz );
M := LeftPresentation( M );
N := HomalgMatrix( "[ \
  x,   y,   z, \
x^3, y^3, z^3  \
]", 2, 3, Qxyz );
N := LeftPresentation( N );
A := HomalgMap( HomalgIdentityMatrix( NrGenerators( M ), Qxyz ), M, N );
map := Hom( A, Qxyz );
