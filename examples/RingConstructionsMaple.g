##  <#GAPDoc Label="Maple">
##  <Subsection Label="Maple">
##  <Heading>&Maple;</Heading>
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegersInMaple( );
##  <A homalg external ring residing in the CAS Maple>
##   gap> Display( ZZ );
##   Z
##  gap> F2 := HomalgRingOfIntegersInMaple( 2, ZZ );
##  <A homalg external ring residing in the CAS Maple>
##   gap> Display( F2 );
##   GF(2)
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInMaple( 2 )</C> would launch another Maple.
##  <Example><![CDATA[
##  gap> Z4 := HomalgRingOfIntegersInMaple( 4, ZZ );
##  <A homalg external ring residing in the CAS Maple>
##   gap> Display( Z4 );
##   Z/4Z
##  gap> Z_4 := HomalgRingOfIntegersInMaple( ZZ ) / 4;
##  <A homalg residue class ring>
##  gap> Display( Z_4 );
##  Z/( 4 )
##  gap> Q := HomalgFieldOfRationalsInMaple( ZZ );
##  <A homalg external ring residing in the CAS Maple>
##   gap> Display( Q );
##   Q
##  gap> F2xyz := F2 * "x,y,z";
##  <A homalg external ring residing in the CAS Maple>
##   gap> Display( F2xyz );
##   GF(2)[x,y,z]
##  gap> Qxyz := Q * "x,y,z";
##  <A homalg external ring residing in the CAS Maple>
##   gap> Display( Qxyz );
##   Q[x,y,z]
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

Print( "~~~~~~~~~~~\n\n" );
Print( "Maple\n\n" );

ZZ := HomalgRingOfIntegersInMaple( );
Display( ZZ );

F2 := HomalgRingOfIntegersInMaple( 2, ZZ );
Display( F2 );

Z4 := HomalgRingOfIntegersInMaple( 4, ZZ );
Display( Z4 );

Z_4 := HomalgRingOfIntegersInMaple( ZZ ) / 4;
Display( Z_4 );

Q := HomalgFieldOfRationalsInMaple( ZZ );
Display( Q );

F2xyz := F2 * "x,y,z";
Display( F2xyz );

Qxyz := Q * "x,y,z";
Display( Qxyz );

