##  <#GAPDoc Label="Sage">
##  <Subsection Label="Sage">
##  <Heading>&Sage;</Heading>
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegersInSage( );
##  Z
##  gap> Display( ZZ );
##  <An external ring residing in the CAS Sage>
##  gap> F2 := HomalgRingOfIntegersInSage( 2, ZZ );
##  GF(2)
##  gap> Display( F2 );
##  <An external ring residing in the CAS Sage>
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInSage( 2 )</C> would launch another Sage.
##  <Example><![CDATA[
##  gap> Z_4 := HomalgRingOfIntegersInSage( ZZ ) / 4;
##  Z/( 4 )
##  gap> Display( Z_4 );
##  <A residue class ring>
##  gap> Q := HomalgFieldOfRationalsInSage( ZZ );
##  Q
##  gap> Display( Q );
##  <An external ring residing in the CAS Sage>
##  gap> F2x := F2 * "x";
##  GF(2)[x]
##  gap> Display( F2x );
##  <An external ring residing in the CAS Sage>
##  gap> Qx := Q * "x";
##  Q[x]
##  gap> Display( Qx );
##  <An external ring residing in the CAS Sage>
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

Print( "~~~~~~~~~~~\n\n" );
Print( "Sage\n\n" );

ZZ := HomalgRingOfIntegersInSage( );
Display( ZZ );

F2 := HomalgRingOfIntegersInSage( 2, ZZ );
Display( F2 );

Z_4 := HomalgRingOfIntegersInSage( ZZ ) / 4;
Display( Z_4 );

Q := HomalgFieldOfRationalsInSage( ZZ );
Display( Q );

F2x := F2 * "x";
Display( F2x );

Qx := Q * "x";
Display( Qx );

