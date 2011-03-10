##  <#GAPDoc Label="HomalgRing:module:example">
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <An internal ring>
##  gap> M := ZZ * 4;
##  <A free right module of rank 4 on free generators>
##  gap> R := HomalgRing( M );
##  <An internal ring>
##  gap> IsIdenticalObj( R, ZZ );
##  true
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "Modules" );

ZZ := HomalgRingOfIntegers( );
M := ZZ * 4;
R := HomalgRing( M );
Assert( 0, IsIdenticalObj( R, ZZ ) );
