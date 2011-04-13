LoadPackage( "GradedRingForHomalg" );

##
R := HomalgFieldOfRationalsInDefaultCAS( ) * "a";

param := Length( Indeterminates( R ) );

##
RR := R * "x0,x1";

S := GradedRing( RR );

n := Length( Indeterminates( S ) ) - param - 1;

weights := Concatenation(
                   ListWithIdenticalEntries( param, 0 ),
                   ListWithIdenticalEntries( n + 1, 1 )
                   );

SetWeightsOfIndeterminates( S, weights );

##
A := KoszulDualRing( S, "e0,e1" );

A!.ByASmallerPresentation := true;

##
m := HomalgMatrix( "[\
 x0, a*x1,   0,   0, \
-x1,    0,   0,   0, \
  0,   x0,   0,   0, \
  0,  -x1,  x0,   0, \
  0,    0, -x1,  x0, \
  0,    0,   0, -x1  \
]", 6, 4, S );

LoadPackage( "GradedModules" );

##
M := RightPresentationWithDegrees( m );

phi := RelativeRepresentationMapOfKoszulId( M );

N := Kernel( phi );

fN := Resolution( 3, N );

##
sfN := A^(-2-1) * Shift( fN, 2 );

Rpi := DegreeZeroSubcomplex( sfN, R );
