##  <#GAPDoc Label="DE-Code">
##  <Subsection Label="DE-Code">
##  <Heading>DE-Code</Heading>
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1,x2";;
##  gap> S := GradedRing( R );;
##  gap> mat := HomalgMatrix( "[ x0^2, x1^2 ]", 1, 2, S );
##  <A 1 x 2 matrix over a graded ring>
##  gap> M := RightPresentationWithDegrees( mat, S );
##  <A graded cyclic right module on a cyclic generator satisfying 2 relations>
##  gap> d := Resolution( M );
##  <A right acyclic complex containing
##  2 morphisms of graded right modules at degrees [ 0 .. 2 ]>
##  gap> betti := BettiDiagram( d );
##  <A Betti diagram of <A right acyclic complex containing
##  2 morphisms of graded right modules at degrees [ 0 .. 2 ]>>
##  gap> Display( betti );
##   total:  1 2 1
##  --------------
##       0:  1 . .
##       1:  . 2 .
##       2:  . . 1
##  --------------
##  degree:  0 1 2
##  gap> m := SubmoduleGeneratedByHomogeneousPart( 2, M );
##  <A graded torsion right submodule given by 4 generators>
##  gap> d2 := Resolution( m );
##  <A right acyclic complex containing
##  2 morphisms of graded right modules at degrees [ 0 .. 2 ]>
##  gap> betti2 := BettiDiagram( d2 );
##  <A Betti diagram of <A right acyclic complex containing
##  2 morphisms of graded right modules at degrees [ 0 .. 2 ]>>
##  gap> Display( betti2 );
##       2:  4 8 4
##  --------------
##  degree:  0 1 2
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "GradedModules" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1,x2";

S := GradedRing( R );

mat := HomalgMatrix( "[ x0^2, x1^2 ]", 1, 2, S );

M := RightPresentationWithDegrees( mat, S );

d := Resolution( M );

betti := BettiDiagram( d );

Display( betti );

m := SubmoduleGeneratedByHomogeneousPart( 2, M );

d2 := Resolution( m );

betti2 := BettiDiagram( d2 );

Display( betti2 );
