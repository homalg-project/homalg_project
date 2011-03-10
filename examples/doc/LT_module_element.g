##  <#GAPDoc Label="LT:module_element:example">
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <An internal ring>
##  gap> a := HomalgElement( HomalgMap( "[[2]]", 1 * ZZ, 1 * ZZ ) );
##  2
##  gap> a < 6 * a;
##  true
##  gap> F19 := ZZ / 19;
##  <A residue class ring>
##  gap> b := HomalgElement( HomalgMap( "[[2]]", 1 * F19, 1 * F19 ) );
##  |[ 2 ]|
##  gap> a < 6 * a;
##  false
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "Modules" );

ZZ := HomalgRingOfIntegers( );
a := HomalgElement( HomalgMap( "[[2]]", 1 * ZZ, 1 * ZZ ) );
Assert( 0, IsElementOfIntegers( a ) = true );

F19 := ZZ / 19;
b := HomalgElement( HomalgMap( "[[2]]", 1 * F19, 1 * F19 ) );
Assert( 0, IsElementOfIntegers( b ) = false );
