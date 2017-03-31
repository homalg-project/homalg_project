#! @System Morphism

LoadPackage( "ToricVarieties" );

#! @Example
P1 := Polytope([[0],[1]]);
#! <A polytope in |R^1>
P2 := Polytope([[0,0],[0,1],[1,0]]);
#! <A polytope in |R^2>
P1 := ToricVariety( P1 );
#! <A projective toric variety of dimension 1>
P2 := ToricVariety( P2 );
#! <A projective toric variety of dimension 2>
P1P2 := P1*P2;
#! <A projective toric variety of dimension 3
#!  which is a product of 2 toric varieties>
ClassGroup( P1 );
#! <A free left module of rank 1 on a free generator>
Display(ByASmallerPresentation(ClassGroup( P1 )));
#! Z^(1 x 1)
ClassGroup( P2 );
#! <A free left module of rank 1 on a free generator>
Display(ByASmallerPresentation(ClassGroup( P2 )));
#! Z^(1 x 1)
ClassGroup( P1P2 );
#! <A free left module of rank 2 on free generators>
Display( last );
#! Z^(1 x 2)
PicardGroup( P1P2 );
#! <A free left module of rank 2 on free generators>
P1P2;
#! <A projective smooth toric variety of dimension 3 
#!  which is a product of 2 toric varieties>
P2P1:=P2*P1;
#! <A projective toric variety of dimension 3 
#!  which is a product of 2 toric varieties>
M := [[0,0,1],[1,0,0],[0,1,0]];
#! [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ]
M := ToricMorphism(P1P2,M,P2P1);
#! <A "homomorphism" of right objects>
IsMorphism(M);
#! true
ClassGroup(M);
#! <A homomorphism of left modules>
Display(ClassGroup(M));
#! [ [  0,  1 ],
#!   [  1,  0 ] ]
#! 
#! the map is currently represented by the above 2 x 2 matrix
#! @EndExample
