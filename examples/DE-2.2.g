##  <#GAPDoc Label="DE-2.2">
##  <Subsection Label="DE-2.2">
##  <Heading>DE-2.2</Heading>
##  <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1,x2";;
##  Display( S );
##  Q[x0,x1,x2]
##  gap> mat := HomalgMatrix( "[ x0^2, x1^2, x2^2 ]", 1, 3, S ); 
##  <A homalg external 1 by 3 matrix>
##  gap> M := RightPresentationWithDegrees( mat );
##  <A graded cyclic right module on a cyclic generator satisfying 3 relations>
##  gap> M := RightPresentationWithDegrees( mat );
##  <A graded cyclic right module on a cyclic generator satisfying 3 relations>
##  gap> d := Resolution( M );
##  <A right acyclic complex containing 3 morphisms of right modules at degrees
##  [ 0 .. 3 ]>
##  gap> betti := BettiDiagram( d );
##  <A Betti diagram of <A right acyclic complex containing
##  3 morphisms of right modules at degrees [ 0 .. 3 ]>>
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
##  <A right acyclic complex containing 3 morphisms of right modules at degrees
##  [ 0 .. 3 ]>
##  gap> betti2 := BettiDiagram( d2 );
##  <A Betti diagram of <A right acyclic complex containing
##  3 morphisms of right modules at degrees [ 0 .. 3 ]>>
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

LoadPackage( "GradeModules" );

S := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1,x2";

mat := HomalgMatrix( "[ x0^2, x1^2, x2^2 ]", 1, 3, S );

M := RightPresentationWithDegrees( mat );

d := Resolution( M );

betti := BettiDiagram( d );

## we are still below the Castelnuovo-Mumford regularity, which is 3:
M2 := SubmoduleGeneratedByHomogeneousPart( 2, M );

d2 := Resolution( M2 );

betti2 := BettiDiagram( d2 );
