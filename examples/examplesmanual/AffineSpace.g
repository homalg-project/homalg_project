# <#GAPDoc Label="AffineSpaceExample">
# <Subsection Label="AffineSpaceExampleSubsection">
# <Heading>Affine space</Heading>
# <Example><![CDATA[
# gap> C:=Cone( [[1,0,0],[0,1,0],[0,0,1]] );
# <A cone in |R^3>
# gap> C3:=ToricVariety(C);
# <An affine normal toric variety of dimension 3>
# gap> Dimension(C3);
# 3
# gap> IsOrbifold(C3);
# true
# gap> IsSmooth(C3);
# true
# gap> CoordinateRingOfTorus(C3,"x");
# Q[x1,x1_,x2,x2_,x3,x3_]/( x3*x3_-1, x2*x2_-1, x1*x1_-1 )
# gap> CoordinateRing(C3,"x");
# Q[x_1,x_2,x_3]
# gap> MorphismFromCoordinateRingToCoordinateRingOfTorus(C3);
# <A monomorphism of rings>
# gap> Display(last);
# Q[x1,x1_,x2,x2_,x3,x3_]/( x3*x3_-1, x2*x2_-1, x1*x1_-1 )
#   ^
#   |
# [ |[ x3 ]|, |[ x2 ]|, |[ x1 ]| ]
#   |
#   |
# Q[x_1,x_2,x_3]
# gap> C3;
# <An affine normal smooth toric variety of dimension 3>
# gap> StructureDescription(C3);
# "|A^3"
# ]]></Example></Subsection>
# <#/GAPDoc> 

LoadPackage( "ToricVarieties" );
C:=Cone( [[1,0,0],[0,1,0],[0,0,1]] );
C3:=ToricVariety(C);
Dimension(C3);
IsOrbifold(C3);
IsSmooth(C3);
CoordinateRingOfTorus(C3,"x");
CoordinateRing(C3,"x");
MorphismFromCoordinateRingToCoordinateRingOfTorus(C3);
Display(last);
C3;
StructureDescription(C3);