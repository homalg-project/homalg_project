##  <#GAPDoc Label="HomalgRing:module:example">
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  Z
##  gap> M := ZZ * 4;
##  <A free right module of rank 4 on free generators>
##  gap> R := HomalgRing( M );
##  Z
##  gap> IsIdenticalObj( R, ZZ );
##  true
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "Modules" );

ZZ := HomalgRingOfIntegers( );
M := ZZ * 4;
R := HomalgRing( M );
Assert( 0, IsIdenticalObj( R, ZZ ) );
