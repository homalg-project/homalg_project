##  <#GAPDoc Label="Purity">
##  <Subsection Label="Purity">
##  <Heading>Purity</Heading>
##  This is Example B.3 in <Cite Key="BaSF"/>.
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
##  <A 6 x 5 matrix over an external ring>
##  gap> W := LeftPresentation( wmat );
##  <A left module presented by 6 relations for 5 generators>
##  gap> filt := PurityFiltration( W );
##  <The ascending purity filtration with degrees [ -3 .. 0 ] and graded parts:
##  
##  0:	<A codegree-[ 1, 1 ]-pure rank 2 left module presented by 3 relations for 4\
##   generators>
##  
##  -1:	<A codegree-1-pure grade 1 left module presented by 4 relations for 3 gene\
##  rators>
##  
##  -2:	<A cyclic reflexively pure grade 2 left module presented by 2 relations fo\
##  r a cyclic generator>
##  
##  -3:	<A cyclic reflexively pure grade 3 left module presented by 3 relations fo\
##  r a cyclic generator>
##  of
##  <A non-pure rank 2 left module presented by 6 relations for 5 generators>>
##  gap> W;
##  <A non-pure rank 2 left module presented by 6 relations for 5 generators>
##  gap> II_E := SpectralSequence( filt );
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
##   s . . .
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
##   s . . .
##   * s . .
##   . * * .
##   . . . *
##  ---------
##  Level 3:
##  
##   s . . .
##   * s . .
##   . . s .
##   . . . *
##  ---------
##  Level 4:
##  
##   s . . .
##   . s . .
##   . . s .
##   . . . s
##  
##  gap> m := IsomorphismOfFiltration( filt );
##  <An isomorphism of left modules>
##  gap> IsIdenticalObj( Range( m ), W );
##  true
##  gap> Source( m );
##  <A left module presented by 12 relations for 9 generators (locked)>
##   gap> Display( last );
##   0,  0,   x, -y,0,1, 0,    0,  0,
##   x*y,-y*z,-z,0, 0,0, 0,    0,  0,
##   x^2,-x*z,0, -z,1,0, 0,    0,  0,
##   0,  0,   0, 0, y,-z,0,    0,  0,
##   0,  0,   0, 0, x,0, -z,   0,  1,
##   0,  0,   0, 0, 0,x, -y,   -1, 0,
##   0,  0,   0, 0, 0,-y,x^2-1,0,  0,
##   0,  0,   0, 0, 0,0, 0,    z,  0,
##   0,  0,   0, 0, 0,0, 0,    y-1,0,
##   0,  0,   0, 0, 0,0, 0,    0,  z,
##   0,  0,   0, 0, 0,0, 0,    0,  y,
##   0,  0,   0, 0, 0,0, 0,    0,  x 
##   
##   Cokernel of the map
##   
##   Q[x,y,z]^(1x12) --> Q[x,y,z]^(1x9),
##   
##   currently represented by the above matrix
##   gap> Display( filt );
##   Degree 0:
##   
##   0,  0,   x, -y,
##   x*y,-y*z,-z,0, 
##   x^2,-x*z,0, -z 
##   
##   Cokernel of the map
##   
##   Q[x,y,z]^(1x3) --> Q[x,y,z]^(1x4),
##   
##   currently represented by the above matrix
##   ----------
##   Degree -1:
##   
##   y,-z,0,   
##   x,0, -z,  
##   0,x, -y,  
##   0,-y,x^2-1
##   
##   Cokernel of the map
##   
##   Q[x,y,z]^(1x4) --> Q[x,y,z]^(1x3),
##   
##   currently represented by the above matrix
##   ----------
##   Degree -2:
##   
##   Q[x,y,z]/< z, y-1 >
##   ----------
##   Degree -3:
##   
##   Q[x,y,z]/< z, y, x >
##   gap> Display( m );
##   1,   0,    0,  0,   0, 
##   0,   -1,   0,  0,   0, 
##   0,   0,    -1, 0,   0, 
##   0,   0,    0,  -1,  0, 
##   -x^2,-x*z, 0,  -z,  0, 
##   0,   0,    x,  -y,  0, 
##   0,   0,    0,  0,   -1,
##   0,   0,    x^2,-x*y,y, 
##   x^3, x^2*z,0,  x*z, -z 
##   
##   the map is currently represented by the above 9 x 5 matrix
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

Read( "ReducedBasisOfModule.g" );

filt := PurityFiltration( W );

II_E := SpectralSequence( filt );

m := IsomorphismOfFiltration( filt );

Display( TimeToString( homalgTime( Qxyz ) ) );
