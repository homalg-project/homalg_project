##  <#GAPDoc Label="ResidueClass">
##  <Section Label="ResidueClass">
##  <Heading>ResidueClass</Heading>
##  We want to show, how localization can work together with residue class rings.
##  <Example><![CDATA[
##  gap> LoadPackage( "RingsForHomalg" );;
##  gap> Qxy := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";
##  Q[x,y]
##  gap> wmat := HomalgMatrix(
##  >           "[ y^3-y^2 , x^3-x^2 , y^3+y^2 , x^3+x^2 ]",
##  >           2, 2, Qxy );
##  <A 2 x 2 matrix over an external ring>
##  gap> ec := HomalgRingElement( "-x^3-x^2+2*y^2", Qxy );
##  -x^3-x^2+2*y^2
##  ]]></Example>
##  Compute globally:
##  <Example><![CDATA[
##  gap> LoadPackage( "Modules" );;
##  gap> W := LeftPresentation( wmat );
##  <A left module presented by 2 relations for 2 generators>
##  gap> Res := Resolution( 2 , W );
##  <A right acyclic complex containing 2 morphisms of left modules at degrees
##  [ 0 .. 2 ]>
##  gap> Display( Res );
##  -------------------------
##  at homology degree: 2
##  0
##  -------------------------
##  (an empty 0 x 2 matrix)
##  
##  the map is currently represented by the above 0 x 2 matrix
##  ------------v------------
##  at homology degree: 1
##  Q[x,y]^(1 x 2)
##  -------------------------
##  y^2,      x^2,
##  x*y^2-y^3,0
##  
##  the map is currently represented by the above 2 x 2 matrix
##  ------------v------------
##  at homology degree: 0
##  Q[x,y]^(1 x 2)
##  -------------------------
##  ]]></Example>
##  Try a localization of a residue class ring:
##  <Example><![CDATA[
##  gap> R1 := Qxy / ec;
##  Q[x,y]/( x^3+x^2-2*y^2 )
##  gap> Display( R1 );
##  <A residue class ring>
##  gap> wmat1 := R1 * wmat;
##  <A 2 x 2 matrix over a residue class ring>
##  gap> LoadPackage( "LocalizeRingForHomalg" );;
##  gap> R10 := LocalizeAt( R1 ,
##  >          [ HomalgRingElement( "x", R1 ),
##  >            HomalgRingElement( "y", R1 ) ]
##  >        );
##  Q[x,y]/( x^3+x^2-2*y^2 )_< |[ x ]|, |[ y ]| >
##  gap> Display( R10 );
##  <A local ring>
##  gap> wmat10 := HomalgLocalMatrix( wmat, R10 );
##  <A 2 x 2 matrix over a local ring>
##  gap> W10 := LeftPresentation( wmat10 );
##  <A left module presented by 2 relations for 2 generators>
##  gap> Res10 := Resolution( 2 , W10 );
##  <A right acyclic complex containing 2 morphisms of left modules at degrees
##  [ 0 .. 2 ]>
##  gap> Display( Res10 );
##  -------------------------
##  at homology degree: 2
##  0
##  -------------------------
##  (an empty 0 x 2 matrix)
##  
##  the map is currently represented by the above 0 x 2 matrix
##  ------------v------------
##  at homology degree: 1
##  Q[x,y]/( x^3+x^2-2*y^2 )_< |[ x ]|, |[ y ]| >^(1 x 2)
##  -------------------------
##  0,  x*y^2-y^3,
##  y^2,y^4-2*y^3+2*y^2
##  
##  modulo [ x^3+x^2-2*y^2 ]
##  / |[ 1 ]|
##  
##  the map is currently represented by the above 2 x 2 matrix
##  ------------v------------
##  at homology degree: 0
##  Q[x,y]/( x^3+x^2-2*y^2 )_< |[ x ]|, |[ y ]| >^(1 x 2)
##  -------------------------
##  ]]></Example>
##  Try a residue class ring of a localization:
##  <Example><![CDATA[
##  gap> R0 := LocalizeAtZero( Qxy );
##  Q[x,y]_< x, y >
##  gap> Display( R0 );
##  <A local ring>
##  gap> wmat0 := R0 * wmat;
##  <A 2 x 2 matrix over a local ring>
##  gap> R01 := R0 / ( ec / R0 );
##  Q[x,y]_< x, y >/( (x^3+x^2-2*y^2)/1 )
##  gap> Display( R01 );
##  <A residue class ring>
##  gap> wmat01 := R01 * wmat0;
##  <A 2 x 2 matrix over a residue class ring>
##  gap> W01 := LeftPresentation( wmat01 );
##  <A left module presented by 2 relations for 2 generators>
##  gap> Res01 := Resolution( 2 , W01 );
##  <A right acyclic complex containing 2 morphisms of left modules at degrees
##  [ 0 .. 2 ]>
##  gap> Display( Res01 );
##  -------------------------
##  at homology degree: 2
##  0
##  -------------------------
##  (an empty 0 x 2 matrix)
##  
##  the map is currently represented by the above 0 x 2 matrix
##  ------------v------------
##  at homology degree: 1
##  Q[x,y]_< x, y >/( (x^3+x^2-2*y^2)/1 )^(1 x 2)
##  -------------------------
##  y^2,    x^2,
##  y^3+y^2,2*y^2
##  / 1
##  
##  modulo [ (x^3+x^2-2*y^2)/1 ]
##  
##  the map is currently represented by the above 2 x 2 matrix
##  ------------v------------
##  at homology degree: 0
##  Q[x,y]_< x, y >/( (x^3+x^2-2*y^2)/1 )^(1 x 2)
##  -------------------------
##  ]]></Example>
##  </Section>
##  <#/GAPDoc>
LoadPackage( "RingsForHomalg" );;
Qxy := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";;
wmat := HomalgMatrix(
          "[ y^3-y^2 , x^3-x^2 , y^3+y^2 , x^3+x^2 ]",
          2, 2, Qxy );
ec := HomalgRingElement( "-x^3-x^2+2*y^2", Qxy );

LoadPackage( "Modules" );
#Compute globally:
W := LeftPresentation( wmat );
Res := Resolution( 2 , W );
Display(Res);

#Try a localization of a residue class ring:
R1 := Qxy / ec;
wmat1 := R1 * wmat;
LoadPackage( "LocalizeRingForHomalg" );;
R10 := LocalizeAt( R1 ,
         [ HomalgRingElement( "x", R1 ),
           HomalgRingElement( "y", R1 ) ]
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
