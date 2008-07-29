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
##  <Meth Arg="L, R" Name="Homology"/>
##  <Returns>the homology of a list <A>L</A> of homalg matrices over the homalg ring <A>R</A>.
##  </Returns>
##  <Description>
##  <Example><![CDATA[
##  no example yet
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

##  <#GAPDoc Label="Cohomology">
##  <ManSection>
##  <Meth Arg="L, R" Name="Cohomology"/>
##  <Returns>the cohomology of a list <A>L</A> of homalg matrices over the homalg ring <A>R</A>.
##  </Returns>
##  <Description>
##  <Example><![CDATA[
##  no example yet
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

##  <#GAPDoc Label="SCO_Examples">
##  <ManSection>
##  <Meth Arg="" Name="SCO_Examples"/>
##  <Returns>nothing.</Returns>
##  <Description>
##  This is just an easy way to call the script 'examples.g', which is
##  located in 'gap/pkg/SCO/examples/'.
##  <Example><![CDATA[
##  no example yet
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SCO_Examples, "",
        [ ],
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
