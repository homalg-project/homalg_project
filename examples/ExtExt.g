##  <#GAPDoc Label="ExtExt">
##  <Subsection Label="ExtExt">
##  <Heading>ExtExt</Heading>
##  This is Example B.2 in <Cite Key="BaSF"/>.
##  <Example><![CDATA[
##  gap> Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";
##  Q[x,y,z]
##  gap> wmat := HomalgMatrix( "[ \
##  > x*y,  y*z,    z,        0,         0,    \
##  > x^3*z,x^2*z^2,0,        x*z^2,     -z^2, \
##  > x^4,  x^3*z,  0,        x^2*z,     -x*z, \
##  > 0,    0,      x*y,      -y^2,      x^2-1,\
##  > 0,    0,      x^2*z,    -x*y*z,    y*z,  \
##  > 0,    0,      x^2*y-x^2,-x*y^2+x*y,y^2-y \
##  > ]", 6, 5, Qxyz );
##  <A 6 x 5 matrix over an external ring>
##  gap> W := LeftPresentation( wmat );
##  <A left module presented by 6 relations for 5 generators>
##  gap> Y := Hom( Qxyz, W );
##  <A right module on 5 generators satisfying yet unknown relations>
##  gap> F := InsertObjectInMultiFunctor( Functor_Hom_for_fp_modules, 2, Y, "TensorY" );
##  <The functor TensorY for f.p. modules and their maps over computable rings>
##  gap> G := LeftDualizingFunctor( Qxyz );;
##  gap> II_E := GrothendieckSpectralSequence( F, G, W );
##  <A stable homological spectral sequence with sheets at levels 
##  [ 0 .. 4 ] each consisting of left modules at bidegrees [ -3 .. 0 ]x
##  [ 0 .. 3 ]>
##  gap> Display( II_E );
##  The associated transposed spectral sequence:
##  
##  a homological spectral sequence at bidegrees
##  [ [ 0 .. 3 ], [ -3 .. 0 ] ]
##  ---------
##  Level 0:
##  
##   * * * *
##   * * * *
##   . * * *
##   . . * *
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
##  a homological spectral sequence at bidegrees
##  [ [ -3 .. 0 ], [ 0 .. 3 ] ]
##  ---------
##  Level 0:
##  
##   * * * *
##   * * * *
##   . * * *
##   . . * *
##  ---------
##  Level 1:
##  
##   * * * *
##   * * * *
##   . * * *
##   . . . *
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
##   * s s s
##   . . s *
##   . . . *
##  ---------
##  Level 4:
##  
##   s s s s
##   . s s s
##   . . s s
##   . . . s
##  gap> filt := FiltrationBySpectralSequence( II_E, 0 );
##  <An ascending filtration with degrees [ -3 .. 0 ] and graded parts:
##  
##  0:	<A non-zero left module presented by yet unknown relations for 23 generator\
##  s>
##    -1:	<A non-zero left module presented by 37 relations for 22 generators>
##    -2:	<A non-zero left module presented by 31 relations for 10 generators>
##    -3:	<A non-zero left module presented by 32 relations for 5 generators>
##  of
##  <A non-zero left module presented by 111 relations for 37 generators>>
##  gap> ByASmallerPresentation( filt );
##  <An ascending filtration with degrees [ -3 .. 0 ] and graded parts:
##     0:	<A non-zero left module presented by 25 relations for 16 generators>
##    -1:	<A non-zero left module presented by 30 relations for 14 generators>
##    -2:	<A non-zero left module presented by 18 relations for 7 generators>
##    -3:	<A non-zero left module presented by 12 relations for 4 generators>
##  of
##  <A non-zero left module presented by 48 relations for 20 generators>>
##  gap> m := IsomorphismOfFiltration( filt );
##  <A non-zero isomorphism of left modules>
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

Read( "ReducedBasisOfModule.g" );

InsertObjectInMultiFunctor( Functor_Hom_for_fp_modules, 2, Y, "TensorY" );

II_E := GrothendieckSpectralSequence( Functor_TensorY_for_fp_modules, LeftDualizingFunctor( Qxyz ), W );

filt := FiltrationBySpectralSequence( II_E );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );

Display( StringTime( homalgTime( Qxyz ) ) );
