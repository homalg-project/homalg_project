#! @System Hirzebruch5

LoadPackage( "ToricVarieties" );

#! @Example
H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]],[[1,2],[2,3],[3,4],[4,1]] );
#! <A fan in |R^2>
H5 := ToricVariety( H5 );
#! <A toric variety of dimension 2>
IsComplete( H5 );
#! true
IsAffine( H5 );
#! false
IsOrbifold( H5 );
#! true
IsProjective( H5 );
#! true
TorusInvariantPrimeDivisors( H5 );
#! [ <A prime divisor of a toric variety with coordinates ( 1, 0, 0, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 1, 0, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 0, 1, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 0, 0, 1 )> ]
P := TorusInvariantPrimeDivisors( H5 );
#! [ <A prime divisor of a toric variety with coordinates ( 1, 0, 0, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 1, 0, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 0, 1, 0 )>,
#!   <A prime divisor of a toric variety with coordinates ( 0, 0, 0, 1 )> ]
A := P[ 1 ] - P[ 2 ] + 4*P[ 3 ];
#! <A divisor of a toric variety with coordinates ( 1, -1, 4, 0 )>
A;
#! <A divisor of a toric variety with coordinates ( 1, -1, 4, 0 )>
IsAmple( A );
#! false
CoordinateRingOfTorus( H5,"x" );
#! Q[x1,x1_,x2,x2_]/( x1*x1_-1, x2*x2_-1 )
D:=CreateDivisor( [ 0,0,0,0 ],H5 );
#! <A divisor of a toric variety with coordinates 0>
BasisOfGlobalSections( D );
#! [ |[ 1 ]| ]
D:=Sum( P );
#! <A divisor of a toric variety with coordinates ( 1, 1, 1, 1 )>
BasisOfGlobalSections(D);
#! [ |[ x1_ ]|, |[ x1_*x2 ]|, |[ 1 ]|, |[ x2 ]|,
#!   |[ x1 ]|, |[ x1*x2 ]|, |[ x1^2*x2 ]|, 
#!   |[ x1^3*x2 ]|, |[ x1^4*x2 ]|, |[ x1^5*x2 ]|, 
#!   |[ x1^6*x2 ]| ]
divi := DivisorOfCharacter( [ 1,2 ],H5 );
#! <A principal divisor of a toric variety with coordinates ( 9, -2, 2, 1 )>
BasisOfGlobalSections( divi );
#! [ |[ x1_*x2_^2 ]| ]
#! @EndExample


#! @System nonprojective

#! @Example
rays := [ [1,0,0], [-1,0,0], [0,1,0], [0,-1,0], [0,0,1], [0,0,-1],
          [2,1,1], [1,2,1], [1,1,2], [1,1,1] ];
#! [ [ 1, 0, 0 ], [ -1, 0, 0 ], [ 0, 1, 0 ], [ 0, -1, 0 ], [ 0, 0, 1 ], [ 0, 0, -1 ], 
#! [ 2, 1, 1 ], [ 1, 2, 1 ], [ 1, 1, 2 ], [ 1, 1, 1 ] ]
cones := [ [1,3,6], [1,4,6], [1,4,5], [2,3,6], [2,4,6], [2,3,5], [2,4,5],
           [1,5,9], [3,5,8], [1,3,7], [1,7,9], [5,8,9], [3,7,8],
           [7,9,10], [8,9,10], [7,8,10] ];
#! [ [ 1, 3, 6 ], [ 1, 4, 6 ], [ 1, 4, 5 ], [ 2, 3, 6 ], [ 2, 4, 6 ], [ 2, 3, 5 ],
#!   [ 2, 4, 5 ], [ 1, 5, 9 ], [ 3, 5, 8 ], [ 1, 3, 7 ], [ 1, 7, 9 ], [ 5, 8, 9 ], 
#!   [ 3, 7, 8 ], [ 7, 9, 10 ], [ 8, 9, 10 ], [ 7, 8, 10 ] ]
F := Fan( rays, cones );
#! <A fan in |R^3>
T := ToricVariety( F );
#! <A toric variety of dimension 3>
[ IsSmooth( T ), IsComplete( T ), IsProjective( T ) ];
#! [ true, true, false ]
SRIdeal( T );
#! <A graded torsion-free (left) ideal given by 23 generators>
#! @EndExample
