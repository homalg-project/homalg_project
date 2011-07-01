##  <#GAPDoc Label="Maple">
##  <Subsection Label="Maple">
##  <Heading>&Maple;</Heading>
##  <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegersInMaple( );
##  <An external ring residing in the CAS Maple>
##  gap> Display( ZZ );
##  Z
##  gap> F2 := HomalgRingOfIntegersInMaple( 2, ZZ );
##  <An external ring residing in the CAS Maple>
##  gap> Display( F2 );
##  GF(2)
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInMaple( 2 )</C> would launch another Maple.
##  <Example><![CDATA[
##  gap> Z4 := HomalgRingOfIntegersInMaple( 4, ZZ );
##  <An external ring residing in the CAS Maple>
##  gap> Display( Z4 );
##  Z/4Z
##  gap> Z_4 := HomalgRingOfIntegersInMaple( ZZ ) / 4;
##  <A residue class ring>
##  gap> Display( Z_4 );
##  Z/( 4 )
##  gap> Q := HomalgFieldOfRationalsInMaple( ZZ );
##  <An external ring residing in the CAS Maple>
##  gap> Display( Q );
##  Q
##  gap> F2xyz := F2 * "x,y,z";
##  <An external ring residing in the CAS Maple>
##  gap> Display( F2xyz );
##  GF(2)[x,y,z]
##  gap> Qxyz := Q * "x,y,z";
##  <An external ring residing in the CAS Maple>
##  gap> Display( Qxyz );
##  Q[x,y,z]
##  gap> Dxyz := RingOfDerivations( Qxyz, "Dx,Dy,Dz" );
##  <An external ring residing in the CAS Maple>
##  gap> Display( Dxyz );
##  Q[x,y,z]<Dx,Dy,Dz>
##  gap> Exyz := ExteriorRing( Qxyz, "e,f,g" );
##  <An external ring residing in the CAS Maple>
##  gap> Display( Exyz );
##  Q{e,f,g}
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

Print( "~~~~~~~~~~~\n\n" );
Print( "Maple\n\n" );

ZZ := HomalgRingOfIntegersInMaple( );
Display( ZZ );

F2 := HomalgRingOfIntegersInMaple( 2, ZZ );
Display( F2 );

Z4 := HomalgRingOfIntegersInMaple( 4, ZZ );
Display( Z4 );

Z_4 := HomalgRingOfIntegersInMaple( ZZ ) / 4;
Display( Z_4 );

Q := HomalgFieldOfRationalsInMaple( ZZ );
Display( Q );

F2xyz := F2 * "x,y,z";
Display( F2xyz );

Qxyz := Q * "x,y,z";
Display( Qxyz );

Dxyz := RingOfDerivations( Qxyz, "Dx,Dy,Dz" );
Display( Dxyz );

Exyz := ExteriorRing( Qxyz, "e,f,g" );
Display( Exyz );
