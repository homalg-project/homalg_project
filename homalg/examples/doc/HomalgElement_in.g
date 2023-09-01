##  <#GAPDoc Label="HomalgElement_in:example">
##  <Example><![CDATA[
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> M := 2 * zz;
##  <A free left module of rank 2 on free generators>
##  gap> a := HomalgModuleElement( "[ 6, 0 ]", M );
##  ( 6, 0 )
##  gap> N := Subobject( HomalgMap( "[ 2, 0 ]", 1 * zz, M ) );
##  <A free left submodule given by a cyclic generator>
##  gap> K := Subobject( HomalgMap( "[ 4, 0 ]", 1 * zz, M ) );
##  <A free left submodule given by a cyclic generator>
##  gap> a in M;
##  true
##  gap> a in N;
##  true
##  gap> a in UnderlyingObject( N );
##  true
##  gap> a in K;
##  false
##  gap> a in UnderlyingObject( K );
##  false
##  gap> a in 3 * zz;
##  false 
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "Modules" );

zz := HomalgRingOfIntegers( );
M := 2 * zz;
a := HomalgModuleElement( "[ 6, 0 ]", M );
N := Subobject( HomalgMap( "[ 2, 0 ]", 1 * zz, M ) );
L := Subobject( HomalgMap( "[ 3, 0 ]", 1 * zz, M ) );
K := Subobject( HomalgMap( "[ 4, 0 ]", 1 * zz, M ) );

Assert( 0, a in M );
Assert( 0, a in N );
Assert( 0, a in UnderlyingObject( N ) );
Assert( 0, a in L );
Assert( 0, a in UnderlyingObject( L ) );
Assert( 0, not a in K );
Assert( 0, not a in UnderlyingObject( K ) );
Assert( 0, not a in 3 * zz );
