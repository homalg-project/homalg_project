##  <#GAPDoc Label="HomalgRing:module_element:example">
##  <Example><![CDATA[
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> a := HomalgElement( HomalgMap( "[[2]]", 1 * zz, 1 * zz ) );
##  2
##  gap> IsIdenticalObj( zz, HomalgRing( a ) );
##  true
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "Modules" );

zz := HomalgRingOfIntegers( );
a := HomalgElement( HomalgMap( "[[2]]", 1 * zz, 1 * zz ) );
Assert( 0, IsIdenticalObj( zz, HomalgRing( a ) ) );
