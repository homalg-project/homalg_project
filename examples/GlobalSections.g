##  <#GAPDoc Label="GlobalSectionsAndPurity">
##  <Subsection Label="GlobalSectionsAndPurity">
##  <Heading>Examples of the ModuleOfGlobalSections Functor and Purity Filtrations</Heading>
##  <Example><![CDATA[
##  gap> LoadPackage( "GradedRingForHomalg" );;
##  gap> Qxyzt := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,t";;
##  gap> S := GradedRing( Qxyzt );;
##  gap> 
##  gap> wmat := HomalgMatrix( "[ \
##  > x*y,  y*z,    z*t,        0,           0,          0,\
##  > x^3*z,x^2*z^2,0,          x*z^2*t,     -z^2*t^2,   0,\
##  > x^4,  x^3*z,  0,          x^2*z*t,     -x*z*t^2,   0,\
##  > 0,    0,      x*y,        -y^2,        x^2-t^2,    0,\
##  > 0,    0,      x^2*z,      -x*y*z,      y*z*t,      0,\
##  > 0,    0,      x^2*y-x^2*t,-x*y^2+x*y*t,y^2*t-y*t^2,0,\
##  > 0,    0,      0,          0,           -1,         1 \
##  > ]", 7, 6, Qxyzt );;
##  gap> 
##  gap> LoadPackage( "GradedModules" );;
##  gap> wmor := GradedMap( wmat, "free", "free", "left", S );;
##  gap> IsMorphism( wmor );;
##  gap> W := LeftPresentationWithDegrees( wmat, S );;
##  gap> HW := ModuleOfGlobalSections( W );
##  <A graded left module presented by 8 relations for 6 generators>
##  gap> LinearStrandOfTateResolution( W, 0,4 );
##  <A cocomplex containing 4 morphisms of graded left modules at degrees
##  [ 0 .. 4 ]>
##  gap> purity_iso := IsomorphismOfFiltration( PurityFiltration( W ) );
##  <A non-zero isomorphism of graded left modules>
##  gap> Hpurity_iso := ModuleOfGlobalSections( purity_iso );
##  <An isomorphism of graded left modules>
##  gap> ModuleOfGlobalSections( wmor );
##  <A homomorphism of graded left modules>
##  gap> NaturalMapToModuleOfGlobalSections( W );
##  <A homomorphism of graded left modules>
##  ]]></Example>
##  </Subsection>
##  <#/GAPDoc>

LoadPackage( "GradedRingForHomalg" );;

Qxyzt := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,t";;
S := GradedRing( Qxyzt );;

wmat := HomalgMatrix( "[ \
x*y,  y*z,    z*t,        0,           0,          0,\
x^3*z,x^2*z^2,0,          x*z^2*t,     -z^2*t^2,   0,\
x^4,  x^3*z,  0,          x^2*z*t,     -x*z*t^2,   0,\
0,    0,      x*y,        -y^2,        x^2-t^2,    0,\
0,    0,      x^2*z,      -x*y*z,      y*z*t,      0,\
0,    0,      x^2*y-x^2*t,-x*y^2+x*y*t,y^2*t-y*t^2,0,\
0,    0,      0,          0,           -1,         1 \
]", 7, 6, Qxyzt );;

LoadPackage( "GradedModules" );;

wmor := GradedMap( wmat, "free", "free", "left", S );;
IsMorphism( wmor );;
W := LeftPresentationWithDegrees( wmat, S );;

HW := ModuleOfGlobalSections( W );

LinearStrandOfTateResolution( W, 0,4 );

purity_iso := IsomorphismOfFiltration( PurityFiltration( W ) );

Hpurity_iso := ModuleOfGlobalSections( purity_iso );

ModuleOfGlobalSections( wmor );

NaturalMapToModuleOfGlobalSections( W );
