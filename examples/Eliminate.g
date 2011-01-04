##  <#GAPDoc Label="Eliminate">
##  <Subsection Label="Eliminate">
##  <Heading>Eliminate</Heading>
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,l,m";;;
##  gap> S := GradedRing( R );;
##  gap> var := Indeterminates( S );
##  [ x, y, z, l, m ]
##  gap> x := var[1];; y := var[2];; z := var[3];; l := var[4];; m := var[5];;
##  gap> L := [ x*m+l-4, y*m+l-2, z*m-l+1, x^2+y^2+z^2-1, x+y-z ];
##  [ x*m+l-4, y*m+l-2, z*m-l+1, x^2+y^2+z^2-1, x+y-z ]
##  gap> e := Eliminate( L, [ l, m ] );
##  <A 3 x 1 matrix over a graded ring>
##   gap> Display( e );
##   4*y+z,  
##   4*x-5*z,
##   21*z^2-8
##   (homogeneous)
##  gap> I := LeftSubmodule( e );
##  <A graded torsion-free (left) ideal given by 3 generators>
##  gap> J := LeftSubmodule( "x+y-z, -2*z-3*y+x, x^2+y^2+z^2-1", S );
##  <A graded torsion-free (left) ideal given by 3 generators>
##  gap> I = J;
##  true
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "GradedModules" );
R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,l,m";;
S := GradedRing( R );;
var := Indeterminates( S );
x := var[1];; y := var[2];; z := var[3];; l := var[4];; m := var[5];;
L := [ x*m+l-4, y*m+l-2, z*m-l+1, x^2+y^2+z^2-1, x+y-z ];
e := Eliminate( L, [ l, m ] );
I := LeftSubmodule( e );
J := GradedLeftSubmodule( "x+y-z, -2*z-3*y+x, x^2+y^2+z^2-1", S );
Assert( 0, I = J );
