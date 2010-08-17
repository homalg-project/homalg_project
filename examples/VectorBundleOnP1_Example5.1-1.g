LoadPackage( "GradeModules" );

##
R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b";

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
 x0, a*x1, b*x1,   0,   0, \
-x1,    0,    0,   0,   0, \
  0,   x0,    0,   0,   0, \
  0,  -x1,   x0,   0,   0, \
  0,    0,  -x1,  x0,   0, \
  0,    0,    0, -x1,  x0, \
  0,    0,    0,   0, -x1  \
]", 7, 5, S ); ##

M := RightPresentationWithDegrees( m );

phi := RelativeRepresentationMapOfKoszulId( M );

N := Kernel( phi );

##
fN := Resolution( 3, N );

##
sfN := A^(2+1) * Shift( fN, 2 );

Rpi := DegreeZeroSubcomplex( sfN, R );
