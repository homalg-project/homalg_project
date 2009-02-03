LoadPackage( "Sheaves" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "a";

S := R * "x0,x1";

weights := [ [2,0], [1,1], [1,1] ];

SetWeightsOfIndeterminates( S, weights );

A := KoszulDualRing( S, "a,e0,e1" );

SetWeightsOfIndeterminates( A, weights );

m := HomalgMatrix( "[\
 x0, a*x1,   0,   0, \
-x1,    0,   0,   0, \
  0,   x0,   0,   0, \
  0,  -x1,  x0,   0, \
  0,    0, -x1,  x0, \
  0,    0,   0, -x1  \
]", 6, 4, S );

degrees := [[0, 0], [0, 0], [2, 0], [2, 0], [2, 0], [2, 0]];

M := RightPresentationWithDegrees( m, degrees );

phi := RelativeRepresentationMapOfKoszulId( M );

N := Kernel( phi );

fN := Resolution( 3, N );

sfN := Shift( fN, 2 ) * A^[[0,2+1]];

Rpi := DegreeZeroSubcomplex( sfN, R );
