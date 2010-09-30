##  <#GAPDoc Label="Singular">
##  <Subsection Label="Singular">
##  <Heading>&Singular;</Heading>
##  <Example><![CDATA[
##  gap> F2 := HomalgRingOfIntegersInSingular( 2 );
##  <An external ring residing in the CAS Singular>
##   gap> Display( F2 );
##   GF(2)
##  gap> Q := HomalgFieldOfRationalsInSingular( F2 );
##  <An external ring residing in the CAS Singular>
##   gap> Display( Q );
##   Q
##  ]]></Example>
##  <C>Q := HomalgFieldOfRationalsInSingular( )</C> would launch another Singular.
##  <Example><![CDATA[
##  gap> F2xyz := F2 * "x,y,z";
##  <An external ring residing in the CAS Singular>
##   gap> Display( F2xyz );
##   GF(2)[x,y,z]
##  gap> Qxyz := Q * "x,y,z";
##  <An external ring residing in the CAS Singular>
##   gap> Display( Qxyz );
##   Q[x,y,z]
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

Print( "~~~~~~~~~~~\n\n" );
Print( "Singular\n\n" );

F2 := HomalgRingOfIntegersInSingular( 2 );
Display( F2 );

Q := HomalgFieldOfRationalsInSingular( F2 );
Display( Q );

F2xyz := F2 * "x,y,z";
Display( F2xyz );

Qxyz := Q * "x,y,z";
Display( Qxyz );

