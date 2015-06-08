##  <#GAPDoc Label="MonomialMap:example">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> S := GradedRing( R );;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
##  gap> m := MonomialMap( 1, M );
##  <A homomorphism of graded left modules>
##  gap> Display( m );
##  x^2,0,0,
##  x*y,0,0,
##  x*z,0,0,
##  y^2,0,0,
##  y*z,0,0,
##  z^2,0,0,
##  0,  x,0,
##  0,  y,0,
##  0,  z,0,
##  0,  0,1 
##  
##  the graded map is currently represented by the above 10 x 3 matrix
##  
##  (degrees of generators of target: [ -1, 0, 1 ])
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "GradedModules" );
R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";
S := GradedRing( R );
M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );
M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
m := MonomialMap( 1, M );
Display( m );
