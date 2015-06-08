# <#GAPDoc Label="MorphismExample">
# <Subsection Label="MorphismExample">
# <Heading>Morphism between toric varieties and their class groups</Heading>
# <Example><![CDATA[
# gap> P1 := Polytope([[0],[1]]);
# <A polytope in |R^1>
# gap> P2 := Polytope([[0,0],[0,1],[1,0]]);
# <A polytope in |R^2>
# gap> P1 := ToricVariety( P1 );
# <A projective toric variety of dimension 1>
# gap> P2 := ToricVariety( P2 );
# <A projective toric variety of dimension 2>
# gap> P1P2 := P1*P2;
# <A projective toric variety of dimension 3
#  which is a product of 2 toric varieties>
# gap> ClassGroup( P1 );
# <A non-torsion left module presented by 1 relation for 2 generators>
# gap> Display(ByASmallerPresentation(last));
# Z^(1 x 1) 
# gap> ClassGroup( P2 );
# <A non-torsion left module presented by 2 relations for 3 generators>
# gap> Display(ByASmallerPresentation(last));
# Z^(1 x 1)
# gap> ClassGroup( P1P2 );
# <A free left module of rank 2 on free generators>
# gap> Display( last );
# Z^(1 x 2)
# gap> PicardGroup( P1P2 );
# <A free left module of rank 2 on free generators>
# gap> P1P2;
# <A projective smooth toric variety of dimension 3 
#  which is a product of 2 toric varieties>
# gap> P2P1:=P2*P1;
# <A projective toric variety of dimension 3 
#  which is a product of 2 toric varieties>
# gap> M := [[0,0,1],[1,0,0],[0,1,0]];
# [ [ 0, 0, 1 ], [ 1, 0, 0 ], [ 0, 1, 0 ] ]
# gap> M := ToricMorphism(P1P2,M,P2P1);
# <A "homomorphism" of right objects>
# gap> IsMorphism(M);
# true
# gap> ClassGroup(M);
# <A homomorphism of left modules>
# gap> Display(last);
# [ [  0,  1 ],
#   [  1,  0 ] ]
# 
# the map is currently represented by the above 2 x 2 matrix
# gap> ByASmallerPresentation(ClassGroup(M));
# <A non-zero homomorphism of left modules>
# gap> Display(last);
# [ [  0,  1 ],
#   [  1,  0 ] ]
# 
# the map is currently represented by the above 2 x 2 matrix
# ]]></Example></Subsection>
# <#/GAPDoc> 

LoadPackage( "ToricVarieties" );
P1 := Polytope([[0],[1]]);
P2 := Polytope([[0,0],[0,1],[1,0]]);
P1 := ToricVariety( P1 );
P2 := ToricVariety( P2 );
P1P2 := P1*P2;
ClassGroup( P1 );
Display(ByASmallerPresentation(last));
ClassGroup( P2 );
Display(ByASmallerPresentation(last));
ClassGroup( P1P2 );
Display( last );
PicardGroup( P1P2 );
P1P2;
P2P1:=P2*P1;
M := [[0,0,1],[1,0,0],[0,1,0]];
M := ToricMorphism(P1P2,M,P2P1);
IsMorphism(M);
ClassGroup(M);
Display(last);
ByASmallerPresentation(ClassGroup(M));
Display(last);
