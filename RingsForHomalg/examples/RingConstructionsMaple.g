##  <#GAPDoc Label="Maple">
##  <Subsection Label="Maple">
##  <Heading>&Maple;</Heading>
##  <Example><![CDATA[
##  #@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Maple ).stdout )
##  gap> zz := HomalgRingOfIntegersInMaple( );
##  Z
##  gap> Display( zz );
##  <An external ring residing in the CAS Maple>
##  gap> F2 := HomalgRingOfIntegersInMaple( 2, zz );
##  GF(2)
##  gap> Display( F2 );
##  <An external ring residing in the CAS Maple>
##  #@fi
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInMaple( 2 )</C> would launch another Maple.
##  <Example><![CDATA[
##  #@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Maple ).stdout )
##  gap> Z4 := HomalgRingOfIntegersInMaple( 4, zz );
##  Z/4Z
##  gap> Display( Z4 );
##  <An external ring residing in the CAS Maple>
##  gap> Z_4 := HomalgRingOfIntegersInMaple( zz ) / 4;
##  Z/( 4 )
##  gap> Display( Z_4 );
##  <A residue class ring>
##  gap> Q := HomalgFieldOfRationalsInMaple( zz );
##  Q
##  gap> Display( Q );
##  <An external ring residing in the CAS Maple>
##  gap> F2xyz := F2 * "x,y,z";
##  GF(2)[x,y,z]
##  gap> Display( F2xyz );
##  <An external ring residing in the CAS Maple>
##  gap> Qxyz := Q * "x,y,z";
##  Q[x,y,z]
##  gap> Display( Qxyz );
##  <An external ring residing in the CAS Maple>
##  gap> Dxyz := RingOfDerivations( Qxyz, "Dx,Dy,Dz" );
##  Q[x,y,z]<Dx,Dy,Dz>
##  gap> Display( Dxyz );
##  <An external ring residing in the CAS Maple>
##  gap> Exyz := ExteriorRing( Qxyz, "e,f,g" );
##  Q{e,f,g}
##  gap> Display( Exyz );
##  <An external ring residing in the CAS Maple>
##  #@fi
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

Print( "~~~~~~~~~~~\n\n" );
Print( "Maple\n\n" );

zz := HomalgRingOfIntegersInMaple( );
Display( zz );

F2 := HomalgRingOfIntegersInMaple( 2, zz );
Display( F2 );

Z4 := HomalgRingOfIntegersInMaple( 4, zz );
Display( Z4 );

Z_4 := HomalgRingOfIntegersInMaple( zz ) / 4;
Display( Z_4 );

Q := HomalgFieldOfRationalsInMaple( zz );
Display( Q );

F2xyz := F2 * "x,y,z";
Display( F2xyz );

Qxyz := Q * "x,y,z";
Display( Qxyz );

Dxyz := RingOfDerivations( Qxyz, "Dx,Dy,Dz" );
Display( Dxyz );

Exyz := ExteriorRing( Qxyz, "e,f,g" );
Display( Exyz );
