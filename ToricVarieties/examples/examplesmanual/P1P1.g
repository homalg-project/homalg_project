#! @Chapter Projective toric varieties 

#! @Section Projective toric varieties: Examples 

#! @Subsection P1xP1 created by a polytope

LoadPackage( "ToricVarieties" );

#! @Example

P1P1 := Polytope( [[1,1],[1,-1],[-1,-1],[-1,1]] );
#! <A polytope in |R^2>
P1P1 := ToricVariety( P1P1 );
#! <A projective toric variety of dimension 2>
IsProjective( P1P1 );
#! true
IsComplete( P1P1 );
#! true 
CoordinateRingOfTorus( P1P1, "x" );
#! Q[x1,x1_,x2,x2_]/( x1*x1_-1, x2*x2_-1 )
IsVeryAmple( Polytope( P1P1 ) );
#! true
ProjectiveEmbedding( P1P1 );
#! [ |[ x1_*x2_ ]|, |[ x1_ ]|, |[ x1_*x2 ]|, |[ x2_ ]|,
#! |[ 1 ]|, |[ x2 ]|, |[ x1*x2_ ]|, |[ x1 ]|, |[ x1*x2 ]| ]
Length( last );
#! 9

#! @EndExample


#! @Subsection P1xP1 from product of P1s

#! @Example

P1 := ProjectiveSpace( 1 );
#! <A projective toric variety of dimension 1>
IsComplete( P1 );
#! true
IsSmooth( P1 );
#! true
Dimension( P1 );
#! 1
P1xP1 := P1*P1;
#! <A projective smooth toric variety of dimension 2 which is a product 
#! of 2 toric varieties>
ByASmallerPresentation( ClassGroup( P1xP1 ) );
#! <A free left module of rank 2 on free generators>
CoxRing( P1xP1 );
#! Q[x_1,x_2,x_3,x_4]
#! (weights: [ ( 1, 0 ), ( 1, 0 ), ( 0, 1 ), ( 0, 1 ) ])

#! @EndExample