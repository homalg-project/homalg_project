##  <#GAPDoc Label="HomogeneousPartOverCoefficientsRing:example">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> S := GradedRing( R );;
##  gap> M := HomalgMatrix( "[ x, y^2, z^3 ]", 3, 1, S );;
##  gap> M := Subobject( M, ( 1 * S )^0 );
##  <A graded torsion-free (left) ideal given by 3 generators>
##  gap> CastelnuovoMumfordRegularity( M );
##  4
##  gap> M1 := HomogeneousPartOverCoefficientsRing( 1, M );
##  <A graded left vector space of dimension 1 on a free generator>
##  gap> gen1 := GeneratorsOfModule( M1 );
##  <A set consisting of a single generator of a homalg left module>
##  gap> Display( M1 );
##  Q^(1 x 1)
##  
##  (graded, degree of generator: 1)
##  gap> M2 := HomogeneousPartOverCoefficientsRing( 2, M );
##  <A graded left vector space of dimension 4 on free generators>
##  gap> Display( M2 );
##  Q^(1 x 4)
##  
##  (graded, degrees of generators: [ 2, 2, 2, 2 ])
##  gap> gen2 := GeneratorsOfModule( M2 );
##  <A set of 4 generators of a homalg left module>
##  gap> M3 := HomogeneousPartOverCoefficientsRing( 3, M );
##  <A graded left vector space of dimension 9 on free generators>
##  gap> Display( M3 );
##  Q^(1 x 9)
##  
##  (graded, degrees of generators: [ 3, 3, 3, 3, 3, 3, 3, 3, 3 ])
##  gap> gen3 := GeneratorsOfModule( M3 );
##  <A set of 9 generators of a homalg left module>
##   gap> Display( gen1 );
##   x
##   
##   a set consisting of a single generator given by (the row of) the above matrix
##   gap> Display( gen2 );
##   x^2,
##   x*y,
##   x*z,
##   y^2 
##   
##   a set of 4 generators given by the rows of the above matrix
##   gap> Display( gen3 );
##   x^3,  
##   x^2*y,
##   x^2*z,
##   x*y*z,
##   x*z^2,
##   x*y^2,
##   y^3,  
##   y^2*z,
##   z^3   
##   
##   a set of 9 generators given by the rows of the above matrix
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "GradedModules" );
R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
S := GradedRing( R );;
M := HomalgMatrix( "[ x, y^2, z^3 ]", 3, 1, S );;
M := Subobject( M, ( 1 * S )^0 );
M1 := HomogeneousPartOverCoefficientsRing( 1, M );
gen1 := GeneratorsOfModule( M1 );
Display( M1 );
M2 := HomogeneousPartOverCoefficientsRing( 2, M );
Display( M2 );
gen2 := GeneratorsOfModule( M2 );
M3 := HomogeneousPartOverCoefficientsRing( 3, M );
Display( M3 );
gen3 := GeneratorsOfModule( M3 );
Display( gen1 );
Display( gen2 );
Display( gen3 );
