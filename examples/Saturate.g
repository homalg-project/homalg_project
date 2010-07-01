##  <#GAPDoc Label="Saturate">
##  <Subsection Label="Saturate">
##  <Heading>Saturate</Heading>
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  <A graded torsion-free (left) ideal given by 3 generators>
##  gap> m := GradedLeftSubmodule( "x,y,z", R );
##  <A graded torsion-free (left) ideal given by 3 generators>
##  gap> J := Intersect( m^3, GradedLeftSubmodule( "x", R ) );
##  <A graded torsion-free (left) ideal given by 6 generators>
##  gap> Jm := SubmoduleQuotient( J, m );
##  <A graded torsion-free rank 1 (left) ideal given by 3 generators>
##  gap> J_m := Saturate( J, m );
##  <A graded principal (left) ideal of rank 1 given by a free generator>
##  gap> Js := Saturate( J );
##  <A graded principal (left) ideal of rank 1 given by a free generator>
##  gap> Assert( 0, Js = J_m );
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

m := GradedLeftSubmodule( "x,y,z", R );

J := Intersect( m^3, GradedLeftSubmodule( "x", R ) );

Jm := SubmoduleQuotient( J, m );

J_m := Saturate( J, m );

Js := Saturate( J );

Assert( 0, Js = J_m );

