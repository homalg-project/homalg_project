#############################################################################
##
##  HomalgModule.gd             homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg modules.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

##  <#GAPDoc Label="IsHomalgModule">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsHomalgModule"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of &homalg; modules. <Br/><Br/>
##      (It is a subcategory of the &GAP; categories
##      <C>IsHomalgRingOrModule</C> and <C>IsHomalgObject</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareCategory( "IsHomalgModule",
        IsHomalgRingOrModule and IsHomalgObject );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsFree">
##  <ManSection>
##    <Prop Arg="M" Name="IsFree"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is free.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsFree",
        IsHomalgModule );

##  <#GAPDoc Label="IsStablyFree">
##  <ManSection>
##    <Prop Arg="M" Name="IsStablyFree"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is stably free.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsStablyFree",
        IsHomalgModule );

##  <#GAPDoc Label="IsProjective">
##  <ManSection>
##    <Prop Arg="M" Name="IsProjective"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is projective.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsProjective",
        IsHomalgModule );

##  <#GAPDoc Label="FiniteFreeResolutionExists">
##  <ManSection>
##    <Prop Arg="M" Name="FiniteFreeResolutionExists"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> allows a finite free resolution. <Br/>
##     (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "FiniteFreeResolutionExists",
        IsHomalgModule );

##  <#GAPDoc Label="IsReflexive">
##  <ManSection>
##    <Prop Arg="M" Name="IsReflexive"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is reflexive.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsReflexive",
        IsHomalgModule );

##  <#GAPDoc Label="IsTorsionFree">
##  <ManSection>
##    <Prop Arg="M" Name="IsTorsionFree"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is torsion-free.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsTorsionFree",
        IsHomalgModule );

##  <#GAPDoc Label="IsArtinian">
##  <ManSection>
##    <Prop Arg="M" Name="IsArtinian"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is artinian. <Br/>
##     (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsArtinian",
        IsHomalgModule );

##  <#GAPDoc Label="IsCyclic">
##  <ManSection>
##    <Prop Arg="M" Name="IsCyclic"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is cyclic. <Br/>
##     (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsCyclic",
        IsHomalgModule );

##  <#GAPDoc Label="IsTorsion">
##  <ManSection>
##    <Prop Arg="M" Name="IsTorsion"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is torsion.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsTorsion",
        IsHomalgModule );

##  <#GAPDoc Label="IsHolonomic">
##  <ManSection>
##    <Prop Arg="M" Name="IsHolonomic"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is holonomic.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsHolonomic",
        IsHomalgModule );

##  <#GAPDoc Label="IsPure">
##  <ManSection>
##    <Prop Arg="M" Name="IsPure"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is pure.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsPure",
        IsHomalgModule );

##  <#GAPDoc Label="HasConstantRank">
##  <ManSection>
##    <Prop Arg="M" Name="HasConstantRank"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> has constant rank. <Br/>
##     (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "HasConstantRank",
        IsHomalgModule );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "TheZeroMorphism",
        IsHomalgModule );

DeclareAttribute( "TheIdentityMorphism",
        IsHomalgModule );

DeclareAttribute( "Genesis",
        IsHomalgModule );

DeclareAttribute( "AFiniteFreeResolution",
        IsHomalgModule );

## intrinsic attributes:
##
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## should all be added by hand to LIMOD.intrinsic_attributes
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

##  <#GAPDoc Label="ElementaryDivisors">
##  <ManSection>
##    <Attr Arg="M" Name="ElementaryDivisors"/>
##    <Returns>a list of ring elements</Returns>
##    <Description>
##      The list of elementary divisors of the &homalg; module <A>M</A>, in case they exist. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "ElementaryDivisors",
        IsHomalgModule );

##  <#GAPDoc Label="RankOfModule">
##  <ManSection>
##    <Attr Arg="M" Name="RankOfModule"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The projective rank of the &homalg; module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "RankOfModule",
        IsHomalgModule );

##  <#GAPDoc Label="ProjectiveDimension">
##  <ManSection>
##    <Attr Arg="M" Name="ProjectiveDimension"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The projective dimension of the &homalg; module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "ProjectiveDimension",
        IsHomalgModule );

##  <#GAPDoc Label="DegreeOfTorsionFreeness">
##  <ManSection>
##    <Attr Arg="M" Name="DegreeOfTorsionFreeness"/>
##    <Returns>a nonnegative integer of infinity</Returns>
##    <Description>
##      Auslander's degree of torsion-freeness of the &homalg; module <A>M</A>.
##      It is set to infinity only for <A>M</A><M>=0</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "DegreeOfTorsionFreeness",
        IsHomalgModule );

