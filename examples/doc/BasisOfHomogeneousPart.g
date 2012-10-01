##  <#GAPDoc Label="BasisOfHomogeneousPart:example">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> S := GradedRing( R );;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
##  gap> m := GeneratorsOfHomogeneousPart( 1, M );
##  <An unevaluated non-zero 7 x 3 matrix over a graded ring>
##  gap> Display( m );
##  x^2,0,0,
##  x*y,0,0,
##  y^2,0,0,
##  0,  x,0,
##  0,  y,0,
##  0,  z,0,
##  0,  0,1 
##  (over a graded ring)
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "GradedModules" );
R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
S := GradedRing( R );;
M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
m := GeneratorsOfHomogeneousPart( 1, M );
Display( m );
