LoadPackage( "GradedRingForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1,x2";

S := GradedRing( R );

A := KoszulDualRing( S, "e0,e1,e2" );

LoadPackage( "GradedModules" );

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
omega := S^(-2-1);

## from [ Decker, Eisenbud ]
M := HomalgMatrix( "[ x0^2, x1^2 ]", 1, 2, S );

M := RightPresentationWithDegrees( M );

m := SubmoduleGeneratedByHomogeneousPart( CastelnuovoMumfordRegularity( M ), M );

N := HomalgMatrix( "[ x0^2, x1^2, x2^2 ]", 1, 3, S );

N := RightPresentationWithDegrees( N );

N2 := SubmoduleGeneratedByHomogeneousPart( 2, M );

tate := TateResolution( cotangent, -5, 5 );

betti := BettiDiagram( tate );

Assert( 0,
        MatrixOfDiagram( betti ) =
        [ [ 48, 35, 24, 15, 8, 3, 0, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 0, 0, 0, 3, 8, 15, 24 ] ]
        );

Display( betti );
