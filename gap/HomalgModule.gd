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
##
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
##
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
##
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
##
DeclareProperty( "IsProjective",
        IsHomalgModule );

##  <#GAPDoc Label="FiniteFreeResolutionExists">
##  <ManSection>
##    <Prop Arg="M" Name="FiniteFreeResolutionExists"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> allows a finite free resolution. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
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
##
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
##
DeclareProperty( "IsTorsionFree",
        IsHomalgModule );

##  <#GAPDoc Label="IsArtinian:module">
##  <ManSection>
##    <Prop Arg="M" Name="IsArtinian" Label="for modules"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is artinian.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsArtinian",
        IsHomalgModule );

##  <#GAPDoc Label="IsCyclic">
##  <ManSection>
##    <Prop Arg="M" Name="IsCyclic"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is cyclic.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
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
##
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
##
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
##
DeclareProperty( "IsPure",
        IsHomalgModule );

##  <#GAPDoc Label="HasConstantRank">
##  <ManSection>
##    <Prop Arg="M" Name="HasConstantRank"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> has constant rank. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "HasConstantRank",
        IsHomalgModule );

##  <#GAPDoc Label="ConstructedAsAnIdeal">
##  <ManSection>
##    <Prop Arg="J" Name="ConstructedAsAnIdeal"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the &homalg; submodule <A>J</A> was constructed as an ideal. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "ConstructedAsAnIdeal",
        IsHomalgModule );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="TheZeroMorphism">
##  <ManSection>
##    <Attr Arg="M" Name="TheZeroMorphism"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The zero endomorphism of the &homalg; module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "TheZeroMorphism",
        IsHomalgModule );

##  <#GAPDoc Label="TheIdentityMorphism">
##  <ManSection>
##    <Attr Arg="M" Name="TheIdentityMorphism"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The identity automorphism of the &homalg; module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "TheIdentityMorphism",
        IsHomalgModule );

DeclareAttribute( "Genesis",
        IsHomalgModule );

DeclareAttribute( "AFiniteFreeResolution",
        IsHomalgModule );

##  <#GAPDoc Label="FullSubmodule">
##  <ManSection>
##    <Attr Arg="M" Name="FullSubmodule"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      The &homalg; module <A>M</A> as a submodule of itself.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "FullSubmodule",
        IsHomalgModule );

##  <#GAPDoc Label="EmbeddingInSuperObject">
##  <ManSection>
##    <Attr Arg="N" Name="EmbeddingInSuperObject"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      In case <A>N</A> was defined as a submodule of some module <M>L</M> the embedding of <A>N</A> in <M>L</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "EmbeddingInSuperObject",
        IsHomalgModule );

##  <#GAPDoc Label="FactorObject">
##  <ManSection>
##    <Attr Arg="N" Name="FactorObject"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      In case <A>N</A> was defined as a submodule of some module <M>L</M> the factor module <M>L/</M><A>N</A> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "FactorObject",
        IsHomalgModule );

##  <#GAPDoc Label="ResidueClassRing">
##  <ManSection>
##    <Attr Arg="J" Name="ResidueClassRing"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      In case <A>J</A> was defined as a (left/right) ideal of the ring <M>R</M> the residue class ring <M>R/</M><A>J</A> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ResidueClassRing",
        IsHomalgModule );

##  <#GAPDoc Label="UnderlyingSubobject">
##  <ManSection>
##    <Attr Arg="M" Name="UnderlyingSubobject"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      In case <A>M</A> was defined as the module underlying a submodule <M>L</M> then <M>L</M> is returned. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingSubobject",
        IsHomalgModule );

##
## the attributes below are intrinsic:
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
##
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
##
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
##
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
##
DeclareAttribute( "DegreeOfTorsionFreeness",
        IsHomalgModule );

##  <#GAPDoc Label="Codim">
##  <ManSection>
##    <Attr Arg="M" Name="Codim"/>
##    <Returns>a nonnegative integer of infinity</Returns>
##    <Description>
##      The codimension of the &homalg; module <A>M</A>.
##      It is set to infinity only for <A>M</A><M>=0</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Codim",
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
##
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
##
DeclareAttribute( "CodegreeOfPurity",
        IsHomalgModule );

##  <#GAPDoc Label="BettiDiagram:module">
##  <ManSection>
##    <Attr Arg="M" Name="BettiDiagram" Label="for modules"/>
##    <Returns>a &homalg; diagram</Returns>
##    <Description>
##      The Betti diagram of the &homalg; graded module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "BettiDiagram",
        IsHomalgModule );

##  <#GAPDoc Label="CastelnuovoMumfordRegularity">
##  <ManSection>
##    <Attr Arg="M" Name="CastelnuovoMumfordRegularity"/>
##    <Returns>a non-negative integer</Returns>
##    <Description>
##      The Castelnuovo-Mumford regularity of the &homalg; graded module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CastelnuovoMumfordRegularity",
        IsHomalgModule );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "AsLeftModule",
        [ IsHomalgRing ] );

DeclareOperation( "AsRightModule",
        [ IsHomalgRing ] );

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

DeclareOperation( "*",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "*",
        [ IsHomalgRing, IsInt ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix, IsInt ] );

DeclareOperation( "LeftPresentationWithDegrees",
        [ IsHomalgMatrix ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix, IsInt ] );

DeclareOperation( "RightPresentationWithDegrees",
        [ IsHomalgMatrix ] );

DeclareOperation( "HomalgFreeLeftModuleWithDegrees",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "HomalgFreeLeftModuleWithDegrees",
        [ IsInt, IsHomalgRing, IsInt ] );

DeclareOperation( "HomalgFreeLeftModuleWithDegrees",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "HomalgFreeRightModuleWithDegrees",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "HomalgFreeRightModuleWithDegrees",
        [ IsInt, IsHomalgRing, IsInt ] );

DeclareOperation( "HomalgFreeRightModuleWithDegrees",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "POW",
        [ IsHomalgModule, IsInt ] );

DeclareOperation( "POW",
        [ IsHomalgModule, IsList ] );

DeclareOperation( "POW",
        [ IsHomalgRing, IsInt ] );

DeclareOperation( "POW",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "*",
        [ IsHomalgModule, IsHomalgRing ] );

DeclareOperation( "*",
        [ IsHomalgRing, IsHomalgModule ] );

DeclareOperation( "Subobject",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "Subobject",
        [ IsList, IsHomalgModule ] );

DeclareOperation( "Subobject",
        [ IsHomalgRelations, IsHomalgModule ] );

DeclareOperation( "LeftSubmodule",
        [ IsHomalgMatrix ] );

DeclareOperation( "RightSubmodule",
        [ IsHomalgMatrix ] );

# global functions:

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
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "GeneratorsOfModule",
        [ IsHomalgModule ] );

DeclareOperation( "RelationsOfModule",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "RelationsOfModule",
        [ IsHomalgModule ] );

DeclareOperation( "DegreesOfGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "DegreesOfGenerators",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "RelationsOfHullModule",
        [ IsHomalgModule ] );

DeclareOperation( "RelationsOfHullModule",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "MapHavingSubobjectAsItsImage",
        [ IsHomalgModule ] );

DeclareOperation( "MatrixOfSubobjectGenerators",
        [ IsHomalgModule ] );

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

DeclareOperation( "SuperObject",
        [ IsHomalgModule ] );

DeclareOperation( "UnderlyingObject",
        [ IsHomalgModule ] );

DeclareOperation( "IsSubset",
        [ IsHomalgModule, IsHomalgModule ] );

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

