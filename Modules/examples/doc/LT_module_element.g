##  <#GAPDoc Label="LT:module_element:example">
##  <Example><![CDATA[
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> a := HomalgElement( HomalgMap( "[[2]]", 1 * zz, 1 * zz ) );
##  2
##  gap> a < 6 * a;
##  true
##  gap> F19 := zz / 19;
##  <A residue class ring>
##  gap> b := HomalgElement( HomalgMap( "[[2]]", 1 * F19, 1 * F19 ) );
##  |[ 2 ]|
##  gap> a < 6 * a;
##  false
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "Modules" );

zz := HomalgRingOfIntegers( );
a := HomalgElement( HomalgMap( "[[2]]", 1 * zz, 1 * zz ) );
Assert( 0, IsElementOfIntegers( a ) = true );

F19 := zz / 19;
b := HomalgElement( HomalgMap( "[[2]]", 1 * F19, 1 * F19 ) );
Assert( 0, IsElementOfIntegers( b ) = false );
