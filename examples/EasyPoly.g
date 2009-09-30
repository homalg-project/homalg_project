##  <#GAPDoc Label="EasyPoly">
##  <Section Label="EasyPoly">
##  <Heading>An Easy Polynomial Example</Heading>
##  The ground ring used in this example is <M>F_3[x,y]</M>. We want to see, how the different rings in this package can be used to localize at different points and how the results differ.
##  <Example>
##   <![CDATA[
##  gap> LoadPackage("RingsForHomalg");;
##  gap> LoadPackage("LocalizeRingForHomalg");;
##  gap> F3xy := HomalgRingOfIntegersInSingular(3) * "x,y";;
##  gap> x1 := HomalgRingElement( "x+2", F3xy );;
##  gap> y0 := HomalgRingElement( "y", F3xy );;
##  gap> R00 := LocalizeAtZero( F3xy );;
##  gap> R10 := LocalizeAt( F3xy, [ x1, y0 ] );;
##  gap> RMora := LocalizePolynomialRingAtZeroWithMora( F3xy );;
##  gap> M := HomalgMatrix( "[\
##  >        y^3+2*y^2+x+x^2+2*x*y+y^4+x*y^2, \
##  >        x*y^3+2*x^2*y+y^3+y^2+x+2*y+x^2, \
##  >        x^2*y^2+2*x^3+x^2*y+y^3+2*x^2+2*x*y+y^2+2*y\
##  >      ]", 1, 3, F3xy );;
##  gap> I := RightPresentation( M );;
##  gap> M00 := HomalgLocalMatrix( M, R00 );;
##  gap> M10 := HomalgLocalMatrix( M, R10 );;
##  gap> MMora := HomalgLocalMatrix( M, RMora );;
##  gap> I00 := RightPresentation( M00 );;
##  gap> I10 := RightPresentation( M10 );;
##  gap> IMora := RightPresentation( MMora );;
##  ]]></Example>
##  This ring is able to compute a standard basis of the module.
##  <Example><![CDATA[
##  gap> Display( IMora );
##  GF(3)[x,y]_< x, y >/< (x+x^2-x*y-y^2+x*y^2+y^3+y^4)/1, (x-y+x^2+y^2-x^2*y+y^3+\
##  x*y^3)/1, (-y-x^2-x*y+y^2-x^3+x^2*y+y^3+x^2*y^2)/1 >
##  gap> ByASmallerPresentation( IMora );
##  <A cyclic right module on a cyclic generator satisfying 2 relations>
##  gap> Display( IMora );
##  GF(3)[x,y]_< x, y >/< x/1, y/1 >
##  ]]></Example>
##  This ring recognizes, that the module is not zero, but is not able to find better generators...
##  <Example><![CDATA[
##  gap> Display( I00 );
##  GF(3)[x,y]_< x, y >/< (y^4+x*y^2+y^3+x^2-x*y-y^2+x)/1, (x*y^3-x^2*y+y^3+x^2+y^\
##  2+x-y)/1, (x^2*y^2-x^3+x^2*y+y^3-x^2-x*y+y^2-y)/1 >
##  gap> ByASmallerPresentation( I00 );
##  <A cyclic right module on a cyclic generator satisfying 3 relations>
##  gap> Display( I00 );
##  GF(3)[x,y]_< x, y >/< (y^4+x*y^2+y^3+x^2-x*y-y^2+x)/1, (x*y^3-x^2*y+y^3+x^2+y^\
##  2+x-y)/1, (x^2*y^2-x^3+x^2*y+y^3-x^2-x*y+y^2-y)/1 >
##  ]]></Example>
##  ...but we are able to change the ring, to compute a nicer basis.
##  <Example><![CDATA[
##  gap> I00ToMora := RMora * I00;
##  <A cyclic right module on a cyclic generator satisfying 3 relations>
##  gap> Display( I00ToMora );
##  GF(3)[x,y]_< x, y >/< (x+x^2-x*y-y^2+x*y^2+y^3+y^4)/1, (x-y+x^2+y^2-x^2*y+y^3+\
##  x*y^3)/1, (-y-x^2-x*y+y^2-x^3+x^2*y+y^3+x^2*y^2)/1 >
##  gap> ByASmallerPresentation( I00ToMora );
##  <A cyclic right module on a cyclic generator satisfying 2 relations>
##  gap> Display( I00ToMora );
##  GF(3)[x,y]_< x, y >/< x/1, y/1 >
##  ]]></Example>
##  We are able to find out, that this module is actually zero.
##  <Example><![CDATA[
##  gap> Display( I10 );
##  GF(3)[x,y]_< x-1, y >/< (y^4+x*y^2+y^3+x^2-x*y-y^2+x)/1, (x*y^3-x^2*y+y^3+x^2+\
##  y^2+x-y)/1, (x^2*y^2-x^3+x^2*y+y^3-x^2-x*y+y^2-y)/1 >
##  gap> ByASmallerPresentation( I10 );
##  <A zero right module>
##  gap> Display( I10 );
##  0
##  ]]></Example>
##  </Section>
##  <#/GAPDoc>
LoadPackage("RingsForHomalg");;
LoadPackage("LocalizeRingForHomalg");;
F3xy := HomalgRingOfIntegersInSingular(3) * "x,y";;
x1 := HomalgRingElement( "x+2", F3xy );;
y0 := HomalgRingElement( "y", F3xy );;
R00 := LocalizeAtZero( F3xy );;
R10 := LocalizeAt( F3xy, [ x1, y0 ] );;
RMora := LocalizePolynomialRingAtZeroWithMora( F3xy );;
M := HomalgMatrix( "[\
       y^3+2*y^2+x+x^2+2*x*y+y^4+x*y^2, \
       x*y^3+2*x^2*y+y^3+y^2+x+2*y+x^2, \
       x^2*y^2+2*x^3+x^2*y+y^3+2*x^2+2*x*y+y^2+2*y\
     ]", 1, 3, F3xy );;
I := RightPresentation( M );;
M00 := HomalgLocalMatrix( M, R00 );;
M10 := HomalgLocalMatrix( M, R10 );;
MMora := HomalgLocalMatrix( M, RMora );;
I00 := RightPresentation( M00 );;
I10 := RightPresentation( M10 );;
IMora := RightPresentation( MMora );;
#This ring is able to compute a standard basis of the module.
Display( IMora );
ByASmallerPresentation( IMora );
Display( IMora );
#This ring recognizes, that the module is not zero,
#but is not able to find better generators...
Display( I00 );
ByASmallerPresentation( I00 );
Display( I00 );
#...but we are able to change the ring, to compute a nicer basis.
I00ToMora := RMora * I00;
Display( I00ToMora );
ByASmallerPresentation( I00ToMora );
Display( I00ToMora );
#We are able to find out, that this module is actually zero.
Display( I10 );
ByASmallerPresentation( I10 );
Display( I10 );
