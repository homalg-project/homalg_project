##  <#GAPDoc Label="Schenck-3.2">
##  <Subsection Label="Schenck-3.2">
##  <Heading>Schenck-3.2</Heading>
##  This is an example from Section 3.2 in <Cite Key="Sch"/>.
##  <Example><![CDATA[
##  gap> Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> mmat := HomalgMatrix( "[ x, x^3 + y^3 + z^3 ]", 1, 2, Qxyz );
##  <A homalg external 1 by 2 matrix>
##  gap> M := RightPresentationWithDegrees( mmat );
##  <A graded cyclic right module on a cyclic generator satisfying 2 relations>
##  gap> Mr := Resolution( M );
##  <A right acyclic complex containing 2 morphisms of right modules at degrees
##  [ 0 .. 2 ]>
##  gap> bettiM := BettiDiagram( Mr );
##  <A Betti diagram of <A right acyclic complex containing
##  2 morphisms of right modules at degrees [ 0 .. 2 ]>>
##  gap> Display( bettiM );
##   total:  1 2 1
##  --------------
##       0:  1 1 .
##       1:  . . .
##       2:  . 1 1
##  --------------
##  degree:  0 1 2
##  gap> R := Qxyz * "w";;
##  gap> nmat := HomalgMatrix( "[ z^2 - y*w, y*z - x*w, y^2 - x*z ]", 1, 3, R );
##  <A homalg external 1 by 3 matrix>
##  gap> N := RightPresentationWithDegrees( nmat );
##  <A graded cyclic right module on a cyclic generator satisfying 3 relations>
##  gap> Nr := Resolution( N );
##  <A right acyclic complex containing 2 morphisms of right modules at degrees
##  [ 0 .. 2 ]>
##  gap> bettiN := BettiDiagram( Nr );
##  <A Betti diagram of <A right acyclic complex containing
##  2 morphisms of right modules at degrees [ 0 .. 2 ]>>
##  gap> Display( bettiN );           
##   total:  1 3 2
##  --------------
##       0:  1 . .
##       1:  . 3 2
##  --------------
##  degree:  0 1 2
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

mmat := HomalgMatrix( "[ x, x^3 + y^3 + z^3 ]", 1, 2, Qxyz );

M := RightPresentationWithDegrees( mmat );

Mr := Resolution( M );

bettiM := BettiDiagram( Mr );

R := Qxyz * "w";

nmat := HomalgMatrix( "[ z^2 - y*w, y*z - x*w, y^2 - x*z ]", 1, 3, R );

N := RightPresentationWithDegrees( nmat );

Nr := Resolution( N );

bettiN := BettiDiagram( Nr );

