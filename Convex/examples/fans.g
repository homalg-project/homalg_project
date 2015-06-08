# <#GAPDoc Label="FanExample">
# <Subsection Label="FanExamplePrimary">
# <Heading>Fan example</Heading>
# <Example><![CDATA[
# gap> F := Fan( [[-1,5],[0,1],[1,0],[0,-1]],[[1,2],[2,3],[3,4],[4,1]] );
# <A fan in |R^2>
# gap> RayGenerators( F );
# [ [ -1, 5 ], [ 0, 1 ], [ 1, 0 ], [ 0, -1 ] ]
# gap> RaysInMaximalCones( F );
# [ [ 1, 1, 0, 0 ], [ 0, 1, 1, 0 ], [ 0, 0, 1, 1 ], [ 1, 0, 0, 1 ] ]
# gap> IsRegularFan( F );
# true
# gap> IsComplete( F );
# true
# gap> IsSmooth( F );
# true
# gap> F1 := MaximalCones( F )[ 1 ];
# <A cone in |R^2>
# gap> DualCone( F1 );
# <A cone in |R^2>
# gap> RayGenerators( F1 );
# [ [ -1, 5 ], [ 0, 1 ] ]
# gap> F2 := StarSubdivisionOfIthMaximalCone( F, 1 );
# <A fan in |R^2>
# gap> IsSmooth( F2 );
# true
# gap> RayGenerators( F2 );
# [ [ -1, 5 ], [ -1, 6 ], [ 0, -1 ], [ 0, 1 ], [ 1, 0 ] ]
# ]]></Example></Subsection>
# <#/GAPDoc> 

F := Fan( [[-1,5],[0,1],[1,0],[0,-1]],[[1,2],[2,3],[3,4],[4,1]] );
RayGenerators( F );
RaysInMaximalCones( F );
IsRegularFan( F );
IsComplete( F );
IsSmooth( F );
F1 := MaximalCones( F )[ 1 ];
DualCone( F1 );
RayGenerators( F1 );
F2 := StarSubdivisionOfIthMaximalCone( F, 1 );
IsSmooth( F2 );