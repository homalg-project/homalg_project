LoadPackage( "Sheaves" );

S := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1,x2,x3";

A := KoszulDualRing( S, "e0,e1,e2,e3" );

## the residue class field (i.e. S modulo the maximal homogeneous ideal)
k := HomalgMatrix( Indeterminates( S ), Length( Indeterminates( S ) ), 1, S );

k := LeftPresentationWithWeights( k );

## the sheaf supported on a point
p := HomalgMatrix( Indeterminates( S ){[ 1 .. Length( Indeterminates( S ) ) ]}, 1, Length( Indeterminates( S ) ) - 1, S );

p := RightPresentationWithWeights( p );

## the sheaf supported on a line
l := HomalgMatrix( Indeterminates( S ){[ 1 .. Length( Indeterminates( S ) ) ]}, 1, Length( Indeterminates( S ) ) - 2, S );

l := RightPresentationWithWeights( l );

## the twisted line bundle O(a)
O := a -> S^a;

## the cotangent bundle
cotangent := SyzygiesModule( 2, k );

## the canonical bundle
omega := S^(-3-1);
