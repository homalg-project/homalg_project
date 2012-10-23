## <#GAPDoc Label="ConeExample">
## <Subsection Label="ConeExamplePrimary">
## <Heading>Cone example</Heading>
## <Example><![CDATA[
## gap> C := Cone([[1,2,3],[2,1,1],[1,0,0],[0,1,1]]);
## <A cone in |R^3>
## gap> Length( RayGenerators( C ) );
## 3
## gap> IsSmooth( C );
## true
## gap> Length( HilbertBasis( C ) );
## 3
## gap> IsSimplicial( C );
## true
## gap> DC := DualCone( C );
## <A cone in |R^3>
## gap> Length( HilbertBasis( DC ) );
## 3
## ]]></Example></Subsection>
## <#/GAPDoc> 


C := Cone([[1,2,3],[2,1,1],[1,0,0],[0,1,1]]);
RayGenerators( C );
IsSmooth( C );
HilbertBasis( C );
IsSimplicial( C );
DC := DualCone( C );
HilbertBasis( DC );
