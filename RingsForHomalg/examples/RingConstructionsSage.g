##  <#GAPDoc Label="Sage">
##  <Subsection Label="Sage">
##  <Heading>&Sage;</Heading>
##  <Example><![CDATA[
##  #@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Sage ).stdout )
##  gap> zz := HomalgRingOfIntegersInSage( );
##  Z
##  gap> Display( zz );
##  <An external ring residing in the CAS Sage>
##  gap> F2 := HomalgRingOfIntegersInSage( 2, zz );
##  GF(2)
##  gap> Display( F2 );
##  <An external ring residing in the CAS Sage>
##  #@fi
##  ]]></Example>
##  <C>F2 := HomalgRingOfIntegersInSage( 2 )</C> would launch another Sage.
##  <Example><![CDATA[
##  #@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Sage ).stdout )
##  gap> Z_4 := HomalgRingOfIntegersInSage( zz ) / 4;
##  Z/( 4 )
##  gap> Display( Z_4 );
##  <A residue class ring>
##  gap> Q := HomalgFieldOfRationalsInSage( zz );
##  Q
##  gap> Display( Q );
##  <An external ring residing in the CAS Sage>
##  gap> F2x := F2 * "x";
##  GF(2)[x]
##  gap> Display( F2x );
##  <An external ring residing in the CAS Sage>
##  gap> Qx := Q * "x";
##  Q[x]
##  gap> Display( Qx );
##  <An external ring residing in the CAS Sage>
##  #@fi
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

Print( "~~~~~~~~~~~\n\n" );
Print( "Sage\n\n" );

zz := HomalgRingOfIntegersInSage( );
Display( zz );

F2 := HomalgRingOfIntegersInSage( 2, zz );
Display( F2 );

Z_4 := HomalgRingOfIntegersInSage( zz ) / 4;
Display( Z_4 );

Q := HomalgFieldOfRationalsInSage( zz );
Display( Q );

F2x := F2 * "x";
Display( F2x );

Qx := Q * "x";
Display( Qx );

