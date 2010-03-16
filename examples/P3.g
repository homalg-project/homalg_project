LoadPackage( "Sheaves" );

S := HomalgFieldOfRationalsInDefaultCAS( ) * "x0..x3";

A := KoszulDualRing( S, "e0..e3" );

## the residue class field (i.e. S modulo the maximal homogeneous ideal)
k := HomalgMatrix( Indeterminates( S ), Length( Indeterminates( S ) ), 1, S );

k := LeftPresentationWithDegrees( k );

## the sheaf supported on a point
p := HomalgMatrix( Indeterminates( S ){[ 1 .. Length( Indeterminates( S ) ) - 1 ]}, 1, Length( Indeterminates( S ) ) - 1, S );

p := RightPresentationWithDegrees( p );

## the sheaf supported on a line
l := HomalgMatrix( Indeterminates( S ){[ 1 .. Length( Indeterminates( S ) ) - 2 ]}, 1, Length( Indeterminates( S ) ) - 2, S );

l := RightPresentationWithDegrees( l );

## the twisted line bundle O(a)
O := a -> S^a;

## the cotangent bundle
cotangent := SyzygiesObject( 2, k );

## the canonical bundle
omega := S^(-3-1);
