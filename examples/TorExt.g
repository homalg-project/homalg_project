##  <#GAPDoc Label="TorExt">
##  <Subsection Label="TorExt">
##  <Heading>TorExt</Heading>
##  This is Example B.6 in <Cite Key="BaSF"/>.
##  <Example><![CDATA[
##  gap> Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> wmat := HomalgMatrix( "[ \
##  > x*y,  y*z,    z,        0,         0,    \
##  > x^3*z,x^2*z^2,0,        x*z^2,     -z^2, \
##  > x^4,  x^3*z,  0,        x^2*z,     -x*z, \
##  > 0,    0,      x*y,      -y^2,      x^2-1,\
##  > 0,    0,      x^2*z,    -x*y*z,    y*z,  \
##  > 0,    0,      x^2*y-x^2,-x*y^2+x*y,y^2-y \
##  > ]", 6, 5, Qxyz );
##  <A homalg external 6 by 5 matrix>
##  gap> W := LeftPresentation( wmat );
##  <A left module presented by 6 relations for 5 generators>
##  gap> P := Resolution( W );
##  <A right acyclic complex containing 3 morphisms of left modules at degrees 
##  [ 0 .. 3 ]>
##  gap> GP := Hom( P );
##  <A cocomplex containing 3 morphisms of right modules at degrees [ 0 .. 3 ]>
##  gap> FGP := GP * P;
##  <A cocomplex containing 3 morphisms of left complexes at degrees [ 0 .. 3 ]>
##  gap> BC := HomalgBicomplex( FGP );
##  <A bicocomplex containing left modules at bidegrees [ 0 .. 3 ]x[ -3 .. 0 ]>
##  gap> p_degrees := ObjectDegreesOfBicomplex( BC )[1];
##  [ 0 .. 3 ]
##  gap> II_E := SecondSpectralSequenceWithFiltration( BC, p_degrees );
##  <A stable cohomological spectral sequence with sheets at levels 
##  [ 0 .. 4 ] each consisting of left modules at bidegrees [ -3 .. 0 ]x
##  [ 0 .. 3 ]>
##  gap> Display( II_E );
##  The associated transposed spectral sequence:
##  
##  a cohomological spectral sequence at bidegrees
##  [ [ 0 .. 3 ], [ -3 .. 0 ] ]
##  ---------
##  Level 0:
##  
##   * * * *
##   * * * *
##   * * * *
##   * * * *
##  ---------
##  Level 1:
##  
##   * * * *
##   . . . .
##   . . . .
##   . . . .
##  ---------
##  Level 2:
##  
##   s s s s
##   . . . .
##   . . . .
##   . . . .
##  
##  Now the spectral sequence of the bicomplex:
##  
##  a cohomological spectral sequence at bidegrees
##  [ [ -3 .. 0 ], [ 0 .. 3 ] ]
##  ---------
##  Level 0:
##  
##   * * * *
##   * * * *
##   * * * *
##   * * * *
##  ---------
##  Level 1:
##  
##   * * * *
##   * * * *
##   * * * *
##   * * * *
##  ---------
##  Level 2:
##  
##   * * s s
##   * * * *
##   . * * *
##   . . . *
##  ---------
##  Level 3:
##  
##   * s s s
##   . s s s
##   . . s *
##   . . . s
##  ---------
##  Level 4:
##  
##   s s s s
##   . s s s
##   . . s s
##   . . . s
##  gap> filt := FiltrationBySpectralSequence( II_E, 0 );
##  <A descending filtration with degrees [ -3 .. 0 ] and graded parts:
##  
##  -3:	<A non-zero cyclic torsion left module presented by yet unknown relations \
##  for a cyclic generator>
##    -2:	<A non-zero left module presented by 17 relations for 7 generators>
##    -1:	<A non-zero left module presented by 25 relations for 12 generators>
##     0:	<A non-zero left module presented by 13 relations for 10 generators>
##  of
##  <A left module presented by yet unknown relations for 24 generators>>
##  gap> ByASmallerPresentation( filt );
##  <A descending filtration with degrees [ -3 .. 0 ] and graded parts:
##  
##  -3:	<A non-zero cyclic torsion left module presented by 3 relations for a cycl\
##  ic generator>
##    -2:	<A non-zero left module presented by 12 relations for 4 generators>
##    -1:	<A non-zero left module presented by 21 relations for 8 generators>
##     0:	<A non-zero left module presented by 11 relations for 10 generators>
##  of
##  <A left module presented by 23 relations for 12 generators>>
##  gap> m := IsomorphismOfFiltration( filt );
##  <An isomorphism of left modules>
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

Read( "ReducedBasisOfModule.g" );

## compute a free resolution of W
P := Resolution( W );
## apply the inner functor G := Hom(-,R) to the resolution
GP := Hom( P );
## tensor with P again
FGP := GP * P;
## the bicomplex associated to FGP
BC := HomalgBicomplex( FGP );

p_degrees := ObjectDegreesOfBicomplex( BC )[1];

## the second spectral sequence together with
## the collapsed first spectral sequence
II_E := SecondSpectralSequenceWithFiltration( BC, p_degrees );

filt := FiltrationBySpectralSequence( II_E );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );
