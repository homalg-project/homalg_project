##  <#GAPDoc Label="RHom_Z">
##    <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> m := HomalgMatrix( [ [ 8, 0 ], [ 0, 2 ] ], ZZ );;
##  gap> M := LeftPresentation( m );
##  <A left module presented by 2 relations for 2 generators>
##  gap> Display( M );
##  Z/< 8 > + Z/< 2 >
##  gap> a := HomalgMatrix( [ [ 2, 0 ] ], ZZ );;
##  gap> alpha := HomalgMap( a, "free", M );
##  <A homomorphism of left modules>
##  gap> pi := CokernelEpi( alpha );
##  <An epimorphism of left modules>
##  gap> Display( pi );
##  [ [  1,  0 ],
##    [  0,  1 ] ]
##  
##  the map is currently represented by the above 2 x 2 matrix
##  gap> iota := KernelEmb( pi );
##  <A monomorphism of left modules>
##  gap> Display( iota );
##  [ [  2,  0 ] ]
##  
##  the map is currently represented by the above 1 x 2 matrix
##  gap> N := Kernel( pi );
##  <A cyclic left module presented by 1 relation for a cyclic generator>
##  gap> Display( N );
##  Z/< 4 >
##  gap> C := HomalgComplex( pi );
##  <A left acyclic complex containing a single morphism of left modules at degree\
##  s [ 0 .. 1 ]>
##  gap> Add( C, iota );
##  gap> ByASmallerPresentation( C );
##  <A non-zero short exact sequence containing
##  2 morphisms of left modules at degrees [ 0 .. 2 ]>
##  gap> Display( C );
##  -------------------------
##  at homology degree: 2
##  Z/< 4 >
##  -------------------------
##  [ [  0,  6 ] ]
##  
##  the map is currently represented by the above 1 x 2 matrix
##  ------------v------------
##  at homology degree: 1
##  Z/< 2 > + Z/< 8 >
##  -------------------------
##  [ [  0,  1 ],
##    [  1,  1 ] ]
##  
##  the map is currently represented by the above 2 x 2 matrix
##  ------------v------------
##  at homology degree: 0
##  Z/< 2 > + Z/< 2 >
##  -------------------------
##  gap> T := RHom( C, N );
##  <An exact cotriangle containing 3 morphisms of right cocomplexes at degrees
##  [ 0, 1, 2, 0 ]>
##  gap> ByASmallerPresentation( T );
##  <A non-zero exact cotriangle containing
##  3 morphisms of right cocomplexes at degrees [ 0, 1, 2, 0 ]>
##  gap> L := LongSequence( T );
##  <A cosequence containing 5 morphisms of right modules at degrees [ 0 .. 5 ]>
##  gap> Display( L );
##  -------------------------
##  at cohomology degree: 5
##  Z/< 4 >
##  ------------^------------
##  [ [  0,  3 ] ]
##  
##  the map is currently represented by the above 1 x 2 matrix
##  -------------------------
##  at cohomology degree: 4
##  Z/< 2 > + Z/< 4 >
##  ------------^------------
##  [ [  0,  1 ],
##    [  0,  0 ] ]
##  
##  the map is currently represented by the above 2 x 2 matrix
##  -------------------------
##  at cohomology degree: 3
##  Z/< 2 > + Z/< 2 >
##  ------------^------------
##  [ [  1 ],
##    [  0 ] ]
##  
##  the map is currently represented by the above 2 x 1 matrix
##  -------------------------
##  at cohomology degree: 2
##  Z/< 4 >
##  ------------^------------
##  [ [  0,  2 ] ]
##  
##  the map is currently represented by the above 1 x 2 matrix
##  -------------------------
##  at cohomology degree: 1
##  Z/< 2 > + Z/< 4 >
##  ------------^------------
##  [ [  0,  1 ],
##    [  2,  0 ] ]
##  
##  the map is currently represented by the above 2 x 2 matrix
##  -------------------------
##  at cohomology degree: 0
##  Z/< 2 > + Z/< 2 >
##  -------------------------
##  gap> IsExactSequence( L );
##  true
##  gap> L;
##  <An exact cosequence containing 5 morphisms of right modules at degrees
##  [ 0 .. 5 ]>
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "homalg" );
ZZ := HomalgRingOfIntegers( );
m := HomalgMatrix( [ [ 8, 0 ], [ 0, 2 ] ], ZZ );
M := LeftPresentation( m );
a := HomalgMatrix( [ [ 2, 0 ] ], ZZ );
alpha := HomalgMap( a, "free", M );
pi := CokernelEpi( alpha );
iota := KernelEmb( pi );
N := Kernel( pi );
C := HomalgComplex( pi );
Add( C, iota );
ByASmallerPresentation( C );
T := RHom( C, N );
ByASmallerPresentation( T );
L := LongSequence( T );
IsExactSequence( L );
