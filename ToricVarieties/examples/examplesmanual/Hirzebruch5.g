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
