LoadPackage( "Sheaves" );

##
R := HomalgFieldOfRationalsInDefaultCAS( ) * "a00,a01,a02,a03,a04,a10,a11,a12,a13,a14";

param := Length( Indeterminates( R ) );

##
S := R * "x0,x1";

n := Length( Indeterminates( S ) ) - param - 1;

weights := Concatenation(
                   ListWithIdenticalEntries( param, 0 ),
                   ListWithIdenticalEntries( n + 1, 1 )
                   );

SetWeightsOfIndeterminates( S, weights );

##
A := KoszulDualRing( S, "e0,e1" );

A!.ByASmallerPresentation := true;

SetWeightsOfIndeterminates( A, weights );

##
m := HomalgMatrix( "[\
x0, 0, a00*x1, a01*x1, a02*x1, a03*x1, a04*x1, 0, 0, \
-x1, 0, 0, 0, 0, 0, 0, 0, 0, \
0, x0, a10*x1, a11*x1, a12*x1, a13*x1, a14*x1, 0, 0, \
0, -x1, 0, 0, 0, 0, 0, 0, 0, \
0, 0, x0, 0, 0, 0, 0, 0, 0, \
0, 0, -x1, x0, 0, 0, 0, 0, 0, \
0, 0, 0, -x1, x0, 0, 0, 0, 0, \
0, 0, 0, 0, -x1, x0, 0, 0, 0, \
0, 0, 0, 0, 0, -x1, x0, 0, 0, \
0, 0, 0, 0, 0, 0, -x1, x0, 0, \
0, 0, 0, 0, 0, 0, 0, -x1, x0, \
0, 0, 0, 0, 0, 0, 0, 0, -x1 \
]", 12, 9, S ); ##

M := RightPresentationWithDegrees( m );

phi := RelativeRepresentationMapOfKoszulId( M );

N := Kernel( phi );

fN := Resolution( 7, N );

##
sfN := A^(2+1) * Shift( fN, 2 );

Rpi := DegreeZeroSubcomplex( sfN, R );
