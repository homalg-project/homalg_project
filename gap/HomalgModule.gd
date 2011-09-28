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

####################################
#
# attributes:
#
####################################

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
## should all be added by hand to appear in
## LIMOD.intrinsic_attributes_specific
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

##  <#GAPDoc Label="FittingIdeal">
##  <ManSection>
##    <Attr Arg="M" Name="FittingIdeal"/>
##    <Returns>a list</Returns>
##    <Description>
##      The Fitting ideal of <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "FittingIdeal",
        IsHomalgModule );

##  <#GAPDoc Label="NonFlatLocus">
##  <ManSection>
##    <Attr Arg="M" Name="NonFlatLocus"/>
##    <Returns>a list</Returns>
##    <Description>
##      The non flat locus of <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NonFlatLocus",
        IsHomalgModule );

##  <#GAPDoc Label="LargestMinimalNumberOfLocalGenerators">
##  <ManSection>
##    <Attr Arg="M" Name="LargestMinimalNumberOfLocalGenerators"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The minimal number of <E>local</E> generators of the module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "LargestMinimalNumberOfLocalGenerators",
        IsHomalgModule );

##  <#GAPDoc Label="CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries">
##  <ManSection>
##    <Attr Arg="M" Name="CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries"/>
##    <Returns>a list of integers</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries",
        IsHomalgModule );

##  <#GAPDoc Label="CoefficientsOfNumeratorOfHilbertPoincareSeries">
##  <ManSection>
##    <Attr Arg="M" Name="CoefficientsOfNumeratorOfHilbertPoincareSeries"/>
##    <Returns>a list of integers</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CoefficientsOfNumeratorOfHilbertPoincareSeries",
        IsHomalgModule );

##  <#GAPDoc Label="UnreducedNumeratorOfHilbertPoincareSeries">
##  <ManSection>
##    <Attr Arg="M" Name="UnreducedNumeratorOfHilbertPoincareSeries"/>
##    <Returns>a univariate polynomial with rational coefficients</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnreducedNumeratorOfHilbertPoincareSeries",
        IsHomalgModule );

##  <#GAPDoc Label="NumeratorOfHilbertPoincareSeries">
##  <ManSection>
##    <Attr Arg="M" Name="NumeratorOfHilbertPoincareSeries"/>
##    <Returns>a univariate polynomial with rational coefficients</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NumeratorOfHilbertPoincareSeries",
        IsHomalgModule );

##  <#GAPDoc Label="HilbertPoincareSeries">
##  <ManSection>
##    <Attr Arg="M" Name="HilbertPoincareSeries"/>
##    <Returns>a univariate rational function with rational coefficients</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "HilbertPoincareSeries",
        IsHomalgModule );

##  <#GAPDoc Label="HilbertPolynomial">
##  <ManSection>
##    <Attr Arg="M" Name="HilbertPolynomial"/>
##    <Returns>a univariate polynomial with rational coefficients</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "HilbertPolynomial",
        IsHomalgModule );

##  <#GAPDoc Label="AffineDimension">
##  <ManSection>
##    <Attr Arg="M" Name="AffineDimension"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AffineDimension",
        IsHomalgModule );

##  <#GAPDoc Label="AffineDegree">
##  <ManSection>
##    <Attr Arg="M" Name="AffineDegree"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AffineDegree",
        IsHomalgModule );

##  <#GAPDoc Label="ProjectiveDegree">
##  <ManSection>
##    <Attr Arg="M" Name="ProjectiveDegree"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ProjectiveDegree",
        IsHomalgModule );

##  <#GAPDoc Label="ConstantTermOfHilbertPolynomial">
##  <ManSection>
##    <Attr Arg="M" Name="ConstantTermOfHilbertPolynomialn"/>
##    <Returns>an integer</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ConstantTermOfHilbertPolynomial",
        IsHomalgModule );

##  <#GAPDoc Label="DataOfHilbertFunction">
##  <ManSection>
##    <Prop Arg="M" Name="DataOfHilbertFunction"/>
##    <Returns>a function</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DataOfHilbertFunction",
        IsHomalgModule );

##  <#GAPDoc Label="HilbertFunction">
##  <ManSection>
##    <Prop Arg="M" Name="HilbertFunction"/>
##    <Returns>a function</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "HilbertFunction",
        IsHomalgModule );

##  <#GAPDoc Label="IndexOfRegularity">
##  <ManSection>
##    <Prop Arg="M" Name="IndexOfRegularity"/>
##    <Returns>a function</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IndexOfRegularity",
        IsHomalgModule );

##  <#GAPDoc Label="ElementOfGrothendieckGroup">
##  <ManSection>
##    <Prop Arg="M" Name="ElementOfGrothendieckGroup"/>
##    <Returns>an element of the Grothendieck group of a projective space</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ElementOfGrothendieckGroup",
        IsHomalgModule );

##  <#GAPDoc Label="ChernPolynomial">
##  <ManSection>
##    <Prop Arg="M" Name="ChernPolynomial"/>
##    <Returns>a Chern polynomial with rank</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ChernPolynomial",
        IsHomalgModule );

##  <#GAPDoc Label="ChernCharacter">
##  <ManSection>
##    <Prop Arg="M" Name="ChernCharacter"/>
##    <Returns>a Chern character</Returns>
##    <Description>
##      <A>M</A> is a &homalg; module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ChernCharacter",
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

