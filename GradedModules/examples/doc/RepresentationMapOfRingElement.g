##  <#GAPDoc Label="RepresentationMapOfRingElement:example">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> S := GradedRing( R );;
##  gap> x := Indeterminate( S, 1 );
##  x
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
##  gap> m := RepresentationMapOfRingElement( x, M, 0 );
##  <A "homomorphism" of graded left modules>
##  gap> Display( m );
##  1,0,0,0,0,0,0,
##  0,1,0,0,0,0,0,
##  0,0,0,1,0,0,0 
##  
##  the graded map is currently represented by the above 3 x 7 matrix
##  
##  (degrees of generators of target: [ 1, 1, 1, 1, 1, 1, 1 ])
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "GradedModules" );
R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
S := GradedRing( R );;
x := Indeterminate( S, 1 );
M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
m := RepresentationMapOfRingElement( x, M, 0 );
Display( m );
