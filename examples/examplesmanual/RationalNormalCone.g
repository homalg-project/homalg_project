# <#GAPDoc Label="RationalNormalConeExample">
# <Subsection Label="RationalNormalConeExampleSubsection">
# <Heading>Rational normal cone</Heading>
# <Example><![CDATA[
# gap> sigma := Cone([[7,-1],[0,1]]);
# <A cone>
# gap> C7:=ToricVariety(sigma);
# <An affine toric variety>
# gap> CoordinateRing(C7,["x"]);
# Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8]/(
# x_7^2-x_6*x_8, x_6*x_7-x_5*x_8, x_5*x_7-x_4*x_8,
# x_4*x_7-x_3*x_8, x_3*x_7-x_2*x_8, x_2*x_7-x_1*x_8,
# x_6^2-x_4*x_8, x_5*x_6-x_3*x_8,
# x_4*x_6-x_2*x_8, x_3*x_6-x_1*x_8, x_2*x_6-x_1*x_7,
# x_5^2-x_2*x_8, x_4*x_5-x_1*x_8, x_3*x_5-x_1*x_7,
# x_2*x_5-x_1*x_6, x_4^2-x_1*x_7, x_3*x_4-x_1*x_6,
# x_2*x_4-x_1*x_5, x_3^2-x_1*x_5, x_2*x_3-x_1*x_4, x_2^2-x_1*x_3 )
# gap> CoordinateRingOfTorus(C7,["y","z"]);
# Q[y,y_,z,z_]/( z*z_-1, y*y_-1 )
# gap> MorphismFromCoordinateRingToCoordinateRingOfTorus(C7);
# <A monomorphism of rings>
# gap> Display(last);
# Q[y,y_,z,z_]/( z*z_-1, y*y_-1 )
#   ^
#   |
# [ |[ y ]|, |[ y*z ]|, |[ y*z^2 ]|, |[ y*z^3 ]|, 
#   |[ y*z^4 ]|, |[ y*z^5 ]|, |[ y*z^6 ]|, |[ y*z^7 ]| ]
#   |
#   |
# Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8]/(
# x_7^2-x_6*x_8, x_6*x_7-x_5*x_8, x_5*x_7-x_4*x_8,
# x_4*x_7-x_3*x_8, x_3*x_7-x_2*x_8, x_2*x_7-x_1*x_8,
# x_6^2-x_4*x_8, x_5*x_6-x_3*x_8,
# x_4*x_6-x_2*x_8, x_3*x_6-x_1*x_8, x_2*x_6-x_1*x_7,
# x_5^2-x_2*x_8, x_4*x_5-x_1*x_8, x_3*x_5-x_1*x_7,
# x_2*x_5-x_1*x_6, x_4^2-x_1*x_7, x_3*x_4-x_1*x_6,
# x_2*x_4-x_1*x_5, x_3^2-x_1*x_5, x_2*x_3-x_1*x_4, x_2^2-x_1*x_3 )
# ]]></Example></Subsection>
# <#/GAPDoc> 

LoadPackage( "ToricVarieties" );

sigma := Cone([[7,-1],[0,1]]);

C7 := ToricVariety( sigma );

CoordinateRing( C7, ["x"] );

CoordinateRingOfTorus( C7, ["y","z"] );

MorphismFromCoordinateRingToCoordinateRingOfTorus( C7 );