DeclareGlobalFunction( "RecordForPresentation" );

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

DeclareOperation( "*",
        [ IsHomalgRing, IsHomalgModule ] );

DeclareOperation( "*",
        [ IsHomalgModule, IsHomalgRing ] );

DeclareOperation( "RingMap",
        [ IsHomalgModule, IsHomalgRing, IsHomalgRing ] );

# global functions:

# basic operations:

DeclareOperation( "GetGenerators",
        [ IsHomalgStaticObject, IsObject, IsInt ] );

DeclareOperation( "GetGenerators",
        [ IsHomalgStaticObject, IsObject ] );

DeclareOperation( "GetGenerators",
        [ IsHomalgStaticObject ] );

DeclareOperation( "SetsOfGenerators",
        [ IsHomalgModule ] );

DeclareOperation( "SetsOfRelations",
        [ IsHomalgModule ] );

DeclareOperation( "ListOfPositionsOfKnownSetsOfRelations",
        [ IsHomalgModule ] );

DeclareOperation( "PositionOfLastStoredSetOfRelations",
        [ IsHomalgModule ] );

DeclareOperation( "GeneratorsOfModule",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "GeneratorsOfModule",
        [ IsHomalgModule ] );

DeclareOperation( "GeneratingElements",
        [ IsHomalgModule ] );

DeclareOperation( "RelationsOfModule",
        [ IsHomalgModule, IsPosInt ] );

DeclareOperation( "RelationsOfModule",
        [ IsHomalgModule ] );

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
        [ IsHomalgModule, IsInt, IsInt ] );

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

DeclareOperation( "Eliminate",
        [ IsHomalgModule, IsList ] );

DeclareOperation( "Eliminate",
        [ IsHomalgModule, IsHomalgRingElement ] );

DeclareOperation( "LeadingModule",
        [ IsHomalgModule ] );

DeclareOperation( "CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgModule, IsList, IsList ] );

DeclareOperation( "CoefficientsOfNumeratorOfHilbertPoincareSeries",
        [ IsHomalgModule, IsList, IsList ] );

DeclareOperation( "UnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgModule, IsList, IsList, IsRingElement ] );

DeclareOperation( "UnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgModule, IsList, IsList, IsString ] );

DeclareOperation( "UnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgModule, IsList, IsList ] );

DeclareOperation( "UnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgModule, IsRingElement ] );

DeclareOperation( "UnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgModule, IsString ] );

DeclareOperation( "NumeratorOfHilbertPoincareSeries",
        [ IsHomalgModule, IsList, IsList, IsRingElement ] );

DeclareOperation( "NumeratorOfHilbertPoincareSeries",
        [ IsHomalgModule, IsList, IsList, IsString ] );

DeclareOperation( "NumeratorOfHilbertPoincareSeries",
        [ IsHomalgModule, IsList, IsList ] );

DeclareOperation( "NumeratorOfHilbertPoincareSeries",
        [ IsHomalgModule, IsRingElement ] );

DeclareOperation( "NumeratorOfHilbertPoincareSeries",
        [ IsHomalgModule, IsString ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsHomalgModule, IsList, IsList, IsRingElement ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsHomalgModule, IsList, IsList, IsString ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsHomalgModule, IsList, IsList ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsHomalgModule, IsRingElement ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsHomalgModule, IsString ] );

DeclareOperation( "HilbertPolynomial",
        [ IsHomalgModule, IsList, IsList, IsRingElement ] );

DeclareOperation( "HilbertPolynomial",
        [ IsHomalgModule, IsList, IsList, IsString ] );

DeclareOperation( "HilbertPolynomial",
        [ IsHomalgModule, IsList, IsList ] );

DeclareOperation( "HilbertPolynomial",
        [ IsHomalgModule, IsRingElement ] );

DeclareOperation( "HilbertPolynomial",
        [ IsHomalgModule, IsString ] );

## for CASs which do not support Hilbert* for non-graded modules
DeclareOperation( "AffineDimension",
        [ IsHomalgModule, IsList, IsList ] );

DeclareOperation( "AffineDegree",
        [ IsHomalgModule, IsList, IsList ] );

DeclareOperation( "ProjectiveDegree",
        [ IsHomalgModule, IsList, IsList ] );

DeclareOperation( "ConstantTermOfHilbertPolynomial",
        [ IsHomalgModule, IsList, IsList ] );

DeclareOperation( "HilbertFunction",
        [ IsHomalgModule, IsList, IsList ] );

DeclareOperation( "ElementOfGrothendieckGroup",
        [ IsHomalgModule, IsList, IsList ] );

DeclareOperation( "ChernPolynomial",
        [ IsHomalgModule, IsList, IsList ] );

DeclareOperation( "ChernCharacter",
        [ IsHomalgModule, IsList, IsList ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonym( "PositionOfTheDefaultSetOfGenerators",
        PositionOfTheDefaultPresentation );

DeclareSynonym( "SetPositionOfTheDefaultSetOfGenerators",
        SetPositionOfTheDefaultPresentation );

DeclareSynonym( "BetterPresentation",
        GetRidOfObsoleteGenerators );

