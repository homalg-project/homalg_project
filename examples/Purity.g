##  <#GAPDoc Label="Purity">
##  <Section Label="Purity">
##  <Heading>Purity</Heading>
##  This corresponds to Example B.3 in <Cite Key="BaSF"/>.
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
##  gap> filt := PurityFiltration( M );
##  <The ascending purity filtration with degrees [ -1 .. 0 ] and graded parts:
##     0:	<A free left module of rank 1 on a free generator>
##    
##  -1:	<A non-zero torsion left module presented by 2 relations for 2 generators>
##  of
##  <A non-pure rank 1 left module presented by 2 relations for 3 generators>>
##  gap> M;
##  <A non-pure rank 1 left module presented by 2 relations for 3 generators>
##  gap> II_E := SpectralSequence( filt );
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
##   s .
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
##   s .
##   . s
##  gap> m := IsomorphismOfFiltration( filt );
##  <A non-zero isomorphism of left modules>
##  gap> IsIdenticalObj( Range( m ), M );
##  true
##  gap> Source( m );
##  <A non-torsion left module presented by 2 relations for 3 generators (locked)>
##  gap> Display( last );
##  [ [   0,   2,   0 ],
##    [   0,   0,  12 ] ]
##  
##  Cokernel of the map
##  
##  Z^(1x2) --> Z^(1x3),
##  
##  currently represented by the above matrix
##  gap> Display( filt );
##  Degree 0:
##  
##  Z^(1 x 1)
##  ----------
##  Degree -1:
##  
##  Z/< 2 > + Z/< 12 > 
##  ]]></Example>
##  </Section>
##  <#/GAPDoc>

Read( "homalg.g" );

filt := PurityFiltration( M );

II_E := SpectralSequence( filt );

m := IsomorphismOfFiltration( filt );
