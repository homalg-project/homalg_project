############################################################################
##
##  SCO.gi                   SCO package                      Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for SCO.
##
#############################################################################

##  <#GAPDoc Label="Homology">
##  <ManSection>
##  <Meth Arg="M[, R]" Name="Homology"/>
##  <Returns>a &homalg; complex</Returns>
##  <Description>
##  This returns the homology complex of a list <A>M</A> of
##  &homalg; matrices over the &homalg; ring <A>R</A>.
##  <Example><![CDATA[
##  gap> S;
##  <The simplicial set of the orbifold triangulation "Teardrop",
##  computed up to dimension 0 with Length vector [ 4 ]>
##  gap> R := HomalgRingOfIntegers();
##  <A homalg internal ring>
##  gap> M := CreateHomologyMatrix( S, 4, R );;
##  gap> Homology( M, R );
##  ----------------------------------------------->>>>  Z^(1 x 1)
##  ----------------------------------------------->>>>  0
##  ----------------------------------------------->>>>  Z^(1 x 1)
##  ----------------------------------------------->>>>  Z/< 2 >
##  ----------------------------------------------->>>>  0
##  <A graded homology object consisting of 5 left modules at degrees [ 0 .. 4 ]>
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Homology,
        [ IsList, IsHomalgRing ],
  function( morphisms, R )
    local C, m;
    C := HomalgComplex( HomalgMap( morphisms[1] ), 1 );
    for m in morphisms{[ 2 .. Length( morphisms ) ]} do
        Add( C, m );
    od;
    C!.SkipHighestDegreeHomology := true;
    C!.HomologyOnLessGenerators := true;
    C!.DisplayHomology := true;
    C!.StringBeforeDisplay := "----------------------------------------------->>>>  ";
    return Homology( C );
  end
);

InstallMethod( Homology,
        [ IsList ],
  function( morphisms )
    if Length( morphisms ) > 0 and IsHomalgMatrix( morphisms[1] ) then
        return Homology( morphisms, HomalgRing( morphisms[1] ) );
    fi;
    TryNextMethod();
  end
);

##  <#GAPDoc Label="Cohomology">
##  <ManSection>
##  <Meth Arg="M[, R]" Name="Cohomology"/>
##  <Returns>a &homalg; complex</Returns>
##  <Description>
##  This returns the cohomology complex of a list <A>M</A> of
##  &homalg; matrices over the &homalg; ring <A>R</A>.
##  <Example><![CDATA[
##  gap> S;
##  <The simplicial set of the orbifold triangulation "Teardrop",
##  computed up to dimension 0 with Length vector [ 4 ]>
##  gap> R := HomalgRingOfIntegers();
##  <A homalg internal ring>
##  gap> M := CreateCohomologyMatrix( S, 4, R );;
##  gap> Cohomology( M, R );
##  ----------------------------------------------->>>>  Z^(1 x 1)
##  ----------------------------------------------->>>>  0
##  ----------------------------------------------->>>>  Z^(1 x 1)
##  ----------------------------------------------->>>>  0
##  ----------------------------------------------->>>>  Z/< 2 >
##  <A graded cohomology object consisting of 5 left modules at degrees [ 0 .. 4 ]>
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Cohomology,
        [ IsList, IsHomalgRing ],
  function( morphisms, R )
    local C, m;
    C := HomalgCocomplex( HomalgMap( morphisms[1] ), 0 );
    for m in morphisms{[ 2 .. Length( morphisms ) ]} do
        Add( C, m );
    od;
    C!.SkipHighestDegreeCohomology := true;
    C!.CohomologyOnLessGenerators := true;
    C!.DisplayCohomology := true;
    C!.StringBeforeDisplay := "----------------------------------------------->>>>  ";
    return Cohomology( C );
  end
);
  
InstallMethod( Cohomology,
        [ IsList ],
  function( morphisms )
    if Length( morphisms ) > 0 and IsHomalgMatrix( morphisms[1] ) then
        return Cohomology( morphisms, HomalgRing( morphisms[1] ) );
    fi;
    TryNextMethod();
  end
);

##  <#GAPDoc Label="SCO_Examples">
##  <ManSection>
##  <Func Arg="" Name="SCO_Examples"/>
##  <Returns>nothing</Returns>
##  <Description>
##  This is just an easy way to call the script <F>examples.g</F>, which is
##  located in <F>gap/pkg/SCO/examples/</F>.
##  <Example><![CDATA[
##  gap> SCO_Examples();
##  @@@@@@@@ SCO @@@@@@@@
##  
##  Select base ring:
##   1) Integers (default)
##   2) Rationals
##   3) Z/nZ
##  :1
##  
##  Select Computer Algebra System:
##   1) GAP (default)
##   2) External GAP
##   3) MAGMA
##   4) Maple
##   5) Sage
##  :3
##  ---------------------------------------------------------------
##  Magma V2.14-14    Tue Aug 19 2008 08:36:19 on evariste [Seed = 1054613462]
##  Type ? for help.  Type <Ctrl>-D to quit.
##  ----------------------------------------------------------------
##  
##  
##  Select Method:
##   1) Full syzygy computation (default)
##   2) matrix creation and rank computation only
##  :1
##  
##  Select orbifold (default="C2")
##  :Torus
##    
##  Select mode:
##   1) Cohomology (default)
##   2) Homology
##  :1
##  
##  Select dimension (default = 4)
##  :4
##  Creating the coboundary matrices ...
##  Starting cohomology computation ...
##  ----------------------------------------------->>>>  Z^(1 x 1)
##  ----------------------------------------------->>>>  Z^(1 x 2)
##  ----------------------------------------------->>>>  Z^(1 x 1)
##  ----------------------------------------------->>>>  0
##  ----------------------------------------------->>>>  0    
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( SCO_Examples,
  function( )
    local directory, separator;
    if IsBound( PackageInfo("SCO")[1] ) and IsBound( PackageInfo("SCO")[1].InstallationPath ) then
        directory := PackageInfo("SCO")[1].InstallationPath;
    else
        directory := "./";
    fi;
    if IsBound( GAPInfo.UserHome ) then
        separator := GAPInfo.UserHome{[1]};
    else
        separator := "/";
    fi;
    if Length( directory ) > 0 and directory{[Length( directory )]} <> separator then
        directory := Concatenation( directory, separator );
    fi;
    Read( Concatenation( directory, "examples", separator, "examples.g" ) );
end );
