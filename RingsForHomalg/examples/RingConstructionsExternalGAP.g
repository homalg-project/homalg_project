##  <#GAPDoc Label="ExternalGAP">
##  <Subsection Label="ExternalGAP">
##  <Heading>external &GAP;</Heading>
##  <Example><![CDATA[
##  gap> zz := HomalgRingOfIntegersInExternalGAP( );
##  Z
##  gap> Display( zz );
##  <An external ring residing in the CAS GAP>
##  gap> F2 := HomalgRingOfIntegersInExternalGAP( 2, zz );
##  GF(2)
##  gap> Display( F2 );
##  <An external ring residing in the CAS GAP>
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInExternalGAP( 2 )</C> would launch another GAP.
##  <Example><![CDATA[
##  gap> Z4 := HomalgRingOfIntegersInExternalGAP( 4, zz );
##  Z/4Z
##  gap> Display( Z4 );
##  <An external ring residing in the CAS GAP>
##  gap> Z_4 := HomalgRingOfIntegersInExternalGAP( zz ) / 4;
##  Z/( 4 )
##  gap> Display( Z_4 );
##  <A residue class ring>
##  gap> Q := HomalgFieldOfRationalsInExternalGAP( zz );
##  Q
##  gap> Display( Q );
##  <An external ring residing in the CAS GAP>
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

Print( "~~~~~~~~~~~\n\n" );
Print( "External GAP\n\n" );

zz := HomalgRingOfIntegersInExternalGAP( );
Display( zz );

F2 := HomalgRingOfIntegersInExternalGAP( 2, zz );
Display( F2 );

Z4 := HomalgRingOfIntegersInExternalGAP( 4, zz );
Display( Z4 );

Z_4 := HomalgRingOfIntegersInExternalGAP( zz ) / 4;
Display( Z_4 );

Q := HomalgFieldOfRationalsInExternalGAP( zz );
Display( Q );

