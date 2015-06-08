##  <#GAPDoc Label="Macaulay2">
##  <Subsection Label="Macaulay2">
##  <Heading>&Macaulay2;</Heading>
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegersInMacaulay2( );
##  Z
##  gap> Display( ZZ );
##  <An external ring residing in the CAS Macaulay2>
##  gap> F2 := HomalgRingOfIntegersInMacaulay2( 2, ZZ );
##  GF(2)
##  gap> Display( F2 );
##  <An external ring residing in the CAS Macaulay2>
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInMacaulay2( 2 )</C> would launch another Macaulay2.
##  <Example><![CDATA[
##  gap> Z_4 := HomalgRingOfIntegersInMacaulay2( ZZ ) / 4;
##  Z/( 4 )
##  gap> Display( Z_4 );
##  <A residue class ring>
##  gap> Q := HomalgFieldOfRationalsInMacaulay2( ZZ );
##  Q
##  gap> Display( Q );
##  <An external ring residing in the CAS Macaulay2>
##  gap> F2xyz := F2 * "x,y,z";
##  GF(2)[x,y,z]
##  gap> Display( F2xyz );
##  <An external ring residing in the CAS Macaulay2>
##  gap> Qxyz := Q * "x,y,z";
##  Q[x,y,z]
##  gap> Display( Qxyz );
##  <An external ring residing in the CAS Macaulay2>
##  gap> Dxyz := RingOfDerivations( Qxyz, "Dx,Dy,Dz" );
##  Q[x,y,z]<Dx,Dy,Dz>
##  gap> Display( Dxyz );
##  <An external ring residing in the CAS Macaulay2>
##  gap> Exyz := ExteriorRing( Qxyz, "e,f,g" );
##  Q{e,f,g}
##  gap> Display( Exyz );
##  <An external ring residing in the CAS Macaulay2>
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

Dxyz := RingOfDerivations( Qxyz, "Dx,Dy,Dz" );
Display( Dxyz );

Exyz := ExteriorRing( Qxyz, "e,f,g" );
Display( Exyz );
