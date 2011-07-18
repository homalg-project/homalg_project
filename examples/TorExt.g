##  <#GAPDoc Label="TorExt">
##  <Section Label="TorExt">
##  <Heading>TorExt</Heading>
##  This corresponds to Example B.6 in <Cite Key="BaSF"/>.
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> imat := HomalgMatrix( "[ \
##  >   262,  -33,   75,  -40, \
##  >   682,  -86,  196, -104, \
##  >  1186, -151,  341, -180, \
##  > -1932,  248, -556,  292, \
##  >  1018, -127,  293, -156  \
##  > ]", 5, 4, ZZ );
##  <A 5 x 4 matrix over an internal ring>
##  gap> M := LeftPresentation( imat );
##  <A left module presented by 5 relations for 4 generators>
##  gap> P := Resolution( M );
##  <A non-zero right acyclic complex containing a single morphism of left modules\
##   at degrees [ 0 .. 1 ]>
##  gap> GP := Hom( P );
##  <A non-zero acyclic cocomplex containing a single morphism of right modules at\
##   degrees [ 0 .. 1 ]>
##  gap> FGP := GP * P;
##  <A non-zero acyclic cocomplex containing a single morphism of left complexes a\
##  t degrees [ 0 .. 1 ]>
##  gap> BC := HomalgBicomplex( FGP );
##  <A non-zero bicocomplex containing left modules at bidegrees [ 0 .. 1 ]x
##  [ -1 .. 0 ]>
##  gap> p_degrees := ObjectDegreesOfBicomplex( BC )[1];
##  [ 0, 1 ]
##  gap> II_E := SecondSpectralSequenceWithFiltration( BC, p_degrees );
##  <A stable cohomological spectral sequence with sheets at levels 
##  [ 0 .. 2 ] each consisting of left modules at bidegrees [ -1 .. 0 ]x
##  [ 0 .. 1 ]>
##  gap> Display( II_E );
##  The associated transposed spectral sequence:
##  
##  a cohomological spectral sequence at bidegrees
##  [ [ 0 .. 1 ], [ -1 .. 0 ] ]
##  ---------
##  Level 0:
##  
##   * *
##   * *
##  ---------
##  Level 1:
##  
##   * *
##   . .
##  ---------
##  Level 2:
##  
##   s s
##   . .
##  
##  Now the spectral sequence of the bicomplex:
##  
##  a cohomological spectral sequence at bidegrees
##  [ [ -1 .. 0 ], [ 0 .. 1 ] ]
##  ---------
##  Level 0:
##  
##   * *
##   * *
##  ---------
##  Level 1:
##  
##   * *
##   * *
##  ---------
##  Level 2:
##  
##   s s
##   . s
##  gap> filt := FiltrationBySpectralSequence( II_E, 0 );
##  <A descending filtration with degrees [ -1 .. 0 ] and graded parts:
##  
##  -1:	<A non-zero left module presented by yet unknown relations for 10 generato\
##  rs>
##     0:	<A rank 1 left module presented by 3 relations for 4 generators>
##  of
##  <A left module presented by yet unknown relations for 13 generators>>
##  gap> ByASmallerPresentation( filt );
##  <A descending filtration with degrees [ -1 .. 0 ] and graded parts:
##    -1:	<A non-zero left module presented by 4 relations for 4 generators>
##     0:	<A rank 1 left module presented by 2 relations for 3 generators>
##  of
##  <A non-torsion left module presented by 6 relations for 7 generators>>
##  gap> m := IsomorphismOfFiltration( filt );
##  <A non-zero isomorphism of left modules>
##  ]]></Example>
##  </Section>
##  <#/GAPDoc>

Read( "homalg.g" );

W := ByASmallerPresentation( M );

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
