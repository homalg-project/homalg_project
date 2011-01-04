##  <#GAPDoc Label="KoszulRightAdjoint:example">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> S := GradedRing( R );;
##  gap> A := KoszulDualRing( S, "a,b,c" );;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ], S );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
##  gap> CastelnuovoMumfordRegularity( M );
##  1
##  gap> R := KoszulRightAdjoint( M, -5, 5 );
##  <A cocomplex containing 10 morphisms of left graded modules at degrees
##  [ -5 .. 5 ]>
##  gap> R := KoszulRightAdjoint( M, 1, 5 );
##  <An acyclic cocomplex containing
##  4 morphisms of left graded modules at degrees [ 1 .. 5 ]>
##  gap> R := KoszulRightAdjoint( M, 0, 5 );
##  <A cocomplex containing 5 morphisms of left graded modules at degrees
##  [ 0 .. 5 ]>
##  gap> R := KoszulRightAdjoint( M, -5, 5 );
##  <A cocomplex containing 10 morphisms of left graded modules at degrees
##  [ -5 .. 5 ]>
##  gap> H := Cohomology( R );
##  <A graded cohomology object consisting of 11 left graded modules at degrees 
##  [ -5 .. 5 ]>
##  gap> ByASmallerPresentation( H );
##  <A non-zero graded cohomology object consisting of
##  11 left graded modules at degrees [ -5 .. 5 ]>
##  gap> Cohomology( R, -2 );
##  <A graded zero left module>
##  gap> Cohomology( R, -3 );
##  <A graded zero left module>
##  gap> Cohomology( R, -1 );
##  <A graded non-zero cyclic left module presented by 2 relations for a cyclic ge\
##  nerator>
##  gap> Cohomology( R, 0 );
##  <A graded non-zero cyclic left module presented by 3 relations for a cyclic ge\
##  nerator>
##  gap> Cohomology( R, 1 );
##  <A graded non-zero cyclic left module presented by 2 relations for a cyclic ge\
##  nerator>
##  gap> Cohomology( R, 2 );
##  <A graded zero left module>
##  gap> Cohomology( R, 3 );
##  <A graded zero left module>
##  gap> Cohomology( R, 4 );
##  <A graded zero left module>
##   gap> Display( Cohomology( R, -1 ) );
##   Q{a,b,c}/< b, a >
##   
##   (graded, degree of generator: -3)
##   gap> Display( Cohomology( R, 0 ) );
##   Q{a,b,c}/< c, b, a >
##   
##   (graded, degree of generator: -3)
##   gap> Display( Cohomology( R, 1 ) );
##   Q{a,b,c}/< b, a >
##   
##   (graded, degree of generator: -1)
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "GradedModules" );
R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
S := GradedRing( R );;
A := KoszulDualRing( S, "a,b,c" );;
M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ], S );
CastelnuovoMumfordRegularity( M );
R := KoszulRightAdjoint( M, -5, 5 );
R := KoszulRightAdjoint( M, 1, 5 );
R := KoszulRightAdjoint( M, 0, 5 );
R := KoszulRightAdjoint( M, -5, 5 );
H := Cohomology( R );
ByASmallerPresentation( H );
Cohomology( R, -2 );
Cohomology( R, -3 );
Cohomology( R, -1 );
Cohomology( R, 0 );
Cohomology( R, 1 );
Cohomology( R, 2 );
Cohomology( R, 3 );
Cohomology( R, 4 );
Display( Cohomology( R, -1 ) );
Display( Cohomology( R, 0 ) );
Display( Cohomology( R, 1 ) );
