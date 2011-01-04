##  <#GAPDoc Label="Saturate">
##  <Subsection Label="Saturate">
##  <Heading>Saturate</Heading>
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> S := GradedRing( R );;
##  gap> m := GradedLeftSubmodule( "x,y,z", S );
##  <A graded torsion-free (left) ideal given by 3 generators>
##  gap> I := Intersect( m^3, GradedLeftSubmodule( "x", S ) );
##  <A graded torsion-free (left) ideal given by 6 generators>
##  gap> NrRelations( I );
##  8
##  gap> Im := SubobjectQuotient( I, m );
##  <A graded torsion-free rank 1 (left) ideal given by 3 generators>
##  gap> I_m := Saturate( I, m );
##  <A graded principal (left) ideal of rank 1 given by a free generator>
##  gap> Is := Saturate( I );
##  <A graded principal (left) ideal of rank 1 given by a free generator>
##  gap> Assert( 0, Is = I_m );
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "GradedModules" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

S := GradedRing( R );

m := GradedLeftSubmodule( "x,y,z", S );

I := Intersect( m^3, GradedLeftSubmodule( "x", S ) );

NrRelations( I );

Im := SubobjectQuotient( I, m );

I_m := Saturate( I, m );

Is := Saturate( I );

Assert( 0, Is = I_m );

