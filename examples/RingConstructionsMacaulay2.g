##  <#GAPDoc Label="Macaulay2">
##  <Subsection Label="Macaulay2">
##  <Heading>&Macaulay2;</Heading>
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegersInMacaulay2( );
##  <An external ring residing in the CAS Macaulay2>
##  gap> Display( ZZ );
##  Z
##  gap> F2 := HomalgRingOfIntegersInMacaulay2( 2, ZZ );
##  <An external ring residing in the CAS Macaulay2>
##  gap> Display( F2 );
##  GF(2)
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInMacaulay2( 2 )</C> would launch another Macaulay2.
##  <Example><![CDATA[
##  gap> Z_4 := HomalgRingOfIntegersInMacaulay2( ZZ ) / 4;
##  <A residue class ring>
##  gap> Display( Z_4 );
##  Z/( 4 )
##  gap> Q := HomalgFieldOfRationalsInMacaulay2( ZZ );
##  <An external ring residing in the CAS Macaulay2>
##  gap> Display( Q );
##  Q
##  gap> F2xyz := F2 * "x,y,z";
##  <An external ring residing in the CAS Macaulay2>
##  gap> Display( F2xyz );
##  GF(2)[x,y,z]
##  gap> Qxyz := Q * "x,y,z";
##  <An external ring residing in the CAS Macaulay2>
##  gap> Display( Qxyz );
##  Q[x,y,z]
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

Print( "~~~~~~~~~~~\n\n" );
Print( "Macaulay2\n\n" );

ZZ := HomalgRingOfIntegersInMacaulay2( );
Display( ZZ );

F2 := HomalgRingOfIntegersInMacaulay2( 2, ZZ );
Display( F2 );

Z_4 := HomalgRingOfIntegersInMacaulay2( ZZ ) / 4;
Display( Z_4 );

Q := HomalgFieldOfRationalsInMacaulay2( ZZ );
Display( Q );

F2xyz := F2 * "x,y,z";
Display( F2xyz );

Qxyz := Q * "x,y,z";
Display( Qxyz );

