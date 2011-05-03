LoadPackage( "GradedRingForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1";

S := GradedRing( R );

A := KoszulDualRing( S, "e0,e1" );

LoadPackage( "GradedModules" );

## the residue class field (i.e. S modulo the maximal homogeneous ideal)
k := HomalgMatrix( Indeterminates( S ), Length( Indeterminates( S ) ), 1, S );

k := LeftPresentationWithDegrees( k );

## the sheaf supported on a point
p := HomalgMatrix( Indeterminates( S ){[ 1 .. Length( Indeterminates( S ) ) - 1 ]}, 1, Length( Indeterminates( S ) ) - 1, S );

p := RightPresentationWithDegrees( p );

## the twisted line bundle O(a)
O := a -> S^a;

## the cotangent bundle
cotangent := SyzygiesObject( 2, k );

## the canonical bundle
omega := S^(-1-1);

tate := TateResolution( cotangent, -5, 5 );

betti := BettiDiagram( tate );

Assert( 0,
        MatrixOfDiagram( betti ) =
        [ [ 7, 6, 5, 4, 3, 2, 1, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4 ] ]
        );

Display( betti );
