#############################################################################
##
##  HomalgModule.gd             Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declaration stuff for homalg modules.
##
#############################################################################

####################################
#
# categories:
#
####################################

# two new GAP-categories:

##  <#GAPDoc Label="IsHomalgModuleOrMap">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsHomalgModuleOrMap"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; modules or maps. <P/>
##      (It is a subcategory of the &GAP; categories
##      <C>IsHomalgRingOrModule</C> and <C>IsHomalgStaticObject</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgModuleOrMap",
        IsHomalgStaticObjectOrMorphism );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsHomalgModule">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsHomalgModule"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; modules. <P/>
##      (It is a subcategory of the &GAP; categories
##      <C>IsHomalgRingOrModule</C> and <C>IsHomalgStaticObject</C>.)
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgModule",
        IsHomalgRingOrModule and
        IsHomalgModuleOrMap and
        IsHomalgStaticObject );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsFree">
##  <ManSection>
##    <Prop Arg="M" Name="IsFree"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is stably free.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsStablyFree",
        IsHomalgModule );

##  <#GAPDoc Label="IsCyclic">
##  <ManSection>
##    <Prop Arg="M" Name="IsCyclic"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is cyclic.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsCyclic",
        IsHomalgModule );

##  <#GAPDoc Label="IsHolonomic">
##  <ManSection>
##    <Prop Arg="M" Name="IsHolonomic"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is holonomic.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsHolonomic",
        IsHomalgModule );

##  <#GAPDoc Label="HasConstantRank">
##  <ManSection>
##    <Prop Arg="M" Name="HasConstantRank"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> has constant rank. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "HasConstantRank",
        IsHomalgModule );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "AFiniteFreeResolution",
        IsHomalgModule );

##  <#GAPDoc Label="PrimaryDecomposition">
##  <ManSection>
##    <Attr Arg="J" Name="PrimaryDecomposition"/>
##    <Returns>a list</Returns>
##    <Description>
##      The primary decomposition of the ideal <A>J</A>. The ring has to be commutative. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "PrimaryDecomposition",
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

DeclareOperation( "ZeroLeftModule",
        [ IsHomalgRing ] );

DeclareOperation( "ZeroRightModule",
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
        [ IsHomalgRing, IsHomalgModule ] );

DeclareOperation( "*",
        [ IsHomalgModule, IsHomalgRing ] );

DeclareOperation( "RingMap",
        [ IsHomalgModule, IsHomalgRing, IsHomalgRing ] );

# global functions:

DeclareGlobalFunction( "GetGenerators" );

# basic operations:

DeclareOperation( "SetsOfGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "SetsOfRelations",
        [ IsHomalgModule ] );

DeclareOperation( "ListOfPositionsOfKnownSetsOfRelations",
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

DeclareOperation( "CertainGenerators",
        [ IsHomalgModule, IsList ] );

DeclareOperation( "CertainGenerator",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "NrRelations",
        [ IsHomalgModule ] );

DeclareOperation( "HasNrRelations",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "NrRelations",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "TransitionMatrix",
        [ IsHomalgModule, IsPosInt, IsPosInt ] );

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

DeclareOperation( "Depth",
        [ IsHomalgModule, IsHomalgModule ] );

DeclareOperation( "AffineDimension",
        [ IsHomalgModule ] );

DeclareOperation( "AffineDegree",
        [ IsHomalgModule ] );

DeclareOperation( "ConstantTermOfHilbertPolynomial",
        [ IsHomalgModule ] );

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

