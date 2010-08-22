##  <#GAPDoc Label="HomHom">
##  <Subsection Label="HomHom">
##  <Heading>HomHom</Heading>
##  The following example is taken from Section 2 of <Cite Key="BREACA"/>. <Br/><Br/>
##  The computation takes place over the residue class ring <M>R=&ZZ;/2^8&ZZ;</M>
##  using the generic support for residue class rings provided by
##  the subpackage &ResidueClassRingForHomalg; of the &MatricesForHomalg; package.
##  For a native support of the rings <M>R=&ZZ;/p^n&ZZ;</M> use the &GaussForHomalg; package. <P/>
##  Here we compute the (infinite) long exact homology sequence of the
##  covariant functor <M>Hom(Hom(-,&ZZ;/2^7&ZZ;),&ZZ;/2^4&ZZ;)</M> (and its left derived functors)
##  applied to the short exact sequence<Br/><Br/>
##  <Alt Not="Text,HTML"><Math>0 \longrightarrow M\_=&ZZ;/2^2&ZZ; \stackrel{\alpha_1}{\longrightarrow}
##  M=&ZZ;/2^5&ZZ; \stackrel{\alpha_2}{\longrightarrow} \_M=&ZZ;/2^3&ZZ; \longrightarrow 0</Math></Alt>
##  <Alt Only="Text,HTML"><M>0 -> M_=&ZZ;/2^2&ZZ; --alpha_1--> M=&ZZ;/2^5&ZZ; --alpha_2--> \_M=&ZZ;/2^3&ZZ; -> 0</M></Alt>.
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <A homalg internal ring>
##  gap> Display( ZZ );
##  Z
##  gap> R := ZZ / 2^8;
##  <A homalg residue class ring>
##  gap> Display( R );
##  Z/( 256 )
##  gap> M := LeftPresentation( [ 2^5 ], R );
##  <A cyclic left module presented by 1 relation for a cyclic generator>
##  gap> Display( M );
##  Z/( 256 )/< |[ 32 ]| >
##  gap> _M := LeftPresentation( [ 2^3 ], R );
##  <A cyclic left module presented by 1 relation for a cyclic generator>
##  gap> Display( _M );
##  Z/( 256 )/< |[ 8 ]| >
##  gap> alpha2 := HomalgMap( [ 1 ], M, _M );
##  <A "homomorphism" of left modules>
##  gap> IsMorphism( alpha2 );
##  true
##  gap> alpha2;
##  <A homomorphism of left modules>
##  gap> Display( alpha2 );
##  [ [  1 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  gap> M_ := Kernel( alpha2 );
##  <A cyclic left module presented by yet unknown relations for a cyclic generato\
##  r>
##  gap> alpha1 := KernelEmb( alpha2 );
##  <A monomorphism of left modules>
##  gap> seq := HomalgComplex( alpha2 );
##  <An acyclic complex containing a single morphism of left modules at degrees 
##  [ 0 .. 1 ]>
##  gap> Add( seq, alpha1 );
##  gap> seq;
##  <A sequence containing 2 morphisms of left modules at degrees [ 0 .. 2 ]>
##  gap> IsShortExactSequence( seq );
##  true
##  gap> seq;
##  <A short exact sequence containing 2 morphisms of left modules at degrees 
##  [ 0 .. 2 ]>
##  gap> Display( seq );
##  -------------------------
##  at homology degree: 2
##  Z/( 256 )/< |[ 4 ]| > 
##  -------------------------
##  [ [  24 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 1
##  Z/( 256 )/< |[ 32 ]| > 
##  -------------------------
##  [ [  1 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 0
##  Z/( 256 )/< |[ 8 ]| > 
##  -------------------------
##  gap> K := LeftPresentation( [ 2^7 ], R );
##  <A cyclic left module presented by 1 relation for a cyclic generator>
##  gap> L := RightPresentation( [ 2^4 ], R );
##  <A cyclic right module on a cyclic generator satisfying 1 relation>
##  gap> triangle := LHomHom( 4, seq, K, L, "t" );
##  <An exact triangle containing 3 morphisms of left complexes at degrees 
##  [ 1, 2, 3, 1 ]>
##  gap> lehs := LongSequence( triangle );
##  <A sequence containing 14 morphisms of left modules at degrees [ 0 .. 14 ]>
##  gap> ByASmallerPresentation( lehs );
##  <A non-zero sequence containing 14 morphisms of left modules at degrees 
##  [ 0 .. 14 ]>
##  gap> IsExactSequence( lehs );
##  false
##  gap> lehs;
##  <A non-zero left acyclic complex containing 
##  14 morphisms of left modules at degrees [ 0 .. 14 ]>
##  gap> Assert( 0, IsLeftAcyclic( lehs ) );
##  gap> Display( lehs );
##  -------------------------
##  at homology degree: 14
##  Z/( 256 )/< |[ 4 ]| > 
##  -------------------------
##  [ [  4 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 13
##  Z/( 256 )/< |[ 8 ]| > 
##  -------------------------
##  [ [  2 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 12
##  Z/( 256 )/< |[ 8 ]| >
##  -------------------------
##  [ [  2 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 11
##  Z/( 256 )/< |[ 4 ]| >
##  -------------------------
##  [ [  4 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 10
##  Z/( 256 )/< |[ 8 ]| >
##  -------------------------
##  [ [  2 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 9
##  Z/( 256 )/< |[ 8 ]| >
##  -------------------------
##  [ [  2 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 8
##  Z/( 256 )/< |[ 4 ]| >
##  -------------------------
##  [ [  4 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 7
##  Z/( 256 )/< |[ 8 ]| >
##  -------------------------
##  [ [  2 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 6
##  Z/( 256 )/< |[ 8 ]| >
##  -------------------------
##  [ [  2 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 5
##  Z/( 256 )/< |[ 4 ]| >
##  -------------------------
##  [ [  4 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 4
##  Z/( 256 )/< |[ 8 ]| >
##  -------------------------
##  [ [  2 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 3
##  Z/( 256 )/< |[ 8 ]| >
##  -------------------------
##  [ [  2 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 2
##  Z/( 256 )/< |[ 4 ]| >
##  -------------------------
##  [ [  8 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 1
##  Z/( 256 )/< |[ 16 ]| >
##  -------------------------
##  [ [  1 ] ]
##  
##  modulo [ 256 ]
##  
##  the map is currently represented by the above 1 x 1 matrix
##  ------------v------------
##  at homology degree: 0
##  Z/( 256 )/< |[ 8 ]| >
##  -------------------------
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "Modules" );

ZZ := HomalgRingOfIntegers( );
R := ZZ / 2^8;

M := LeftPresentation( [ 2^5 ], R );
_M := LeftPresentation( [ 2^3 ], R );
alpha2 := HomalgMap( [ 1 ], M, _M );
M_ := Kernel( alpha2 );
alpha1 := KernelEmb( alpha2 );
seq := HomalgComplex( alpha2 );
Add( seq, alpha1 );
IsShortExactSequence( seq );
K := LeftPresentation( [ 2^7 ], R );
L := RightPresentation( [ 2^4 ], R );

triangle := LHomHom( 4, seq, K, L, "t" );
lehs := LongSequence( triangle );
ByASmallerPresentation( lehs );

IsExactSequence( lehs );

Assert( 0, IsLeftAcyclic( lehs ) );
