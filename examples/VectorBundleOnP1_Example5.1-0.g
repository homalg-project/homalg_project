LoadPackage( "GradeModules" );

##
R := HomalgFieldOfRationalsInDefaultCAS( ) * "a";

param := Length( Indeterminates( R ) );

##
S := R * "x,y";

n := Length( Indeterminates( S ) ) - param - 1;

weights := Concatenation(
                   ListWithIdenticalEntries( param, 0 ),
                   ListWithIdenticalEntries( n + 1, 1 )
                   );

SetWeightsOfIndeterminates( S, weights );

##
A := KoszulDualRing( S, "e,f" );

A!.ByASmallerPresentation := true;

SetWeightsOfIndeterminates( A, weights );

##
m := HomalgMatrix( "[\
-a*x,  0, \
   y,  0, \
  -x,  y, \
   0, -x  \
]", 4, 2, S ); ##

##
degrees := ListWithIdenticalEntries( NrRows( m ), 0 );

M := RightPresentationWithDegrees( m, degrees );

phi := RelativeRepresentationMapOfKoszulId( M );

N := Kernel( phi );

fN := Resolution( 3, N );

##
sfN := A^(2+1) * Shift( fN, 2 );

Rpi := DegreeZeroSubcomplex( sfN, R );
