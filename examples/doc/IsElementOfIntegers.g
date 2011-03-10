##  <#GAPDoc Label="IsElementOfIntegers:example">
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <An internal ring>
##  gap> a := HomalgElement( HomalgMap( "[[2]]", 1 * ZZ, 1 * ZZ ) );
##  2
##  gap> IsElementOfIntegers( a );
##  true
##  gap> Z4 := ZZ / 4;
##  <A residue class ring>
##  gap> b := HomalgElement( HomalgMap( "[[2]]", 1 * Z4, 1 * Z4 ) );
##  |[ 2 ]|
##  gap> IsElementOfIntegers( b );
##  false
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "Modules" );

ZZ := HomalgRingOfIntegers( );
a := HomalgElement( HomalgMap( "[[2]]", 1 * ZZ, 1 * ZZ ) );
Assert( 0, IsElementOfIntegers( a ) = true );

Z4 := ZZ / 4;
b := HomalgElement( HomalgMap( "[[2]]", 1 * Z4, 1 * Z4 ) );
Assert( 0, IsElementOfIntegers( b ) = false );
