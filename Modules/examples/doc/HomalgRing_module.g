##  <#GAPDoc Label="HomalgRing:module:example">
##  <Example><![CDATA[
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> M := zz * 4;
##  <A free right module of rank 4 on free generators>
##  gap> R := HomalgRing( M );
##  Z
##  gap> IsIdenticalObj( R, zz );
##  true
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "Modules" );

zz := HomalgRingOfIntegers( );
M := zz * 4;
R := HomalgRing( M );
Assert( 0, IsIdenticalObj( R, zz ) );
