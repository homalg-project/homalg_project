##  <#GAPDoc Label="RepresentationMapOfKoszulId:example">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> S := GradedRing( R );;
##  gap> A := KoszulDualRing( S, "a,b,c" );;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
##  gap> m := RepresentationMapOfKoszulId( 0, M );
##  <A homomorphism of graded left modules>
##  gap> Display( m );
##  a,b,0,0,0,0,0,
##  0,a,b,0,0,0,0,
##  0,0,0,a,b,c,0 
##  
##  the graded map is currently represented by the above 3 x 7 matrix
##  
##  (degrees of generators of target: [ 4, 4, 4, 4, 4, 4, 4 ])
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "GradedModules" );
R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
S := GradedRing( R );;
A := KoszulDualRing( S, "a,b,c" );;
M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
m := RepresentationMapOfKoszulId( 0, M );
Display( m );
