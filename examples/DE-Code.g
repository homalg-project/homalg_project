##  <#GAPDoc Label="DE-Code">
##  <Subsection Label="DE-Code">
##  <Heading>DE-Code</Heading>
##  <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1,x2";;
##  Display( S );
##  Q[x0,x1,x2]
##  gap> mat := HomalgMatrix( "[ x0^2, x1^2 ]", 1, 2, S );
##  <A homalg external 1 by 2 matrix>
##  gap> M := RightPresentationWithDegrees( mat );
##  <A graded cyclic right module on a cyclic generator satisfying 2 relations>
##  gap> d := Resolution( M );
##  <A right acyclic complex containing 2 morphisms of right modules at degrees
##  [ 0 .. 2 ]>
##  gap> betti := BettiDiagram( d );
##  <A Betti diagram of <A right acyclic complex containing
##  2 morphisms of right modules at degrees [ 0 .. 2 ]>>
##  gap> Display( betti );
##   total:  1 2 1
##  --------------
##       0:  1 . .
##       1:  . 2 .
##       2:  . . 1
##  --------------
##  degree:  0 1 2
##  gap> m := SubmoduleGeneratedByHomogeneousPart( 2, M );
##  <A graded right module on 4 generators satisfying 8 relations>
##  gap> d2 := Resolution( m );
##  <A right acyclic complex containing 2 morphisms of right modules at degrees
##  [ 0 .. 2 ]>
##  gap> betti2 := BettiDiagram( d2 );
##  <A Betti diagram of <A right acyclic complex containing
##  2 morphisms of right modules at degrees [ 0 .. 2 ]>>
##  gap> Display( betti2 );
##       2:  4 8 4
##  --------------
##  degree:  0 1 2
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "Sheaves" );

S := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1,x2";

mat := HomalgMatrix( "[ x0^2, x1^2 ]", 1, 2, S );

M := RightPresentationWithDegrees( mat );

d := Resolution( M );

betti := BettiDiagram( d );

m := SubmoduleGeneratedByHomogeneousPart( 2, M );

d2 := Resolution( m );

betti2 := BettiDiagram( d2 );
