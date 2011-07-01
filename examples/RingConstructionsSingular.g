##  <#GAPDoc Label="Singular">
##  <Subsection Label="Singular">
##  <Heading>&Singular;</Heading>
##  <Example><![CDATA[
##  gap> F2 := HomalgRingOfIntegersInSingular( 2 );
##  <An external ring residing in the CAS Singular>
##  gap> Display( F2 );
##  GF(2)
##  gap> F2s := HomalgRingOfIntegersInSingular( 2, "s" ,F2 );
##  <An external ring residing in the CAS Singular>
##  gap> Display( F2s );
##  GF(2)(s)
##  gap> ZZ := HomalgRingOfIntegersInSingular( F2 );
##  <An external ring residing in the CAS Singular>
##  gap> Display( ZZ );
##  Z
##  gap> ZZs := HomalgRingOfIntegersInSingular( "s", F2 );
##  <An external ring residing in the CAS Singular>
##  gap> Display( ZZs );
##  Z(s)
##  gap> Q := HomalgFieldOfRationalsInSingular( F2 );
##  <An external ring residing in the CAS Singular>
##  gap> Display( Q );
##  Q
##  gap> Qs := HomalgFieldOfRationalsInSingular( "s", F2 );
##  <An external ring residing in the CAS Singular>
##  gap> Display( Qs );
##  Q(s)
##  ]]></Example>
##  <C>Q := HomalgFieldOfRationalsInSingular( )</C> would launch another Singular.
##  <Example><![CDATA[
##  gap> F2xyz := F2 * "x,y,z";
##  <An external ring residing in the CAS Singular>
##  gap> Display( F2xyz );
##  GF(2)[x,y,z]
##  gap> F2sxyz := F2s * "x,y,z";
##  <An external ring residing in the CAS Singular>
##  gap> Display( F2sxyz );
##  GF(2)(s)[x,y,z]
##  gap> F2xyzw := F2xyz * "w";
##  <An external ring residing in the CAS Singular>
##  gap> Display( F2xyzw );
##  GF(2)[x,y,z][w]
##  gap> F2sxyzw := F2sxyz * "w";
##  <An external ring residing in the CAS Singular>
##  gap> Display( F2sxyzw );
##  GF(2)(s)[x,y,z][w]
##  gap> ZZxyz := ZZ * "x,y,z";
##  <An external ring residing in the CAS Singular>
##  gap> Display( ZZxyz );
##  Z[x,y,z]
##  gap> ZZsxyz := ZZs * "x,y,z";
##  <An external ring residing in the CAS Singular>
##  gap> Display( ZZsxyz );
##  Z(s)[x,y,z]
##  gap> ZZxyzw := ZZxyz * "w";
##  <An external ring residing in the CAS Singular>
##  gap> Display( ZZxyzw );
##  Z[x,y,z][w]
##  gap> ZZsxyzw := ZZsxyz * "w";
##  <An external ring residing in the CAS Singular>
##  gap> Display( ZZsxyzw );
##  Z(s)[x,y,z][w]
##  gap> Qxyz := Q * "x,y,z";
##  <An external ring residing in the CAS Singular>
##  gap> Display( Qxyz );
##  Q[x,y,z]
##  gap> Qsxyz := Qs * "x,y,z";
##  <An external ring residing in the CAS Singular>
##  gap> Display( Qsxyz );
##  Q(s)[x,y,z]
##  gap> Qxyzw := Qxyz * "w";
##  <An external ring residing in the CAS Singular>
##  gap> Display( Qxyzw );
##  Q[x,y,z][w]
##  gap> Qsxyzw := Qsxyz * "w";
##  <An external ring residing in the CAS Singular>
##  gap> Display( Qsxyzw );
##  Q(s)[x,y,z][w]
##  gap> Dxyz := RingOfDerivations( Qxyz, "Dx,Dy,Dz" );
##  <An external ring residing in the CAS Singular>
##  gap> Display( Dxyz );
##  Q[x,y,z]<Dx,Dy,Dz>
##  gap> Exyz := ExteriorRing( Qxyz, "e,f,g" );
##  <An external ring residing in the CAS Singular>
##  gap> Display( Exyz );
##  Q{e,f,g}
##  gap> Dsxyz := RingOfDerivations( Qsxyz, "Dx,Dy,Dz" );
##  <An external ring residing in the CAS Singular>
##  gap> Display( Dsxyz );
##  Q(s)[x,y,z]<Dx,Dy,Dz>
##  gap> Esxyz := ExteriorRing( Qsxyz, "e,f,g" );
##  <An external ring residing in the CAS Singular>
##  gap> Display( Esxyz );
##  Q(s){e,f,g}
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

Print( "~~~~~~~~~~~\n\n" );
Print( "Singular\n\n" );

F2 := HomalgRingOfIntegersInSingular( 2 );
Display( F2 );

F2s := HomalgRingOfIntegersInSingular( 2, "s", F2 );
Display( F2s );

ZZ := HomalgRingOfIntegersInSingular( F2 );
Display( ZZ );

ZZs := HomalgRingOfIntegersInSingular( "s", F2 );
Display( ZZs );

Q := HomalgFieldOfRationalsInSingular( F2 );
Display( Q );

Qs := HomalgFieldOfRationalsInSingular( "s", F2 );
Display( Qs );

F2xyz := F2 * "x,y,z";
Display( F2xyz );

F2sxyz := F2s * "x,y,z";
Display( F2sxyz );

F2xyzw := F2xyz * "w";
Display( F2xyzw );

F2sxyzw := F2sxyz * "w";
Display( F2sxyzw );

ZZxyz := ZZ * "x,y,z";
Display( ZZxyz );

ZZsxyz := ZZs * "x,y,z";
Display( ZZsxyz );

ZZxyzw := ZZxyz * "w";
Display( ZZxyzw );

ZZsxyzw := ZZsxyz * "w";
Display( ZZsxyzw );

Qxyz := Q * "x,y,z";
Display( Qxyz );

Qsxyz := Qs * "x,y,z";
Display( Qsxyz );

Qxyzw := Qxyz * "w";
Display( Qxyzw );

Qsxyzw := Qsxyz * "w";
Display( Qsxyzw );

Dxyz := RingOfDerivations( Qxyz, "Dx,Dy,Dz" );
Display( Dxyz );

Exyz := ExteriorRing( Qxyz, "e,f,g" );
Display( Exyz );

Dsxyz := RingOfDerivations( Qsxyz, "Dx,Dy,Dz" );
Display( Dsxyz );

Esxyz := ExteriorRing( Qsxyz, "e,f,g" );
Display( Esxyz );
