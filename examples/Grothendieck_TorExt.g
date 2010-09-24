##  <#GAPDoc Label="TorExt-Grothendieck">
##  <Section Label="TorExt-Grothendieck">
##  <Heading>TorExt-Grothendieck</Heading>
##  This corresponds to Example B.5 in <Cite Key="BaSF"/>.
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
##  gap> F := InsertObjectInMultiFunctor( Functor_TensorProduct_for_fp_modules, 2, M, "TensorM" );
##  <The functor TensorM for f.p. modules and their maps over computable rings>
##  gap> G := LeftDualizingFunctor( ZZ );;
##  gap> II_E := GrothendieckSpectralSequence( F, G, M );
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
##   . s
##  ---------
##  Level 2:
##  
##   s s
##   . s
##  gap> filt := FiltrationBySpectralSequence( II_E, 0 );
##  <A descending filtration with degrees [ -1 .. 0 ] and graded parts:
##  
##  -1:	<A non-zero left module presented by yet unknown relations for 8 generator\
##  s>
##  
##  0:	<A non-zero left module presented by yet unknown relations for 4 generators\
##  >
##  of
##  <A left module presented by yet unknown relations for 29 generators>>
##  gap> ByASmallerPresentation( filt );
##  <A descending filtration with degrees [ -1 .. 0 ] and graded parts:
##    -1:	<A non-zero left module presented by 4 relations for 4 generators>
##     0:	<A non-torsion left module presented by 2 relations for 3 generators>
##  of
##  <A non-torsion left module presented by 6 relations for 7 generators>>
##  gap> m := IsomorphismOfFiltration( filt );
##  <An isomorphism of left modules>
##  ]]></Example>
##  </Section>
##  <#/GAPDoc>

Read( "homalg.g" );

W := ByASmallerPresentation( M );

InsertObjectInMultiFunctor( Functor_TensorProduct_for_fp_modules, 2, W, "TensorW" );

II_E := GrothendieckSpectralSequence( Functor_TensorW_for_fp_modules, LeftDualizingFunctor( R ), W );

filt := FiltrationBySpectralSequence( II_E );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );
