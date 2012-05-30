#############################################################################
##
##  HomalgObject.gd             homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for objects of (Abelian) categories.
##
#############################################################################

####################################
#
# categories:
#
####################################

##  <#GAPDoc Label="IsHomalgObject">
##  <ManSection>
##    <Filt Type="Category" Arg="F" Name="IsHomalgObject"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      This is the super &GAP;-category which will include the &GAP;-categories
##      <Ref Filt="IsHomalgStaticObject"/>, <Ref Filt="IsHomalgComplex"/>, <Ref Filt="IsHomalgBicomplex"/>,
##      <Ref Filt="IsHomalgBigradedObject"/>, and <Ref Filt="IsHomalgSpectralSequence"/>.
##      We need this &GAP;-category to be able to build complexes with *objects*
##      being objects of &homalg; categories or again complexes.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgObject",
        IsHomalgObjectOrMorphism and
        IsStructureObjectOrObject and
        IsAdditiveElementWithZero );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsHomalgStaticObject">
##  <ManSection>
##    <Filt Type="Category" Arg="F" Name="IsHomalgStaticObject"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      This is the super &GAP;-category which will include the &GAP;-categories
##      <C>IsHomalgModule</C>, etc.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgStaticObject",
        IsHomalgStaticObjectOrMorphism and
        IsHomalgObject );
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
##      Check if the &homalg; object <A>M</A> is free.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsFree",
        IsHomalgObject );

##  <#GAPDoc Label="IsStablyFree">
##  <ManSection>
##    <Prop Arg="M" Name="IsStablyFree"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> is stably free.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsStablyFree",
        IsHomalgObject );

##  <#GAPDoc Label="IsProjective">
##  <ManSection>
##    <Prop Arg="M" Name="IsProjective"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> is projective.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsProjective",
        IsHomalgObject );

##  <#GAPDoc Label="IsProjectiveOfConstantRank">
##  <ManSection>
##    <Prop Arg="M" Name="IsProjectiveOfConstantRank"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> is projective of constant rank.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsProjectiveOfConstantRank",
        IsHomalgObject );

##  <#GAPDoc Label="FiniteFreeResolutionExists">
##  <ManSection>
##    <Prop Arg="M" Name="FiniteFreeResolutionExists"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> allows a finite free resolution. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "FiniteFreeResolutionExists",
        IsHomalgObject );

##  <#GAPDoc Label="IsReflexive">
##  <ManSection>
##    <Prop Arg="M" Name="IsReflexive"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> is reflexive.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsReflexive",
        IsHomalgObject );

##  <#GAPDoc Label="IsTorsionFree">
##  <ManSection>
##    <Prop Arg="M" Name="IsTorsionFree"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> is torsion-free.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsTorsionFree",
        IsHomalgObject );

##  <#GAPDoc Label="IsArtinian">
##  <ManSection>
##    <Prop Arg="M" Name="IsArtinian"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> is artinian.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsArtinian",
        IsHomalgObject );

##  <#GAPDoc Label="IsTorsion">
##  <ManSection>
##    <Prop Arg="M" Name="IsTorsion"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> is torsion.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsTorsion",
        IsHomalgObject );

##  <#GAPDoc Label="IsPure">
##  <ManSection>
##    <Prop Arg="M" Name="IsPure"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> is pure.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsPure",
        IsHomalgObject );

##  <#GAPDoc Label="IsInjective">
##  <ManSection>
##    <Prop Arg="M" Name="IsInjective"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> is (marked) injective.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsInjective",
        IsHomalgObject );

##  <#GAPDoc Label="IsInjectiveCogenerator">
##  <ManSection>
##    <Prop Arg="M" Name="IsInjectiveCogenerator"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> is (marked) an injective cogenerator.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsInjectiveCogenerator",
        IsHomalgObject );

##  <#GAPDoc Label="IsCohenMacaulay">
##  <ManSection>
##    <Prop Arg="M" Name="IsCohenMacaulay"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> is Cohen-Macaulay (depends on the specific Abelian category).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsCohenMacaulay",
        IsHomalgObject );

