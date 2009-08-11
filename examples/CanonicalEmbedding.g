## http://www.math.uiuc.edu/Macaulay2/doc/Macaulay2-1.1/share/doc/Macaulay2/Macaulay2Doc/html/___Tutorial_co_sp__Canonical_sp__Embeddings_spof_sp__Plane_sp__Curves_spand_sp__Gonality.html

## ( degree d = 6 => binomial( d - 1, 2 ) = 10 ) - ( degree R = 3 ) = ( genus = 7 )

LoadPackage( "Sheaves" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";

R0 := R * 1;

O := n -> R0 ^ n;

## 3 distinct points in P2

## p1 := (0:0:1)
ipoint1 := HomalgMatrix( "[ a, b ]", 1, 2, R );

## p2 := (0:1:0)
ipoint2 := HomalgMatrix( "[ a, c ]", 1, 2, R );

## p2 := (1:0:0)
ipoint3 := HomalgMatrix( "[ b, c ]", 1, 2, R );

## their defining ideals
ipoint1 := Subobject( ipoint1, R0^0 );

ipoint2 := Subobject( ipoint2, R0^0 );

ipoint3 := Subobject( ipoint3, R0^0 );

## 3 ordinary nodes
icurves1 := Iterated( [ ipoint1^2, ipoint2^2, ipoint3^2 ], Intersect );

Icurves1 := MatrixOfGenerators( icurves1 );

F1 := Icurves1 * RandomMatrix( ( R * 1 )^(-6), icurves1 );

can0 := FullSubmodule( R0 );

can0 := SubmoduleGeneratedByHomogeneousPart( 3, can0 );

## L( d - 3; (2-1) * p1, (2-1) * p2, (2-1) * p3 );
can1 := Iterated( [ ipoint1, ipoint2, ipoint3 ], Intersect );

can1 := SubmoduleGeneratedByHomogeneousPart( 3, can1 );

## L( d - 3; (3-1) * p1 );
can2 := ipoint1 ^ 2;

can2 := SubmoduleGeneratedByHomogeneousPart( 3, can2 );

line := HomalgMatrix( "[ a - b ]", 1, 1, R );

line := Subobject( line, ( R * 1 )^0 );

can3 := Intersect( line + ipoint1^2, ipoint3 );

can3 := SubmoduleGeneratedByHomogeneousPart( 3, can3 );

## S: Proj( S ) = P6
S := CoefficientsRing( R ) * "x0,x1,x2,x3,x4,x5,x6";

images1 := EntriesOfHomalgMatrix( MatrixOfGenerators( can1 ) );

T1 := R / EntriesOfHomalgMatrix( F1 );

f1 := RingMap( images1, S, T1 );

SetDegreeOfMorphism( f1, 0 );

IC1 := KernelSubmodule( f1 );

OC1 := S / IC1;

betti1 := BettiDiagram( Resolution( OC1 ) );
