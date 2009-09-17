##  <#GAPDoc Label="Curve:g=11_and_g^1_6-Nonic">
##  <Subsection Label="Curve:g=11_and_g^1_6-Nonic">
##  <Heading>Curve:g=11_and_g^1_6-Nonic</Heading>
##  <Example><![CDATA[
##  gap> 
##  gap> 
##  gap> 
##  gap> 
##  gap> Display( bettiC );
##   total:    1  36 160 315 293
##  ----------------------------
##       0:    1   .   .   .   .
##       1:    .  36 160 315 288
##       2:    .   .   .   .   5
##  ----------------------------
##  degree:    0   1   2   3   4
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "Sheaves" );

R := HomalgRingOfIntegersInSingular( 41 ) * "a,b,c";

## p[1] := (0:0:1),
## p[2] := (0:1:0), p[3] := (1:0:0), p[4] := (0:1:1), p[5] := (1:0:1), p[6] := (1:1:0), p[7] := (0:1:-1), p[8] := (1:0:-1),
## p[9] := (1:-1:0), p[10] := (1:1:-1), p[11] := (1:-1:1), p[12] := (-1:1:1), p[13] := (2:1:0), p[14] := (2:0:1), p[15] := (0:2:1)
p := [
  "[ a, b ]",
  "[ a, c ]", "[ b, c ]", "[ a, b - c ]", "[ a - c, b ]", "[ a - b, c ]", "[ a, b + c ]", "[ a + c, b ]",
  "[ a + b, c ]", "[ a - b, b + c ]", "[ a + b, b + c ]", "[ a + b, b - c ]", "[ a + 2 * b, c ]", "[ a + 2 * c, b ]", "[ a, b + 2 * c ]" ];

## are s distinct points in P2
s := Length( p );

## with defining ideals
p := List( p, q -> GradedRightSubmodule( q, R ) );

## and multiplicities
r := [ 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ];

## and degree
d := 9;

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
#imOP2 := UnderlyingModule( imP2 );

## its Betti diagram
#bettiP2 := BettiDiagram( Resolution( Int( g / 2 ) - 1, imOP2 ) );

## the canonical model of C
imC := ImageScheme( f, C );

## the module underlying the structure sheaf O_C, as a module over
## the homogeneous coordinate ring of ambient projective space P^{g-1}
imOC := UnderlyingModule( imC );

## its Betti diagram
bettiC := BettiDiagram( Resolution( Int( g / 2 ) - 1, imOC ) );