##  <#GAPDoc Label="IsGorenstein">
##  <ManSection>
##    <Prop Arg="M" Name="IsGorenstein"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> is Gorenstein (depends on the specific Abelian category).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsGorenstein",
        IsHomalgObject );

##  <#GAPDoc Label="IsKoszul">
##  <ManSection>
##    <Prop Arg="M" Name="IsKoszul"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> is Koszul (depends on the specific Abelian category).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsKoszul",
        IsHomalgObject );

##  <#GAPDoc Label="HasConstantRank">
##  <ManSection>
##    <Prop Arg="M" Name="HasConstantRank"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; object <A>M</A> has constant rank. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "HasConstantRank",
        IsHomalgObject );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "AFiniteFreeResolution",
        IsHomalgObject );

##  <#GAPDoc Label="TorsionSubobject">
##  <ManSection>
##    <Attr Arg="M" Name="TorsionSubobject"/>
##    <Returns>a &homalg; subobject</Returns>
##    <Description>
##      This constructor returns the finitely generated torsion subobject of the &homalg; object <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "TorsionSubobject",
        IsHomalgObject );

##  <#GAPDoc Label="TheMorphismToZero">
##  <ManSection>
##    <Attr Arg="M" Name="TheMorphismToZero"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The zero morphism from the &homalg; object <A>M</A> to zero.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "TheMorphismToZero",
        IsHomalgObject );

##  <#GAPDoc Label="TheIdentityMorphism">
##  <ManSection>
##    <Attr Arg="M" Name="TheIdentityMorphism"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The identity automorphism of the &homalg; object <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "TheIdentityMorphism",
        IsHomalgObject );

DeclareAttribute( "Genesis",
        IsHomalgObject, "mutable" );

##  <#GAPDoc Label="FullSubobject">
##  <ManSection>
##    <Attr Arg="M" Name="FullSubobject"/>
##    <Returns>a &homalg; subobject</Returns>
##    <Description>
##      The &homalg; object <A>M</A> as a subobject of itself.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "FullSubobject",
        IsHomalgObject );

##  <#GAPDoc Label="ZeroSubobject">
##  <ManSection>
##    <Attr Arg="M" Name="ZeroSubobject"/>
##    <Returns>a &homalg; subobject</Returns>
##    <Description>
##      The zero subobject of the &homalg; object <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ZeroSubobject",
        IsHomalgObject );

##  <#GAPDoc Label="UnderlyingSubobject">
##  <ManSection>
##    <Attr Arg="M" Name="UnderlyingSubobject"/>
##    <Returns>a &homalg; subobject</Returns>
##    <Description>
##      In case <A>M</A> was defined as the object underlying a subobject <M>L</M> then <M>L</M> is returned. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingSubobject",
        IsHomalgObject );

##  <#GAPDoc Label="Annihilator:objects">
##  <ManSection>
##    <Attr Arg="M" Name="Annihilator" Label="for static objects"/>
##    <Returns>a &homalg; subobject</Returns>
##    <Description>
##      The annihilator of the object <A>M</A> as a subobject of the structure object.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Annihilator",
        IsHomalgStaticObject );

##  <#GAPDoc Label="EndomorphismRing">
##  <ManSection>
##    <Attr Arg="M" Name="EndomorphismRing" Label="for static objects"/>
##    <Returns>a &homalg; object</Returns>
##    <Description>
##      The endomorphism ring of the object <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "EndomorphismRing",
        IsHomalgStaticObject );

##  <#GAPDoc Label="UnitObject">
##  <ManSection>
##    <Prop Arg="M" Name="UnitObject"/>
##    <Returns>a Chern character</Returns>
##    <Description>
##      <A>M</A> is a &homalg; object.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnitObject",
        IsHomalgStaticObject );

DeclareAttribute( "TheZeroElement",
        IsHomalgStaticObject );

