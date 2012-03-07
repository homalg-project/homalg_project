## gapcolor ##
gap> P1P1 := Polytope( [[1,1],[1,-1],[-1,-1],[-1,1]] );
<A polytope>
gap> P1P1 := ToricVariety( P1P1 );
<A projective toric variety>
gap> IsProjective( P1P1 );
true
gap> IsComplete( P1P1 );
true
gap> CoordinateRingOfTorus( P1P1, "x" );
Q[x1,x1_,x2,x2_]/( x2*x2_-1, x1*x1_-1 )
gap> IsVeryAmple( Polytope( P1P1 ) );
true
gap> ProjectiveEmbedding( P1P1 );
[ |[ x1_*x2_ ]|, |[ x1_ ]|, |[ x1_*x2 ]|, |[ x2_ ]|, |[ 1 ]|, |[ x2 ]|, |[ x1*x2_ ]|, |[ x1 ]|, |[ x1*x2 ]| ]
gap> Length(last);
9
## endgapcolor ##