##  <#GAPDoc Label="CodimOfModule">
##  <ManSection>
##    <Attr Arg="M" Name="CodimOfModule"/>
##    <Returns>a nonnegative integer of infinity</Returns>
##    <Description>
##      The codimension of the &homalg; module <A>M</A>.
##      It is set to infinity only for <A>M</A><M>=0</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "CodimOfModule",
        IsHomalgModule );

##  <#GAPDoc Label="PurityFiltration">
##  <ManSection>
##    <Attr Arg="M" Name="PurityFiltration"/>
##    <Returns>a &homalg; filtration</Returns>
##    <Description>
##      The purity filtration of the &homalg; module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "PurityFiltration",
        IsHomalgModule );

##  <#GAPDoc Label="CodegreeOfPurity">
##  <ManSection>
##    <Attr Arg="M" Name="CodegreeOfPurity"/>
##    <Returns>a list of nonnegative integers</Returns>
##    <Description>
##      The codegree of purity of the &homalg; module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "CodegreeOfPurity",
        IsHomalgModule );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareOperation( "Presentation",
        [ IsHomalgRelations ] );

DeclareOperation( "Presentation",
        [ IsHomalgGenerators, IsHomalgRelations ] );

DeclareOperation( "LeftPresentation",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "LeftPresentation",
        [ IsList, IsList, IsHomalgRing ] );

DeclareOperation( "LeftPresentation",
        [ IsHomalgMatrix ] );

DeclareOperation( "RightPresentation",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "RightPresentation",
        [ IsList, IsList, IsHomalgRing ] );

DeclareOperation( "RightPresentation",
        [ IsHomalgMatrix ] );

DeclareOperation( "HomalgFreeLeftModule",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "HomalgFreeRightModule",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "HomalgZeroLeftModule",
        [ IsHomalgRing ] );

DeclareOperation( "HomalgZeroRightModule",
        [ IsHomalgRing ] );

DeclareGlobalFunction( "GetGenerators" );

# basic operations:

DeclareOperation( "SetsOfGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "SetsOfRelations",
        [ IsHomalgModule ] );

DeclareOperation( "NumberOfKnownPresentations",
        [ IsHomalgModule ] );

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgModule ] );

DeclareOperation( "SetPositionOfTheDefaultSetOfRelations",
        [ IsHomalgModule, IsInt ] );

DeclareOperation( "GeneratorsOfModule",
        [ IsHomalgModule ] );

DeclareOperation( "GeneratorsOfModule",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "RelationsOfModule",
        [ IsHomalgModule ] );

DeclareOperation( "RelationsOfModule",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "RelationsOfHullModule",
        [ IsHomalgModule ] );

DeclareOperation( "RelationsOfHullModule",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "MatrixOfGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "MatrixOfGenerators",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "MatrixOfRelations",
        [ IsHomalgModule ] );

DeclareOperation( "MatrixOfRelations",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "HasNrGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "NrGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "HasNrGenerators",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "NrGenerators",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "HasNrRelations",
        [ IsHomalgModule ] );

DeclareOperation( "NrRelations",
        [ IsHomalgModule ] );

DeclareOperation( "HasNrRelations",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "NrRelations",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "TransitionMatrix",
        [ IsHomalgModule, IsPosInt, IsPosInt ] );

DeclareOperation( "LockModuleOnCertainPresentation",
        [ IsHomalgModule, IsInt ] );

DeclareOperation( "LockModuleOnCertainPresentation",
        [ IsHomalgModule ] );

DeclareOperation( "UnlockModule",
        [ IsHomalgModule ] );

DeclareOperation( "IsLockedModule",
        [ IsHomalgModule ] );

DeclareOperation( "AddANewPresentation",
        [ IsHomalgModule, IsHomalgGenerators ] );

DeclareOperation( "AddANewPresentation",
        [ IsHomalgModule, IsHomalgRelations ] );

DeclareOperation( "AddANewPresentation",
        [ IsHomalgModule, IsHomalgRelations, IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "DecideZeroEffectively",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "NonZeroGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "GetRidOfObsoleteGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "SetUpperBoundForProjectiveDimension",
        [ IsHomalgModule, IsInt ] );

DeclareOperation( "SetUpperBoundForProjectiveDimension",
        [ IsHomalgModule, IsInfinity ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonym( "PositionOfTheDefaultSetOfGenerators",
        PositionOfTheDefaultSetOfRelations );

DeclareSynonym( "SetPositionOfTheDefaultSetOfGenerators",
        SetPositionOfTheDefaultSetOfRelations );

DeclareSynonym( "EulerCharacteristicOfModule",
        RankOfModule );

DeclareSynonym( "BetterPresentation",
        GetRidOfObsoleteGenerators );

##  <#GAPDoc Label="">
##  <ManSection>
##    <Prop Arg="M" Name=""/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is xxxx.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
