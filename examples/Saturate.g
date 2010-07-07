##  <#GAPDoc Label="Saturate">
##  <Subsection Label="Saturate">
##  <Heading>Saturate</Heading>
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  <A graded torsion-free (left) ideal given by 3 generators>
##  gap> m := GradedLeftSubmodule( "x,y,z", R );
##  <A graded torsion-free (left) ideal given by 3 generators>
##  gap> I := Intersect( m^3, GradedLeftSubmodule( "x", R ) );
##  <A graded torsion-free (left) ideal given by 6 generators>
##  gap> Im := SubmoduleQuotient( I, m );
##  <A graded torsion-free rank 1 (left) ideal given by 3 generators>
##  gap> I_m := Saturate( I, m );
##  <A graded principal (left) ideal of rank 1 given by a free generator>
##  gap> Is := Saturate( I );
##  <A graded principal (left) ideal of rank 1 given by a free generator>
##  gap> Assert( 0, Is = I_m );
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

m := GradedLeftSubmodule( "x,y,z", R );

I := Intersect( m^3, GradedLeftSubmodule( "x", R ) );

Im := SubmoduleQuotient( I, m );

I_m := Saturate( I, m );

Is := Saturate( I );

Assert( 0, Is = I_m );

