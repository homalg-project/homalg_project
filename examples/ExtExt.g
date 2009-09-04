##  <#GAPDoc Label="ExtExt">
##  <Section Label="ExtExt">
##  <Heading>ExtExt</Heading>
##  This corresponds to Example B.2 in <Cite Key="BaSF"/>.
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> imat := HomalgMatrix( "[ \
##  >   262,  -33,   75,  -40, \
##  >   682,  -86,  196, -104, \
##  >  1186, -151,  341, -180, \
##  > -1932,  248, -556,  292, \
##  >  1018, -127,  293, -156  \
##  > ]", 5, 4, ZZ );
##  <A homalg internal 5 by 4 matrix>
##  gap> M := LeftPresentation( imat );
##  <A left module presented by 5 relations for 4 generators>
##  gap> N := Hom( ZZ, M );
##  <A non-torsion right module on 4 generators satisfying 3 relations>
##  gap> F := InsertObjectInMultiFunctor( Functor_Hom, 2, N, "TensorN" );
##  <The functor TensorN>
##  gap> G := LeftDualizingFunctor( ZZ );;
##  gap> II_E := GrothendieckSpectralSequence( F, G, M );
##  <A stable homological spectral sequence with sheets at levels 
##  [ 0 .. 2 ] each consisting of left modules at bidegrees [ -1 .. 0 ]x
##  [ 0 .. 1 ]>
##  gap> Display( II_E );
##  The associated transposed spectral sequence:
##  
##  a homological spectral sequence at bidegrees
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
##  a homological spectral sequence at bidegrees
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
##   . s
##  ---------
##  Level 2:
##  
##   s s
##   . s
##  gap> filt := FiltrationBySpectralSequence( II_E, 0 );
##  <An ascending filtration with degrees [ -1 .. 0 ] and graded parts:
##     0:	<A non-zero left module presented by 3 relations for 4 generators>
##    -1:	<A non-zero left module presented by 33 relations for 8 generators>
##  of
##  <A non-zero left module presented by 27 relations for 19 generators>>
##  gap> ByASmallerPresentation( filt );
##  <An ascending filtration with degrees [ -1 .. 0 ] and graded parts:
##     0:	<A non-zero left module presented by 2 relations for 3 generators>
##    -1:	<A non-zero left module presented by 6 relations for 6 generators>
##  of
##  <A non-zero left module presented by 8 relations for 9 generators>>
##  gap> m := IsomorphismOfFiltration( filt );
##  <An isomorphism of left modules>
##  ]]></Example>
##  </Section>
##  <#/GAPDoc>

Read( "homalg.g" );

W := ByASmallerPresentation( M );

Y := Hom( R, W );

InsertObjectInMultiFunctor( Functor_Hom, 2, Y, "TensorY" );

II_E := GrothendieckSpectralSequence( Functor_TensorY, LeftDualizingFunctor( R ), W );

filt := FiltrationBySpectralSequence( II_E );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );
