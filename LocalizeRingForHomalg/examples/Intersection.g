##  <#GAPDoc Label="Intersection">
##  <Section Label="Intersection">
##  <Heading>Testing the Intersection Formula</Heading>
##  We want to check Serre's intersection formula
##  <M>i(I_1, I_2; 0)=\sum_i(-1)^i length(Tor^{R_0}_i(R_0/I_1,R_0/I_2))</M>
##  on an easy affine example.
##  <Example>
##   <![CDATA[
##  gap> LoadPackage( "RingsForHomalg" );;
##  gap> R := HomalgFieldOfRationalsInSingular() * "w,x,y,z";;
##  gap> LoadPackage( "LocalizeRingForHomalg" );;
##  gap> R0 := LocalizePolynomialRingAtZeroWithMora( R );;
##  gap> M1 := HomalgMatrix( "[\
##  >        (w-x^2)*y, \
##  >        (w-x^2)*z, \
##  >        (x-w^2)*y, \
##  >        (x-w^2)*z  \
##  >      ]", 4, 1, R );;
##  gap> M2 := HomalgMatrix( "[\
##  >        (w-x^2)-y, \
##  >        (x-w^2)-z  \
##  >      ]", 2, 1, R );;
##  gap> LoadPackage( "Modules" );;
##  gap> RmodI1 := LeftPresentation( M1 );;
##  gap> RmodI2 := LeftPresentation( M2 );;
##  gap> T:=Tor( RmodI1, RmodI2 );
##  <A graded homology object consisting of 4 left modules at degrees [ 0 .. 3 ]>
##  gap> List( ObjectsOfComplex( T ), AffineDegree );
##  [ 12, 4, 0, 0 ]
##  ]]></Example>
##  We read, that the intersection multiplicity is 12-4=8 globally.
##  <Example><![CDATA[
##  gap> M10 := R0 * M1;
##  <A 4 x 1 matrix over a local (Mora) ring>
##  gap> M20 := R0 * M2;
##  <A 2 x 1 matrix over a local (Mora) ring>
##  gap> R0modI10 := LeftPresentation( M10 );;
##  gap> R0modI20 := LeftPresentation( M20 );;
##  gap> T0 := Tor( R0modI10, R0modI20 );
##  <A graded homology object consisting of 4 left modules at degrees [ 0 .. 3 ]>
##  gap> List( ObjectsOfComplex( T0 ), AffineDegree );
##  [ 3, 1, 0, 0 ]
##  ]]></Example>
##  The intersection multiplicity at zero is 3-1=2.
##  </Section>
##  <#/GAPDoc>
LoadPackage( "RingsForHomalg" );;
R := HomalgFieldOfRationalsInSingular() * "w,x,y,z";;

LoadPackage( "LocalizeRingForHomalg" );;
R0 := LocalizePolynomialRingAtZeroWithMora( R );;
M1 := HomalgMatrix( "[\
       (w-x^2)*y, \
       (w-x^2)*z, \
       (x-w^2)*y, \
       (x-w^2)*z  \
     ]", 4, 1, R );;
M2 := HomalgMatrix( "[\
       (w-x^2)-y, \
       (x-w^2)-z  \
     ]", 2, 1, R );;

LoadPackage( "Modules" );;
RmodI1 := LeftPresentation( M1 );;
RmodI2 := LeftPresentation( M2 );;
T:=Tor( RmodI1, RmodI2 );
Assert( 0, List( ObjectsOfComplex( T ), AffineDegree ) = [ 12, 4, 0, 0 ] );
#We read, that the intersection multiplicity is 12-4=8 globally.

M10 := R0 * M1;
M20 := R0 * M2;
R0modI10 := LeftPresentation( M10 );;
R0modI20 := LeftPresentation( M20 );;
T0 := Tor( R0modI10, R0modI20 );
Assert( 0, List( ObjectsOfComplex( T0 ), AffineDegree ) = [ 3, 1, 0, 0 ] );
#The intersection multiplicity at zero is 3-1=2.
