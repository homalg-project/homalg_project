LoadPackage( "Sheaves" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";

## p[1] := (0:0:1), p[2] := (0:1:0)
p := [ "[ a, b ]", "[ a, c ]" ];

## are s distinct points in P2
s := Length( p );

## with defining ideals
p := List( p, q -> GradedRightSubmodule( q, R ) );

## and multiplicities
r := [ 2, 3 ];

## and degree
d := 6;

## a random plane curve of degree d with s ordinary singularities
C := RandomProjectivePlaneCurve( d, p, r );

## the genus g of the curve
g := Genus( C );

## the canonical sheaf of C as a sheaf on the ambient projective plane
omega := CanonicalSheafOnAmbientSpace( C );

## the induced morphism in the projective space P^{g-1}
f := InducedMorphismToProjectiveSpace( omega );

## the image of P2
imP2 := ImageScheme( f );

## the module underlying the structure sheaf O_P2, as a module over
## the homogeneous coordinate ring of ambient projective space P^{g-1}
imOP2 := UnderlyingModule( imP2 );

## its Betti diagram
bettiP2 := BettiDiagram( Resolution( Int( g / 2 ) - 1, imOP2 ) );

## the canonical model of C
imC := ImageScheme( f, C );

## the module underlying the structure sheaf O_C, as a module over
## the homogeneous coordinate ring of ambient projective space P^{g-1}
imOC := UnderlyingModule( imC );

## its Betti diagram
bettiC := BettiDiagram( Resolution( Int( g / 2 ) - 1, imOC ) );

