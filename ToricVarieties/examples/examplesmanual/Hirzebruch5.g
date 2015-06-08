LoadPackage( "ToricVarieties" );
HomalgFieldOfRationalsInDefaultCAS();

# <#GAPDoc Label="Hirzebruch5Example">
# <Subsection Label="Hirzebruch5Example">
# <Heading>The Hirzebruch surface of index 5</Heading>
# <Example><![CDATA[
# gap> H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]],[[1,2],[2,3],[3,4],[4,1]] );
# <A fan in |R^2>
# gap> H5 := ToricVariety( H5 );
# <A toric variety of dimension 2>
# gap> IsComplete( H5 );
# true
# gap> IsAffine( H5 );
# false
# gap> IsOrbifold( H5 );
# true
# gap> IsProjective( H5 );
# true
# gap> TorusInvariantPrimeDivisors(H5);
# [ <A prime divisor of a toric variety with coordinates ( 1, 0, 0, 0 )>,
#   <A prime divisor of a toric variety with coordinates ( 0, 1, 0, 0 )>,
#   <A prime divisor of a toric variety with coordinates ( 0, 0, 1, 0 )>,
#   <A prime divisor of a toric variety with coordinates ( 0, 0, 0, 1 )> ]
# gap> P := TorusInvariantPrimeDivisors(H5);
# [ <A prime divisor of a toric variety with coordinates ( 1, 0, 0, 0 )>,
#   <A prime divisor of a toric variety with coordinates ( 0, 1, 0, 0 )>,
#   <A prime divisor of a toric variety with coordinates ( 0, 0, 1, 0 )>,
#   <A prime divisor of a toric variety with coordinates ( 0, 0, 0, 1 )> ]
# gap> A := P[ 1 ] - P[ 2 ] + 4*P[ 3 ];
# <A divisor of a toric variety with coordinates ( 1, -1, 4, 0 )>
# gap> A;
# <A divisor of a toric variety with coordinates ( 1, -1, 4, 0 )>
# gap> IsAmple(A);
# false
# gap> CoordinateRingOfTorus(H5,"x");
# Q[x1,x1_,x2,x2_]/( x1*x1_-1, x2*x2_-1 )
# gap> D:=CreateDivisor([0,0,0,0],H5);
# <A divisor of a toric variety with coordinates 0>
# gap> BasisOfGlobalSections(D);
# [ |[ 1 ]| ]
# gap> D:=Sum(P);
# <A divisor of a toric variety with coordinates ( 1, 1, 1, 1 )>
# gap> BasisOfGlobalSections(D);
# [ |[ x1_ ]|, |[ x1_*x2 ]|, |[ 1 ]|, |[ x2 ]|,
#   |[ x1 ]|, |[ x1*x2 ]|, |[ x1^2*x2 ]|, 
#   |[ x1^3*x2 ]|, |[ x1^4*x2 ]|, |[ x1^5*x2 ]|, 
#   |[ x1^6*x2 ]| ]
# gap> DivisorOfCharacter([1,2],H5);
# <A principal divisor of a toric variety with coordinates ( 9, 2, 1, -2 )>
# gap> BasisOfGlobalSections(last);
# [ |[ x1_*x2_^2 ]| ]
# ]]></Example></Subsection>
# <#/GAPDoc> 

LoadPackage( "ToricVarieties" );
H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]],[[1,2],[2,3],[3,4],[4,1]] );
H5 := ToricVariety( H5 );
IsComplete( H5 );
IsAffine( H5 );
IsOrbifold( H5 );
H5;
ClassGroup( H5 );
PicardGroup( H5 );
ByASmallerPresentation( last );
CoxRing( H5 );
CoordinateRingOfTorus( H5, "y" );
H5;
P := TorusInvariantPrimeDivisors( H5 );
D1 := P[1]+2*P[2]+3*P[3];
IsCartier( D1 );
CartierData( D1 );
Polytope( D1 );
BasisOfGlobalSections( D1 );
IsAmple( D1 );
IsBasepointFree( D1 );
D2 := DivisorOfCharacter( [ 1, 2 ], H5 );
IsAmple( D2 );
CoxRingOfTargetOfDivisorMorphism( D2 );
RingMorphismOfDivisor( D2 );
Display(last);
MonomsOfCoxRingOfDegree( D2 );
D3 := CreateDivisor( [ 0, 0, 1, 1 ], H5 );
IsAmple( D3 );
H5;
RingMorphismOfDivisor( D3 );
Display(last);