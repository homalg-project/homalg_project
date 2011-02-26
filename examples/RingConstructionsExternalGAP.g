##  <#GAPDoc Label="ExternalGAP">
##  <Subsection Label="ExternalGAP">
##  <Heading>external &GAP;</Heading>
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegersInExternalGAP( );
##  <An external ring residing in the CAS GAP>
##  gap> Display( ZZ );
##  Z
##  gap> F2 := HomalgRingOfIntegersInExternalGAP( 2, ZZ );
##  <An external ring residing in the CAS GAP>
##  gap> Display( F2 );
##  GF(2)
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInExternalGAP( 2 )</C> would launch another GAP.
##  <Example><![CDATA[
##  gap> Z4 := HomalgRingOfIntegersInExternalGAP( 4, ZZ );
##  <An external ring residing in the CAS GAP>
##  gap> Display( Z4 );
##  Z/4Z
##  gap> Z_4 := HomalgRingOfIntegersInExternalGAP( ZZ ) / 4;
##  <A residue class ring>
##  gap> Display( Z_4 );
##  Z/( 4 )
##  gap> Q := HomalgFieldOfRationalsInExternalGAP( ZZ );
##  <An external ring residing in the CAS GAP>
##  gap> Display( Q );
##  Q
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

