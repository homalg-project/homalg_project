##  <#GAPDoc Label="Singular">
##  <Subsection Label="Singular">
##  <Heading>&Singular;</Heading>
##  <Example><![CDATA[
##  #@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Singular ).stdout )
##  gap> F2 := HomalgRingOfIntegersInSingular( 2 );
##  GF(2)
##  gap> Display( F2 );
##  <An external ring residing in the CAS Singular>
##  gap> F2s := HomalgRingOfIntegersInSingular( 2, "s" ,F2 );
##  GF(2)(s)
##  gap> Display( F2s );
##  <An external ring residing in the CAS Singular>
##  gap> zz := HomalgRingOfIntegersInSingular( F2 );
##  Z
##  gap> Display( zz );
##  <An external ring residing in the CAS Singular>
##  gap> Q := HomalgFieldOfRationalsInSingular( F2 );
##  Q
##  gap> Display( Q );
##  <An external ring residing in the CAS Singular>
##  gap> Qs := HomalgFieldOfRationalsInSingular( "s", F2 );
##  Q(s)
##  gap> Display( Qs );
##  <An external ring residing in the CAS Singular>
##  gap> Qi := HomalgFieldOfRationalsInSingular( "i", "i^2+1", Q );
##  Q[i]/(i^2+1)
##  gap> Display( Qi );
##  <An external ring residing in the CAS Singular>
##  #@fi
##  ]]></Example>
##  <C>Q := HomalgFieldOfRationalsInSingular( )</C> would launch another Singular.
##  <Example><![CDATA[
##  #@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Singular ).stdout )
##  gap> F2xyz := F2 * "x,y,z";
##  GF(2)[x,y,z]
##  gap> Display( F2xyz );
##  <An external ring residing in the CAS Singular>
##  gap> F2sxyz := F2s * "x,y,z";
##  GF(2)(s)[x,y,z]
##  gap> Display( F2sxyz );
##  <An external ring residing in the CAS Singular>
##  gap> F2xyzw := F2xyz * "w";
##  GF(2)[x,y,z][w]
##  gap> Display( F2xyzw );
##  <An external ring residing in the CAS Singular>
##  gap> F2sxyzw := F2sxyz * "w";
##  GF(2)(s)[x,y,z][w]
##  gap> Display( F2sxyzw );
##  <An external ring residing in the CAS Singular>
##  gap> zzxyz := zz * "x,y,z";
##  Z[x,y,z]
##  gap> Display( zzxyz );
##  <An external ring residing in the CAS Singular>
##  gap> zzxyzw := zzxyz * "w";
##  Z[x,y,z][w]
##  gap> Display( zzxyzw );
##  <An external ring residing in the CAS Singular>
##  gap> Qxyz := Q * "x,y,z";
##  Q[x,y,z]
##  gap> Display( Qxyz );
##  <An external ring residing in the CAS Singular>
##  gap> Qsxyz := Qs * "x,y,z";
##  Q(s)[x,y,z]
##  gap> Display( Qsxyz );
##  <An external ring residing in the CAS Singular>
##  gap> Qixyz := Qi * "x,y,z";
##  (Q[i]/(i^2+1))[x,y,z]
##  gap> Display( Qixyz );
##  <An external ring residing in the CAS Singular>
##  gap> Qxyzw := Qxyz * "w";
##  Q[x,y,z][w]
##  gap> Display( Qxyzw );
##  <An external ring residing in the CAS Singular>
##  gap> Qsxyzw := Qsxyz * "w";
##  Q(s)[x,y,z][w]
##  gap> Display( Qsxyzw );
##  <An external ring residing in the CAS Singular>
##  gap> Dxyz := RingOfDerivations( Qxyz, "Dx,Dy,Dz" );
##  Q[x,y,z]<Dx,Dy,Dz>
##  gap> Display( Dxyz );
##  <An external ring residing in the CAS Singular>
##  gap> Exyz := ExteriorRing( Qxyz, "e,f,g" );
##  Q{e,f,g}
##  gap> Display( Exyz );
##  <An external ring residing in the CAS Singular>
##  gap> Dsxyz := RingOfDerivations( Qsxyz, "Dx,Dy,Dz" );
##  Q(s)[x,y,z]<Dx,Dy,Dz>
##  gap> Display( Dsxyz );
##  <An external ring residing in the CAS Singular>
##  gap> Esxyz := ExteriorRing( Qsxyz, "e,f,g" );
##  Q(s){e,f,g}
##  gap> Display( Esxyz );
##  <An external ring residing in the CAS Singular>
##  gap> Dixyz := RingOfDerivations( Qixyz, "Dx,Dy,Dz" );
##  (Q[i]/(i^2+1))[x,y,z]<Dx,Dy,Dz>
##  gap> Display( Dixyz );
##  <An external ring residing in the CAS Singular>
##  gap> Eixyz := ExteriorRing( Qixyz, "e,f,g" );
##  (Q[i]/(i^2+1)){e,f,g}
##  gap> Display( Eixyz );
##  <An external ring residing in the CAS Singular>
##  gap> qring := HomalgQRingInSingular( Qxyz, "x*y" );
##  Q[x,y,z]/( x*y )
##  gap> Display( qring );
##  <An external ring residing in the CAS Singular>
##  gap> "z + x*y" / qring = "z" / qring;
##  true
##  #@fi
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

zz := HomalgRingOfIntegersInSingular( F2 );
Display( zz );

Q := HomalgFieldOfRationalsInSingular( F2 );
Display( Q );

Qs := HomalgFieldOfRationalsInSingular( "s", F2 );
Display( Qs );

Qi := HomalgFieldOfRationalsInSingular( "i", "i^2+1", Q );
Display( Qi );

F2xyz := F2 * "x,y,z";
Display( F2xyz );

F2sxyz := F2s * "x,y,z";
Display( F2sxyz );

F2xyzw := F2xyz * "w";
Display( F2xyzw );

F2sxyzw := F2sxyz * "w";
Display( F2sxyzw );

ZZxyz := zz * "x,y,z";
Display( zzxyz );

ZZxyzw := zzxyz * "w";
Display( zzxyzw );

Qxyz := Q * "x,y,z";
Display( Qxyz );

Qsxyz := Qs * "x,y,z";
Display( Qsxyz );

Qixyz := Qi * "x,y,z";
Display( Qixyz );

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

Dixyz := RingOfDerivations( Qixyz, "Dx,Dy,Dz" );
Display( Dixyz );

Eixyz := ExteriorRing( Qixyz, "e,f,g" );
Display( Eixyz );
