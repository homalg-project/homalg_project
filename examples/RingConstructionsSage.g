##  <#GAPDoc Label="Sage">
##  <Subsection Label="Sage">
##  <Heading>&Sage;</Heading>
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegersInSage( );
##  <An external ring residing in the CAS Sage>
##  gap> Display( ZZ );
##  Z
##  gap> F2 := HomalgRingOfIntegersInSage( 2, ZZ );
##  <An external ring residing in the CAS Sage>
##  gap> Display( F2 );
##  GF(2)
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInSage( 2 )</C> would launch another Sage.
##  <Example><![CDATA[
##  gap> Z_4 := HomalgRingOfIntegersInSage( ZZ ) / 4;
##  <A residue class ring>
##  gap> Display( Z_4 );
##  Z/( 4 )
##  gap> Q := HomalgFieldOfRationalsInSage( ZZ );
##  <An external ring residing in the CAS Sage>
##  gap> Display( Q );
##  Q
##  gap> F2x := F2 * "x";
##  <An external ring residing in the CAS Sage>
##  gap> Display( F2x );
##  GF(2)[x]
##  gap> Qx := Q * "x";
##  <An external ring residing in the CAS Sage>
##  gap> Display( Qx );
##  Q[x]
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

