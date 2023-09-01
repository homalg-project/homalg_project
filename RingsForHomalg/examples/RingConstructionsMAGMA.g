##  <#GAPDoc Label="MAGMA">
##  <Subsection Label="MAGMA">
##  <Heading>&MAGMA;</Heading>
##  <Example><![CDATA[
##  #@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_MAGMA ).stdout )
##  gap> zz := HomalgRingOfIntegersInMAGMA( );
##  Z
##  gap> Display( zz );
##  <An external ring residing in the CAS MAGMA>
##  gap> F2 := HomalgRingOfIntegersInMAGMA( 2, zz );
##  GF(2)
##  gap> Display( F2 );
##  <An external ring residing in the CAS MAGMA>
##  #@fi
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInMAGMA( 2 )</C> would launch another MAGMA.
##  <Example><![CDATA[
##  #@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_MAGMA ).stdout )
##  gap> Z_4 := HomalgRingOfIntegersInMAGMA( zz ) / 4;
##  Z/( 4 )
##  gap> Display( Z_4 );
##  <A residue class ring>
##  gap> Q := HomalgFieldOfRationalsInMAGMA( zz );
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
##  #@fi
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

Print( "~~~~~~~~~~~\n\n" );
Print( "MAGMA\n\n" );

zz := HomalgRingOfIntegersInMAGMA( );
Display( zz );

F2 := HomalgRingOfIntegersInMAGMA( 2, zz );
Display( F2 );

Z_4 := HomalgRingOfIntegersInMAGMA( zz ) / 4;
Display( Z_4 );

Q := HomalgFieldOfRationalsInMAGMA( zz );
Display( Q );

F2xyz := F2 * "x,y,z";
Display( F2xyz );

Qxyz := Q * "x,y,z";
Display( Qxyz );

Exyz := ExteriorRing( Qxyz, "e,f,g" );
Display( Exyz );
