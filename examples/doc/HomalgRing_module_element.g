##  <#GAPDoc Label="HomalgRing:module_element:example">
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  Z
##  gap> a := HomalgElement( HomalgMap( "[[2]]", 1 * ZZ, 1 * ZZ ) );
##  2
##  IsIdenticalObj( ZZ, HomalgRing( a ) );
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "Modules" );

ZZ := HomalgRingOfIntegers( );
a := HomalgElement( HomalgMap( "[[2]]", 1 * ZZ, 1 * ZZ ) );
Assert( 0, IsIdenticalObj( ZZ, HomalgRing( a ) ) );
