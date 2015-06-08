##  <#GAPDoc Label="ExternalGAP">
##  <Subsection Label="ExternalGAP">
##  <Heading>external &GAP;</Heading>
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegersInExternalGAP( );
##  Z
##  gap> Display( ZZ );
##  <An external ring residing in the CAS GAP>
##  gap> F2 := HomalgRingOfIntegersInExternalGAP( 2, ZZ );
##  GF(2)
##  gap> Display( F2 );
##  <An external ring residing in the CAS GAP>
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInExternalGAP( 2 )</C> would launch another GAP.
##  <Example><![CDATA[
##  gap> Z4 := HomalgRingOfIntegersInExternalGAP( 4, ZZ );
##  Z/4Z
##  gap> Display( Z4 );
##  <An external ring residing in the CAS GAP>
##  gap> Z_4 := HomalgRingOfIntegersInExternalGAP( ZZ ) / 4;
##  Z/( 4 )
##  gap> Display( Z_4 );
##  <A residue class ring>
##  gap> Q := HomalgFieldOfRationalsInExternalGAP( ZZ );
##  Q
##  gap> Display( Q );
##  <An external ring residing in the CAS GAP>
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

Print( "~~~~~~~~~~~\n\n" );
Print( "External GAP\n\n" );

ZZ := HomalgRingOfIntegersInExternalGAP( );
Display( ZZ );

F2 := HomalgRingOfIntegersInExternalGAP( 2, ZZ );
Display( F2 );

Z4 := HomalgRingOfIntegersInExternalGAP( 4, ZZ );
Display( Z4 );

Z_4 := HomalgRingOfIntegersInExternalGAP( ZZ ) / 4;
Display( Z_4 );

Q := HomalgFieldOfRationalsInExternalGAP( ZZ );
Display( Q );

