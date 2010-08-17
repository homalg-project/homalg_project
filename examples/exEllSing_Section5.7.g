LoadPackage( "GradeModules" );

##
R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";

param := Length( Indeterminates( R ) );

##
S := R * "x0,x1,x2";

n := Length( Indeterminates( S ) ) - param - 1;

weights := Concatenation(
                   ListWithIdenticalEntries( param, 0 ),
                   ListWithIdenticalEntries( n + 1, 1 )
                   );

SetWeightsOfIndeterminates( S, weights );

##
A := KoszulDualRing( S, "e0,e1,e2" );

A!.ByASmallerPresentation := true;

SetWeightsOfIndeterminates( A, weights );

##
m := HomalgMatrix( "[\
-c,0,-b,0,-c,0,0,0,0,0,0,0,a,0,0,0,0,0,0,0,0,-x2,0,-x1,0,-x2,0,0,0,0,0,0,0,x0,0,0,0,0,0,0,0,0, \
b,-c,0,0,0,0,-c,0,0,0,0,0,0,0,0,a,0,0,0,0,0,x1,-x2,0,0,0,0,-x2,0,0,0,0,0,0,0,0,x0,0,0,0,0,0, \
0,b,0,0,0,0,0,0,-c,0,0,0,0,0,0,0,0,0,a,0,0,0,x1,0,0,0,0,0,0,-x2,0,0,0,0,0,0,0,0,0,x0,0,0, \
0,0,a,-c,0,0,0,0,0,-b,0,-c,0,0,0,0,0,0,0,0,0,0,0,x0,-x2,0,0,0,0,0,-x1,0,-x2,0,0,0,0,0,0,0,0,0, \
0,0,0,b,a,-c,0,0,0,0,0,0,0,0,-c,0,0,0,0,0,0,0,0,0,x1,x0,-x2,0,0,0,0,0,0,0,0,-x2,0,0,0,0,0,0, \
0,0,0,0,0,b,a,-c,0,0,0,0,0,0,0,0,0,-c,0,0,0,0,0,0,0,0,x1,x0,-x2,0,0,0,0,0,0,0,0,0,-x2,0,0,0, \
0,0,0,0,0,0,0,b,a,0,0,0,0,0,0,0,0,0,0,0,-c,0,0,0,0,0,0,0,x1,x0,0,0,0,0,0,0,0,0,0,0,0,-x2, \
0,0,0,0,0,0,0,0,0,a,-c,0,b,0,0,c,0,0,0,0,0,0,0,0,0,0,0,0,0,0,x0,-x2,0,x1,0,0,x2,0,0,0,0,0, \
0,0,0,0,0,0,0,0,0,0,b,a,0,-c,0,0,0,0,c,0,0,0,0,0,0,0,0,0,0,0,0,x1,x0,0,-x2,0,0,0,0,x2,0,0, \
0,0,0,0,0,0,0,0,0,0,0,0,c,b,a,0,-c,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,x2,x1,x0,0,-x2,0,0,0,0, \
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,c,b,a,0,-c,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,x2,x1,x0,0,-x2,0, \
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,c,b,a,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,x2,x1,x0 \
]", 12, 42, S ); ##

M := RightPresentationWithDegrees( m );

phi := RelativeRepresentationMapOfKoszulId( M );

N := Kernel( phi );

##
d := 4;

##
fN := Resolution( 2*d, N );

##
sfN := A^(d) * Shift( fN, d-1 );

Rpi := DegreeZeroSubcomplex( sfN, R );