##
## the attributes below are intrinsic:
##
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## should all be added by hand to LIOBJ.intrinsic_attributes
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

##  <#GAPDoc Label="RankOfObject">
##  <ManSection>
##    <Attr Arg="M" Name="RankOfObject"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The projective rank of the &homalg; object <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RankOfObject",
        IsStructureObjectOrObject );

##  <#GAPDoc Label="ProjectiveDimension">
##  <ManSection>
##    <Attr Arg="M" Name="ProjectiveDimension"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The projective dimension of the &homalg; object <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ProjectiveDimension",
        IsHomalgObject );

##  <#GAPDoc Label="DegreeOfTorsionFreeness">
##  <ManSection>
##    <Attr Arg="M" Name="DegreeOfTorsionFreeness"/>
##    <Returns>a nonnegative integer of infinity</Returns>
##    <Description>
##      Auslander's degree of torsion-freeness of the &homalg; object <A>M</A>.
##      It is set to infinity only for <A>M</A><M>=0</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DegreeOfTorsionFreeness",
        IsHomalgObject );

##  <#GAPDoc Label="Grade">
##  <ManSection>
##    <Attr Arg="M" Name="Grade"/>
##    <Returns>a nonnegative integer of infinity</Returns>
##    <Description>
##      The grade of the &homalg; object <A>M</A>.
##      It is set to infinity if <A>M</A><M>=0</M>.
##      Another name for this operation is <C>Depth</C>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Grade",
        IsHomalgObject );

##  <#GAPDoc Label="PurityFiltration">
##  <ManSection>
##    <Attr Arg="M" Name="PurityFiltration"/>
##    <Returns>a &homalg; filtration</Returns>
##    <Description>
##      The purity filtration of the &homalg; object <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "PurityFiltration",
        IsHomalgObject );

##  <#GAPDoc Label="CodegreeOfPurity">
##  <ManSection>
##    <Attr Arg="M" Name="CodegreeOfPurity"/>
##    <Returns>a list of nonnegative integers</Returns>
##    <Description>
##      The codegree of purity of the &homalg; object <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CodegreeOfPurity",
        IsHomalgObject );

##  <#GAPDoc Label="HilbertPolynomial">
##  <ManSection>
##    <Attr Arg="M" Name="HilbertPolynomial"/>
##    <Returns>a univariate polynomial with rational coefficients</Returns>
##    <Description>
##      <A>M</A> is a &homalg; object.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "HilbertPolynomial",
        IsStructureObjectOrObject );

##  <#GAPDoc Label="AffineDimension">
##  <ManSection>
##    <Attr Arg="M" Name="AffineDimension"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      <A>M</A> is a &homalg; object.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AffineDimension",
        IsStructureObjectOrObject );

##  <#GAPDoc Label="ProjectiveDegree">
##  <ManSection>
##    <Attr Arg="M" Name="ProjectiveDegree"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      <A>M</A> is a &homalg; object.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ProjectiveDegree",
        IsStructureObjectOrObject );

##  <#GAPDoc Label="ConstantTermOfHilbertPolynomial">
##  <ManSection>
##    <Attr Arg="M" Name="ConstantTermOfHilbertPolynomialn"/>
##    <Returns>an integer</Returns>
##    <Description>
##      <A>M</A> is a &homalg; object.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ConstantTermOfHilbertPolynomial",
        IsStructureObjectOrObject );

##  <#GAPDoc Label="ElementOfGrothendieckGroup">
##  <ManSection>
##    <Prop Arg="M" Name="ElementOfGrothendieckGroup"/>
##    <Returns>an element of the Grothendieck group of a projective space</Returns>
##    <Description>
##      <A>M</A> is a &homalg; object.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ElementOfGrothendieckGroup",
        IsStructureObjectOrObject );

##  <#GAPDoc Label="ChernPolynomial">
##  <ManSection>
##    <Prop Arg="M" Name="ChernPolynomial"/>
##    <Returns>a Chern polynomial with rank</Returns>
##    <Description>
##      <A>M</A> is a &homalg; object.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ChernPolynomial",
        IsStructureObjectOrObject );

