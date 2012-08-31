# <#GAPDoc Label="PolytopeExample">
# <Subsection Label="PolytopeExamplePrimary">
# <Heading>Polytope example</Heading>
# <Example><![CDATA[
# gap> P := Polytope( [ [ 2, 0 ], [ 0, 2 ], [ -1, -1 ] ] );
# <A polytope in |R^2>
# gap> IsVeryAmple( P );
# true
# gap> LatticePoints( P );
# [ [ -1, -1 ], [ 0, 0 ], [ 0, 1 ], 
# [ 0, 2 ], [ 1, 0 ], [ 1, 1 ], [ 2, 0 ] ]
# gap> NFP := NormalFan( P );
# <A complete fan in |R^2>
# gap> C1 := MaximalCones( NFP )[ 1 ];
# <A cone in |R^2>
# gap> RayGenerators( C1 );
# [ [ -1, -1 ], [ -1, 3 ] ]
# gap> IsRegularFan( NFP );
# true
# ]]></Example></Subsection>
# <#/GAPDoc> 



P := Polytope( [ [ 2, 0 ], [ 0, 2 ], [ -1, -1 ] ] );
IsVeryAmple( P );
LatticePoints( P );
NFP := NormalFan( P );
C1 := MaximalCones( NFP )[ 1 ];
RayGenerators( C1 );