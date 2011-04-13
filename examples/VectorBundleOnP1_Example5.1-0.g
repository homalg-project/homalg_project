LoadPackage( "GradedRingForHomalg" );

##
R := HomalgFieldOfRationalsInDefaultCAS( ) * "a";

param := Length( Indeterminates( R ) );

##
RR := R * "x,y";

S := GradedRing( RR );

n := Length( Indeterminates( S ) ) - param - 1;

weights := Concatenation(
                   ListWithIdenticalEntries( param, 0 ),
                   ListWithIdenticalEntries( n + 1, 1 )
                   );

SetWeightsOfIndeterminates( S, weights );

##
A := KoszulDualRing( S, "e,f" );

A!.ByASmallerPresentation := true;

##
m := HomalgMatrix( "[\
-a*x,  0, \
   y,  0, \
  -x,  y, \
   0, -x  \
]", 4, 2, S );

LoadPackage( "GradedModules" );

M := RightPresentationWithDegrees( m );

phi := RelativeRepresentationMapOfKoszulId( M );

N := Kernel( phi );

fN := Resolution( 3, N );

##
sfN := A^(-2-1) * Shift( fN, 2 );

Rpi := DegreeZeroSubcomplex( sfN, R );
