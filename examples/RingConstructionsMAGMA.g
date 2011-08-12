##  <#GAPDoc Label="MAGMA">
##  <Subsection Label="MAGMA">
##  <Heading>&MAGMA;</Heading>
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegersInMAGMA( );
##  Z
##  gap> Display( ZZ );
##  <An external ring residing in the CAS MAGMA>
##  gap> F2 := HomalgRingOfIntegersInMAGMA( 2, ZZ );
##  GF(2)
##  gap> Display( F2 );
##  <An external ring residing in the CAS MAGMA>
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInMAGMA( 2 )</C> would launch another MAGMA.
##  <Example><![CDATA[
##  gap> Z_4 := HomalgRingOfIntegersInMAGMA( ZZ ) / 4;
##  Z/( 4 )
##  gap> Display( Z_4 );
##  <A residue class ring>
##  gap> Q := HomalgFieldOfRationalsInMAGMA( ZZ );
##  Q
##  gap> Display( Q );
##  <An external ring residing in the CAS MAGMA>
##  gap> F2xyz := F2 * "x,y,z";
##  GF(2)[x,y,z]
##  gap> Display( F2xyz );
##  <An external ring residing in the CAS MAGMA>
##  gap> Qxyz := Q * "x,y,z";
##  Q[x,y,z]
##  gap> Display( Qxyz );
##  <An external ring residing in the CAS MAGMA>
##  gap> Exyz := ExteriorRing( Qxyz, "e,f,g" );
##  Q{e,f,g}
##  gap> Display( Exyz );
##  <An external ring residing in the CAS MAGMA>
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

Exyz := ExteriorRing( Qxyz, "e,f,g" );
Display( Exyz );
