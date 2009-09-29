##  <#GAPDoc Label="Intersection">
##  <Section Label="Intersection">
##  <Heading>Testing the Itersection Formula</Heading>
##  We want to check Serre's intersection formula <M>i(I_1, I_2; 0)=\sum_i(-1)^i length(Tor^{R_0}_i(R_0/I_1,R_0/I_2))</M> on an easy affine example.
##  <Example>
##    <![CDATA[
##   gap> LoadPackage("Sheaves");;
##   gap> LoadPackage("LocalizeRingForHomalg");;
##   gap> R0 := LocalizePolynomialRingAtZeroWithMora( R );;
##   gap> M1 := HomalgMatrix( "[\
##   >        (w-x^2)*y, \
##   >        (w-x^2)*z, \
##   >        (x-w^2)*y, \
##   >        (x-w^2)*z \
##   >      ]", 1, 4, R );;
##   gap> M2 := HomalgMatrix( "[\
##   >        (w-x^2)-y, \
##   >        (x-w^2)-z \
##   >      ]", 1, 2, R );;
##   gap> RmodI1 := RightPresentation( M1 );;
##   gap> RmodI2 := RightPresentation( M2 );;
##   gap> T:=Tor( RmodI1, RmodI2 );
##   <A graded homology object consisting of 4 right modules at degrees [ 0 .. 3 ]>
##   gap> List( ObjectsOfComplex( T ), AffineDegree );
##   [ 12, 4, 0, 0 ]
##   gap> #From the Hilbert series we read,
##   gap> #that there are 12-4=8 intersection points.
##   gap> M10 := R0 * M1;
##   <A homalg local 1 by 4 matrix>
##   gap> M20 := R0 * M2;
##   <A homalg local 1 by 2 matrix>
##   gap> R0modI10 := RightPresentation( M10 );;
##   gap> R0modI20 := RightPresentation( M20 );;
##   gap> T0 := Tor( R0modI10, R0modI20 );
##   <A graded homology object consisting of 4 right modules at degrees [ 0 .. 3 ]>
##   gap> List( ObjectsOfComplex( T0 ), AffineDegree );
##   [ 3, 1, 0, 0 ]
##   gap> #So locally the Hilbert Series tells us,
##   gap> #that we have a (3-1=2) double intersection points at zero.
##  ]]></Example>
##  </Section>
##  <#/GAPDoc>
LoadPackage("Sheaves");;
LoadPackage("LocalizeRingForHomalg");;
R:=HomalgFieldOfRationalsInSingular() * "w,x,y,z";;
R0 := LocalizePolynomialRingAtZeroWithMora( R );;
M1 := HomalgMatrix( "[\
       (w-x^2)*y, \
       (w-x^2)*z, \
       (x-w^2)*y, \
       (x-w^2)*z \
     ]", 1, 4, R );;
M2 := HomalgMatrix( "[\
       (w-x^2)-y, \
       (x-w^2)-z \
     ]", 1, 2, R );;
RmodI1 := RightPresentation( M1 );;
RmodI2 := RightPresentation( M2 );;
T:=Tor( RmodI1, RmodI2 );
List( ObjectsOfComplex( T ), AffineDegree );
#From the Hilbert series we read,
#that there are 12-4=8 intersection points.
M10 := R0 * M1;
M20 := R0 * M2;
R0modI10 := RightPresentation( M10 );;
R0modI20 := RightPresentation( M20 );;
T0 := Tor( R0modI10, R0modI20 );
List( ObjectsOfComplex( T0 ), AffineDegree );
#So locally the Hilbert Series tells us,
#that we have a (3-1=2) double intersection points at zero.