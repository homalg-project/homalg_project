##  <#GAPDoc Label="IsElementOfIntegers:example">
##  <Example><![CDATA[
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> a := HomalgElement( HomalgMap( "[[2]]", 1 * zz, 1 * zz ) );
##  2
##  gap> IsElementOfIntegers( a );
##  true
##  gap> Z4 := zz / 4;
##  Z/( 4 )
##  gap> b := HomalgElement( HomalgMap( "[[-1]]", 1 * Z4, 1 * Z4 ) );
##  |[ 3 ]|
##  gap> IsElementOfIntegers( b );
##  false
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "Modules" );

zz := HomalgRingOfIntegers( );
a := HomalgElement( HomalgMap( "[[2]]", 1 * zz, 1 * zz ) );
Assert( 0, IsElementOfIntegers( a ) = true );

Z4 := zz / 4;
b := HomalgElement( HomalgMap( "[[-1]]", 1 * Z4, 1 * Z4 ) );
Assert( 0, IsElementOfIntegers( b ) = false );
