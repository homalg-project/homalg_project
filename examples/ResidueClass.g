##  <#GAPDoc Label="ResidueClass">
##  <Section Label="ResidueClass">
##  <Heading>ResidueClass</Heading>
##  We want to show, how localization can work together with residue class rings.
##  <Example><![CDATA[
##  gap> LoadPackage( "RingsForHomalg" );;
##  gap> LoadPackage( "LocalizeRingForHomalg" );;
##  gap> Qxy := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";;
##  gap> wmat := HomalgMatrix(\
##  >           "[ y^3-y^2 , x^3-x^2 , y^3+y^2 , x^3+x^2 ]",\
##  >           2, 2, Qxy );
##  <A homalg external 2 by 2 matrix>
##  gap> ec := HomalgRingElement( "-x^3-x^2+2*y^2", Qxy );
##  -x^3-x^2+2*y^2
##  ]]></Example>
##  Compute globally:
##  <Example><![CDATA[
##  gap> W := LeftPresentation( wmat );
##  <A left module presented by 2 relations for 2 generators>
##  gap> Res := Resolution( 2 , W );
##  <A right acyclic complex containing 2 morphisms of left modules at degrees
##  [ 0 .. 2 ]>
##   gap> Display ( Res );
##   -------------------------
##   at homology degree: 2
##   0
##   -------------------------
##   (an empty 0 x 2 matrix)
##   
##   the map is currently represented by the above 0 x 2 matrix
##   ------------v------------
##   at homology degree: 1
##   Q[x,y]^(1 x 2)
##   -------------------------
##   y^2,      x^2,
##   x*y^2-y^3,0
##   
##   the map is currently represented by the above 2 x 2 matrix
##   ------------v------------
##   at homology degree: 0
##   Q[x,y]^(1 x 2)
##   -------------------------
##  ]]></Example>
##  Try a localization of a residue class ring:
##  <Example><![CDATA[
##  gap> R1 := Qxy / ec;
##  <A homalg residue class ring>
##  gap> wmat1 := R1 * wmat;
##  <A homalg residue class 2 by 2 matrix>
##  gap> R10 := LocalizeAt( R1 ,\
##  >          [ HomalgRingElement( "x", R1 ),\
##  >            HomalgRingElement( "y", R1 ) ]\
##  >        );
##  <A homalg local ring>
##  gap> wmat10 := HomalgLocalMatrix( wmat, R10 );
##  <A homalg local 2 by 2 matrix>
##  gap> W10 := LeftPresentation( wmat10 );
##  <A left module presented by 2 relations for 2 generators>
##  gap> Res10 := Resolution( 2 , W10 );
##  <A right acyclic complex containing 2 morphisms of left modules at degrees
##  [ 0 .. 2 ]>
##   gap> Display( Res10 );
##   -------------------------
##   at homology degree: 2
##   0
##   -------------------------
##   (an empty 0 x 2 matrix)
##   
##   the map is currently represented by the above 0 x 2 matrix
##   ------------v------------
##   at homology degree: 1
##   Q[x,y]/( -x^3-x^2+2*y^2 )_< |[ x ]|, |[ y ]| >^(1 x 2)
##   -------------------------
##   y^2,    x^2,
##   y^3+y^2,2*y^2
##   
##   modulo [ -x^3-x^2+2*y^2 ]
##   / |[ 1 ]|
##   
##   the map is currently represented by the above 2 x 2 matrix
##   ------------v------------
##   at homology degree: 0
##   Q[x,y]/( -x^3-x^2+2*y^2 )_< |[ x ]|, |[ y ]| >^(1 x 2)
##   -------------------------
##  ]]></Example>
##  Try a residue class ring of a localization:
##  <Example><![CDATA[
##  gap> R0 := LocalizeAtZero( Qxy );
##  <A homalg local ring>
##  gap> wmat0 := R0 * wmat;
##  <A homalg local 2 by 2 matrix>
##  gap> R01 := R0 / ( ec / R0 );
##  <A homalg residue class ring>
##  gap> wmat01 := R01 * wmat0;
##  <A homalg residue class 2 by 2 matrix>
##  gap> W01 := LeftPresentation( wmat01 );
##  <A left module presented by 2 relations for 2 generators>
##  gap> Res01 := Resolution( 2 , W01 );
##  <A right acyclic complex containing 2 morphisms of left modules at degrees
##  [ 0 .. 2 ]>
##   gap> Display(Res01);
##   -------------------------
##   at homology degree: 2
##   0
##   -------------------------
##   (an empty 0 x 2 matrix)
##   
##   the map is currently represented by the above 0 x 2 matrix
##   ------------v------------
##   at homology degree: 1
##   Q[x,y]_< x, y >/( (-x^3-x^2+2*y^2)/1 )^(1 x 2)
##   -------------------------
##   y^2,    x^2,
##   y^3+y^2,2*y^2
##   / 1
##   
##   modulo [ (-x^3-x^2+2*y^2)/1 ]
##   
##   the map is currently represented by the above 2 x 2 matrix
##   ------------v------------
##   at homology degree: 0
##   Q[x,y]_< x, y >/( (-x^3-x^2+2*y^2)/1 )^(1 x 2)
##   -------------------------
##  ]]></Example>
##  </Section>
##  <#/GAPDoc>
LoadPackage( "RingsForHomalg" );;
LoadPackage( "LocalizeRingForHomalg" );;
Qxy := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";;
wmat := HomalgMatrix(\
          "[ y^3-y^2 , x^3-x^2 , y^3+y^2 , x^3+x^2 ]",\
          2, 2, Qxy );
ec := HomalgRingElement( "-x^3-x^2+2*y^2", Qxy );
#Compute globally:
W := LeftPresentation( wmat );
Res := Resolution( 2 , W );
Display(Res);
#Try a localization of a residue class ring:
R1 := Qxy / ec;
wmat1 := R1 * wmat;
R10 := LocalizeAt( R1 ,\
         [ HomalgRingElement( "x", R1 ),\
           HomalgRingElement( "y", R1 ) ]\
       );
wmat10 := HomalgLocalMatrix( wmat, R10 );
W10 := LeftPresentation( wmat10 );
Res10 := Resolution( 2 , W10 );
Display(Res10);
#Try a residue class ring of a localization:
R0 := LocalizeAtZero( Qxy );
wmat0 := R0 * wmat;
R01 := R0 / ( ec / R0 );
wmat01 := R01 * wmat0;
W01 := LeftPresentation( wmat01 );
Res01 := Resolution( 2 , W01 );
Display(Res01);