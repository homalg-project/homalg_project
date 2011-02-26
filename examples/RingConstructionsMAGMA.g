##  <#GAPDoc Label="MAGMA">
##  <Subsection Label="MAGMA">
##  <Heading>&MAGMA;</Heading>
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegersInMAGMA( );
##  <An external ring residing in the CAS MAGMA>
##  gap> Display( ZZ );
##  Z
##  gap> F2 := HomalgRingOfIntegersInMAGMA( 2, ZZ );
##  <An external ring residing in the CAS MAGMA>
##  gap> Display( F2 );
##  GF(2)
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInMAGMA( 2 )</C> would launch another MAGMA.
##  <Example><![CDATA[
##  gap> Z_4 := HomalgRingOfIntegersInMAGMA( ZZ ) / 4;
##  <A residue class ring>
##  gap> Display( Z_4 );
##  Z/( 4 )
##  gap> Q := HomalgFieldOfRationalsInMAGMA( ZZ );
##  <An external ring residing in the CAS MAGMA>
##  gap> Display( Q );
##  Q
##  gap> F2xyz := F2 * "x,y,z";
##  <An external ring residing in the CAS MAGMA>
##  gap> Display( F2xyz );
##  GF(2)[x,y,z]
##  gap> Qxyz := Q * "x,y,z";
##  <An external ring residing in the CAS MAGMA>
##  gap> Display( Qxyz );
##  Q[x,y,z]
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

Print( "~~~~~~~~~~~\n\n" );
Print( "MAGMA\n\n" );

ZZ := HomalgRingOfIntegersInMAGMA( );
Display( ZZ );

F2 := HomalgRingOfIntegersInMAGMA( 2, ZZ );
Display( F2 );

Z_4 := HomalgRingOfIntegersInMAGMA( ZZ ) / 4;
Display( Z_4 );

Q := HomalgFieldOfRationalsInMAGMA( ZZ );
Display( Q );

F2xyz := F2 * "x,y,z";
Display( F2xyz );

Qxyz := Q * "x,y,z";
Display( Qxyz );