##  <#GAPDoc Label="ChernCharacter">
##  <ManSection>
##    <Prop Arg="M" Name="ChernCharacter"/>
##    <Returns>a Chern character</Returns>
##    <Description>
##      <A>M</A> is a &homalg; object.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ChernCharacter",
        IsStructureObjectOrObject );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "Pullback",
        [ IsStructureObjectMorphism, IsHomalgObject ] );

DeclareOperation( "*",
        [ IsStructureObject, IsHomalgStaticObject ] );

DeclareOperation( "*",
        [ IsHomalgStaticObject, IsStructureObject ] );

# basic operations:

DeclareOperation( "StructureObject",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "HomalgCategory",
        [ IsObject ] );

DeclareOperation( "MorphismConstructor",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "MorphismConstructor",
        [ IsObject, IsObject ] );

DeclareOperation( "MorphismConstructor",
        [ IsObject, IsHomalgStaticObject, IsHomalgStaticObject ] );

DeclareOperation( "FunctorOfGenesis",
        [ IsHomalgObjectOrMorphism, IsInt ] );

DeclareOperation( "FunctorOfGenesis",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "FunctorsOfGenesis",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "ArgumentsOfGenesis",
        [ IsHomalgObjectOrMorphism, IsInt ] );

DeclareOperation( "ArgumentsOfGenesis",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "PositionOfTheDefaultPresentation",
        [ IsObject ] );

DeclareOperation( "PartOfPresentationRelevantForOutputOfFunctors",
        [ IsHomalgStaticObject, IsObject ] );

DeclareOperation( "ComparePresentationsForOutputOfFunctors",
        [ IsHomalgStaticObject, IsObject, IsObject ] );

DeclareOperation( "End",
        [ IsHomalgStaticObject ] );

DeclareGlobalFunction( "Grade_UsingInternalExtForObjects" );

DeclareOperation( "Grade",
        [ IsHomalgStaticObject, IsStructureObjectOrObjectOrMorphism, IsInt ] );

DeclareOperation( "Grade",
        [ IsHomalgStaticObject, IsStructureObjectOrObjectOrMorphism ] );

DeclareOperation( "Grade",
        [ IsHomalgStaticObject, IsInt ] );

## Depth is already declared as an operation in GAP
## so we cannot declare it as a synonym for Grade;
## not doing so keeps us more flexible but requires
## explicit declarations and installations
DeclareOperation( "Depth",
        [ IsHomalgStaticObject, IsStructureObjectOrObjectOrMorphism, IsInt ] );

DeclareOperation( "Depth",
        [ IsHomalgStaticObject, IsStructureObjectOrObjectOrMorphism ] );

DeclareOperation( "Depth",
        [ IsHomalgStaticObject, IsInt ] );

## corresponds to the above declaration of Grade as an attribute
DeclareOperation( "Depth",
        [ IsHomalgStaticObject ] );

DeclareOperation( "SetUpperBoundForProjectiveDimension",
        [ IsHomalgObject, IsInt ] );

DeclareOperation( "SetUpperBoundForProjectiveDimension",
        [ IsHomalgObject, IsInfinity ] );

DeclareOperation( "LockObjectOnCertainPresentation",
        [ IsHomalgStaticObject, IsObject ] );

DeclareOperation( "LockObjectOnCertainPresentation",
        [ IsHomalgStaticObject ] );

DeclareOperation( "UnlockObject",
        [ IsHomalgStaticObject ] );

DeclareOperation( "IsLockedObject",
        [ IsHomalgStaticObject ] );

DeclareOperation( "SetPositionOfTheDefaultPresentation",
        [ IsHomalgStaticObject, IsObject ] );

DeclareOperation( "DecideZero",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "ByASmallerPresentation",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "OnPresentationByFirstMorphismOfResolution",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "Display",
        [ IsHomalgObjectOrMorphism, IsString ] );
