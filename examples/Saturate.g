##  <#GAPDoc Label="Saturate">
##  <Subsection Label="Saturate">
##  <Heading>Saturate</Heading>
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  <A graded (left) ideal given by 3 generators>
##  gap> m := GradedLeftSubmodule( "x,y,z", R );
##  <A graded (left) ideal given by 3 generators>
##  gap> J := Intersect( m^3, GradedLeftSubmodule( "x", R ) );
##  <A graded (left) ideal given by 6 generators>
##  gap> J_m := J - m;
##  <A graded (left) ideal given by 3 generators>
##  gap> Js := Saturate( J, m );
##  <A graded principal (left) ideal given by a cyclic generator>
##  gap> Jm := Saturate( J );
##  <A graded principal (left) ideal given by a cyclic generator>
##  gap> Assert( 0, Js = Jm );
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

m := GradedLeftSubmodule( "x,y,z", R );

J := Intersect( m^3, GradedLeftSubmodule( "x", R ) );

J_m := J - m;

Js := Saturate( J, m );

Jm := Saturate( J );

Assert( 0, Js = Jm );

