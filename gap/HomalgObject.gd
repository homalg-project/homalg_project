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
        IsHomalgObject );

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
        IsHomalgObject );

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
##      It is set to infinity only for <A>M</A><M>=0</M>.
##      A short name for this operation is <C>Depth</C>.
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

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "StructureObject",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "CategoryOfObject",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "PositionOfTheDefaultPresentation",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "PartOfPresentationRelevantForOutputOfFunctors",
        [ IsHomalgStaticObject, IsInt ] );

DeclareOperation( "Depth",
        [ IsHomalgStaticObject, IsHomalgStaticObject ] );

DeclareOperation( "Depth",
        [ IsHomalgStaticObject ] );

DeclareOperation( "SetUpperBoundForProjectiveDimension",
        [ IsHomalgObject, IsInt ] );

DeclareOperation( "SetUpperBoundForProjectiveDimension",
        [ IsHomalgObject, IsInfinity ] );

DeclareOperation( "LockObjectOnCertainPresentation",
        [ IsHomalgStaticObject, IsInt ] );

DeclareOperation( "LockObjectOnCertainPresentation",
        [ IsHomalgStaticObject ] );

DeclareOperation( "UnlockObject",
        [ IsHomalgStaticObject ] );

DeclareOperation( "IsLockedObject",
        [ IsHomalgStaticObject ] );

DeclareOperation( "DecideZero",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "ByASmallerPresentation",
        [ IsHomalgObjectOrMorphism ] );

DeclareOperation( "Display",
        [ IsHomalgObjectOrMorphism, IsString ] );

