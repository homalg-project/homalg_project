##  <#GAPDoc Label="DE-2.2">
##  <Subsection Label="DE-2.2">
##  <Heading>DE-2.2</Heading>
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1,x2";;
##  gap> S := GradedRing( R );;
##  gap> mat := HomalgMatrix( "[ x0^2, x1^2, x2^2 ]", 1, 3, S ); 
##  <A 1 x 3 matrix over a graded ring>
##  gap> M := RightPresentationWithDegrees( mat, S );
##  <A graded cyclic right module on a cyclic generator satisfying 3 relations>
##  gap> M := RightPresentationWithDegrees( mat );
##  <A graded cyclic right module on a cyclic generator satisfying 3 relations>
##  gap> d := Resolution( M );
##  <A right acyclic complex containing
##  3 morphisms of graded right modules at degrees [ 0 .. 3 ]>
##  gap> betti := BettiTable( d );
##  <A Betti diagram of <A right acyclic complex containing
##  3 morphisms of graded right modules at degrees [ 0 .. 3 ]>>
##  gap> Display( betti );
##   total:  1 3 3 1
##  ----------------
##       0:  1 . . .
##       1:  . 3 . .
##       2:  . . 3 .
##       3:  . . . 1
##  ----------------
##  degree:  0 1 2 3
##  gap> ## we are still below the Castelnuovo-Mumford regularity, which is 3:
##  gap> M2 := SubmoduleGeneratedByHomogeneousPart( 2, M );
##  <A graded torsion right submodule given by 3 generators>
##  gap> d2 := Resolution( M2 );
##  <A right acyclic complex containing
##  3 morphisms of graded right modules at degrees [ 0 .. 3 ]>
##  gap> betti2 := BettiTable( d2 );
##  <A Betti diagram of <A right acyclic complex containing
##  3 morphisms of graded right modules at degrees [ 0 .. 3 ]>>
##  gap> Display( betti2 );
##   total:  3 8 6 1
##  ----------------
##       2:  3 8 6 .
##       3:  . . . 1
##  ----------------
##  degree:  0 1 2 3
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "GradedModules" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1,x2";

S := GradedRing( R );

mat := HomalgMatrix( "[ x0^2, x1^2, x2^2 ]", 1, 3, S );

M := RightPresentationWithDegrees( mat, S );

d := Resolution( M );

betti := BettiTable( d );

## we are still below the Castelnuovo-Mumford regularity, which is 3:
M2 := SubmoduleGeneratedByHomogeneousPart( 2, M );

d2 := Resolution( M2 );

betti2 := BettiTable( d2 );

Display( betti2 );
