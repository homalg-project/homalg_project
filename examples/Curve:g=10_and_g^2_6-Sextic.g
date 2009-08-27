LoadPackage( "Sheaves" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";

O := n -> (R * 1)^n;

## no singular points (a smooth curve)
p := [  ];

## are s distinct points in P2
s := Length( p );

## with defining ideals
p := List( p, q -> Subobject( HomalgMatrix( q, 1, 2, R ), O( 0 ) ) );

## and multiplicities
r := [ ];

curve := FullSubmodule( O( 0 ) );

Curve := MatrixOfGenerators( curve );

## a random plane curve of degree d with s ordinary singularities and genus g
d := 6;

g := Binomial( d - 1, 2 );

F := Curve * RandomMatrix( O( -d ), curve );

## adjunction: L( d - 3; (r[1]-1) * p[1], ..., (r[s]-1) * p[s] );
can := FullSubmodule( O( 0 ) );

can := SubmoduleGeneratedByHomogeneousPart( d - 3, can );

## S: Proj( S ) = P^{g-1}
vars := JoinStringsWithSeparator( List( [ 0 .. g - 1 ], i -> Concatenation( "x", String( i ) ) ) );

S := CoefficientsRing( R ) * vars;

images := EntriesOfHomalgMatrix( MatrixOfGenerators( can ) );

T := R / EntriesOfHomalgMatrix( F );

f := RingMap( images, S, T );

SetDegreeOfMorphism( f, 0 );

IC := KernelSubmodule( f );

OC := S * 1 / IC;

betti := BettiDiagram( Resolution( 2, OC ) );
