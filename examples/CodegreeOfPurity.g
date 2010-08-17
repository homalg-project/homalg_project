##  <#GAPDoc Label="CodegreeOfPurity">
##  <Subsection Label="CodegreeOfPurity">
##  <Heading>CodegreeOfPurity</Heading>
##  This is Example B.7 in <Cite Key="BaSF"/>.
##  <Example><![CDATA[
##  gap> Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> vmat := HomalgMatrix( "[ \
##  > 0,  0,  x,-z, \
##  > x*z,z^2,y,0,  \
##  > x^2,x*z,0,y   \
##  > ]", 3, 4, Qxyz );
##  <A homalg external 3 by 4 matrix>
##  gap> V := LeftPresentation( vmat );
##  <A non-torsion left module presented by 3 relations for 4 generators>
##  gap> wmat := HomalgMatrix( "[ \
##  > 0,  0,  x,-y, \
##  > x*y,y*z,z,0,  \
##  > x^2,x*z,0,z   \
##  > ]", 3, 4, Qxyz );
##  <A homalg external 3 by 4 matrix>
##  gap> W := LeftPresentation( wmat );
##  <A non-torsion left module presented by 3 relations for 4 generators>
##  gap> Rank( V );
##  2
##  gap> Rank( W );
##  2
##  gap> ProjectiveDimension( V );
##  2
##  gap> ProjectiveDimension( W );
##  2
##  gap> DegreeOfTorsionFreeness( V );
##  1
##  gap> DegreeOfTorsionFreeness( W );
##  1
##  gap> CodegreeOfPurity( V );
##  [ 2 ]
##  gap> CodegreeOfPurity( W );
##  [ 1, 1 ]
##  gap> filtV := PurityFiltration( V );
##  <The ascending purity filtration with degrees [ -2 .. 0 ] and graded parts:
##     0:	<A codegree-[ 2 ]-pure rank 2 left module presented by 3 relations for 
##  4 generators>
##    -1:	<A zero left module>
##    -2:	<A zero left module>
##  of
##  <A codegree-[ 2 ]-pure rank 2 left module presented by 3 relations for 
##  4 generators>>
##  gap> filtW := PurityFiltration( W );
##  <The ascending purity filtration with degrees [ -2 .. 0 ] and graded parts:
##     0:	<A codegree-[ 1, 1 ]-pure rank 2 left module presented by 
##  3 relations for 4 generators>
##    -1:	<A zero left module>
##    -2:	<A zero left module>
##  of
##  <A codegree-[ 1, 1 ]-pure rank 2 left module presented by 3 relations for 
##  4 generators>>
##  gap> II_EV := SpectralSequence( filtV );
##  <A stable homological spectral sequence with sheets at levels 
##  [ 0 .. 4 ] each consisting of left modules at bidegrees [ -3 .. 0 ]x
##  [ 0 .. 2 ]>
##  gap> Display( II_EV );
##  The associated transposed spectral sequence:
##  
##  a homological spectral sequence at bidegrees
##  [ [ 0 .. 2 ], [ -3 .. 0 ] ]
##  ---------
##  Level 0:
##  
##   * * *
##   * * *
##   * * *
##   . * *
##  ---------
##  Level 1:
##  
##   * * *
##   . . .
##   . . .
##   . . .
##  ---------
##  Level 2:
##  
##   s . .
##   . . .
##   . . .
##   . . .
##  
##  Now the spectral sequence of the bicomplex:
##  
##  a homological spectral sequence at bidegrees
##  [ [ -3 .. 0 ], [ 0 .. 2 ] ]
##  ---------
##  Level 0:
##  
##   * * * *
##   * * * *
##   . * * *
##  ---------
##  Level 1:
##  
##   * * * *
##   * * * *
##   . . * *
##  ---------
##  Level 2:
##  
##   * . . .
##   * . . .
##   . . * *
##  ---------
##  Level 3:
##  
##   * . . .
##   . . . .
##   . . . *
##  ---------
##  Level 4:
##  
##   . . . .
##   . . . .
##   . . . s
##  gap> II_EW := SpectralSequence( filtW );
##  <A stable homological spectral sequence with sheets at levels 
##  [ 0 .. 4 ] each consisting of left modules at bidegrees [ -3 .. 0 ]x
##  [ 0 .. 2 ]>
##  gap> Display( II_EW );                  
##  The associated transposed spectral sequence:
##  
##  a homological spectral sequence at bidegrees
##  [ [ 0 .. 2 ], [ -3 .. 0 ] ]
##  ---------
##  Level 0:
##  
##   * * *
##   * * *
##   . * *
##   . . *
##  ---------
##  Level 1:
##  
##   * * *
##   . . .
##   . . .
##   . . .
##  ---------
##  Level 2:
##  
##   s . .
##   . . .
##   . . .
##   . . .
##  
##  Now the spectral sequence of the bicomplex:
##  
##  a homological spectral sequence at bidegrees
##  [ [ -3 .. 0 ], [ 0 .. 2 ] ]
##  ---------
##  Level 0:
##  
##   * * * *
##   . * * *
##   . . * *
##  ---------
##  Level 1:
##  
##   * * * *
##   . * * *
##   . . . *
##  ---------
##  Level 2:
##  
##   * . . .
##   . * . .
##   . . . *
##  ---------
##  Level 3:
##  
##   * . . .
##   . . . .
##   . . . *
##  ---------
##  Level 4:
##  
##   . . . .
##   . . . .
##   . . . s
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "GradedModules" );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

Exyz := KoszulDualRing( Qxyz, "a,b,c" );

vmat := HomalgMatrix( "[ \
x,z,0,1, 0,  \
0,0,y,-z,0,  \
0,0,x,0, -z, \
0,0,0,x, -y  \
]", 4, 5, Qxyz );

V := LeftPresentation( vmat );

wmat := HomalgMatrix( "[ \
x,z,1,0, 0,  \
0,0,y,-z,0,  \
0,0,x,0, -z, \
0,0,0,x, -y  \
]", 4, 5, Qxyz );

W := LeftPresentation( wmat );

mmat := HomalgMatrix( "[ \
x,z,z,y, x,  \
0,0,-y,z,0,  \
0,0,x,0, -z, \
0,0,0,x, -y  \
]", 4, 5, Qxyz );

M := LeftPresentationWithDegrees( mmat );

TM := TateResolution( M, -5, 5 );

bettiM := BettiDiagram( TM );

nmat := HomalgMatrix( "[ \
x,z,z,0, x,  \
0,0,-y,z,0,  \
0,0,x,0, -z, \
0,0,0,x, -y  \
]", 4, 5, Qxyz );

N := LeftPresentationWithDegrees( nmat );

TN := TateResolution( N, -5, 5 );

bettiN := BettiDiagram( TN );

lmat := HomalgMatrix( "[ \
x,z,0,0, \
0,x,z,0, \
0,y,0,z, \
0,0,y,-x \
]", 4, 4, Qxyz );

L := LeftPresentationWithDegrees( lmat );

TL := TateResolution( L, -5, 5 );

bettiL := BettiDiagram( TL );

