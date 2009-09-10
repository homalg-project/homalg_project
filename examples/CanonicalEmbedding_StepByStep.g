LoadPackage( "Sheaves" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";

O := n -> (R * 1)^n;

## p[1] := (0:0:1), p[2] := (0:1:0), p[3] := (1:0:0)
p := [ "[ a, b ]", "[ a, c ]", "[ b, c ]" ];

## are s distinct points in P2
s := Length( p );

## with defining ideals
p := List( p, q -> GradedRightSubmodule( q, R ) );

## and multiplicities
r := [ 2, 2, 2 ];

curve := IntersectWithMultiplicity( p, r );

Curve := MatrixOfGenerators( curve );

## a random plane curve of degree d with s ordinary singularities and genus g
d := 6;

g := Binomial( d - 1, 2 ) - Iterated( List( [ 1 .. s ], i -> Binomial( r[i], 2 ) ), SUM );

F := Curve * RandomMatrix( O( -d ), curve );

## adjunction: L( d - 3; (r[1]-1) * p[1], ..., (r[s]-1) * p[s] );
can := IntersectWithMultiplicity( p, r - 1 );

can := SubmoduleGeneratedByHomogeneousPart( d - 3, can );

## S: Proj( S ) = P^{g-1}
S := CoefficientsRing( R ) * [ "x", [ 0 .. g -1 ] ];

images := EntriesOfHomalgMatrix( MatrixOfGenerators( can ) );

T := R / EntriesOfHomalgMatrix( F );

f := RingMap( images, S, T );

SetDegreeOfMorphism( f, 0 );

IC := KernelSubmodule( f );

OC := S * 1 / IC;

betti := BettiDiagram( Resolution( Int( g / 2 ) - 1, OC ) );

## a tacnode leads to the same betti diagram

line := HomalgMatrix( "[ a - b ]", 1, 1, R );

line := Subobject( line, ( R * 1 )^0 );

can3 := Intersect( line + p[1]^2, p[3] );

can3 := SubmoduleGeneratedByHomogeneousPart( 3, can3 );

## A: the Koszul dual ring
A := KoszulDualRing( S, [ "e", [ 0 .. g - 1 ] ] );
