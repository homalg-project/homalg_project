#############################################################################
##
##  HomalgMorphisms.gd          homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for homalg morphisms of Abelian categories.
##
#############################################################################

##  <#GAPDoc Label="IsHomalgMorphism">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsHomalgMorphism"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      This is the super &GAP;-category which will include the &GAP;-categories
##      <Ref Filt="IsHomalgStaticMorphism"/> and <Ref Filt="IsHomalgChainMap"/>.
##      We need this &GAP;-category to be able to build complexes with *objects*
##      being objects of &homalg; categories or again complexes.
##      We need this GAP-category to be able to build chain maps with *morphisms*
##      being morphisms of &homalg; categories or again chain maps. <Br/>
##      CAUTION: Never let &homalg; morphisms (which are not endomorphisms)
##      be multiplicative elements!!
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgMorphism",
        IsHomalgStaticObjectOrMorphism and
        IsAdditiveElementWithInverse );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsHomalgStaticMorphism">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsHomalgStaticMorphism"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      This is the super &GAP;-category which will include the &GAP;-categories
##      <C>IsHomalgMap</C>, etc. <Br/>
##      CAUTION: Never let homalg morphisms (which are not endomorphisms)
##      be multiplicative elements!!
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgStaticMorphism",
        IsHomalgMorphism );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsHomalgEndomorphism">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsHomalgEndomorphism"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      This is the super &GAP;-category which will include the &GAP;-categories
##      <C>IsHomalgSelfMap</C>, <Ref Filt="IsHomalgChainSelfMap"/>, etc.
##      be multiplicative elements!!
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgEndomorphism",
        IsHomalgMorphism and
        IsMultiplicativeElementWithInverse );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsMorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsMorphism" Label="for maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if <A>phi</A> is a well-defined map, i.e. independent of all involved presentations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsMorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsGeneralizedMorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsGeneralizedMorphism" Label="for maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if <A>phi</A> is a generalized morphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsGeneralizedMorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsGeneralizedEpimorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsGeneralizedEpimorphism" Label="for maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if <A>phi</A> is a generalized epimorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsGeneralizedEpimorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsGeneralizedMonomorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsGeneralizedMonomorphism" Label="for maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if <A>phi</A> is a generalized monomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsGeneralizedMonomorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsGeneralizedIsomorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsGeneralizedIsomorphism" Label="for maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if <A>phi</A> is a generalized isomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsGeneralizedIsomorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsIdentityMorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsIdentityMorphism" Label="for maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is the identity morphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsIdentityMorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsMonomorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsMonomorphism" Label="for maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is a monomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsMonomorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsEpimorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsEpimorphism" Label="for maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is an epimorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsEpimorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsSplitMonomorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsSplitMonomorphism" Label="for maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is a split monomorphism. <Br/>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsSplitMonomorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsSplitEpimorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsSplitEpimorphism" Label="for maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is a split epimorphism. <Br/>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsSplitEpimorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsIsomorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsIsomorphism" Label="for maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is an isomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsIsomorphism",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsAutomorphism:map">
##  <ManSection>
##    <Prop Arg="phi" Name="IsAutomorphism" Label="for maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; map <A>phi</A> is an automorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsAutomorphism",	## do not make an ``and''-filter out of this property (I hope the other GAP packages respect this)
        IsHomalgMorphism );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="Source:map">
##  <ManSection>
##    <Attr Arg="phi" Name="Source" Label="for maps"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      The source of the &homalg; map <A>phi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "Source",
        IsHomalgMorphism );

##  <#GAPDoc Label="Range:map">
##  <ManSection>
##    <Attr Arg="phi" Name="Range" Label="for maps"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      The target (range) of the &homalg; map <A>phi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "Range",
        IsHomalgMorphism );

##  <#GAPDoc Label="ImageSubobject">
##  <ManSection>
##    <Attr Arg="phi" Name="ImageSubobject" Label="for maps"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      This constructor returns the finitely generated image of the &homalg; map <A>phi</A>
##      as a submodule of the &homalg; module <C>Range</C>(<A>phi</A>) with generators given by <A>phi</A>
##      applied to the generators of its source module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "ImageSubobject",
        IsHomalgMorphism );

##  <#GAPDoc Label="KernelSubobject:map">
##  <ManSection>
##    <Attr Arg="phi" Name="KernelSubobject" Label="for maps"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      This constructor returns the finitely generated kernel of the &homalg; map <A>phi</A>
##      as a submodule of the &homalg; module <C>Source</C>(<A>phi</A>) with generators given by
##      the syzygies of <A>phi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareAttribute( "KernelSubobject",
        IsHomalgMorphism );

##  <#GAPDoc Label="MorphismAid:map">
##  <ManSection>
##    <Attr Arg="phi" Name="MorphismAid" Label="for maps"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The morphism aid map of a true generalized map. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "MorphismAid",
        IsHomalgMorphism );

##  <#GAPDoc Label="GeneralizedInverse:map">
##  <ManSection>
##    <Attr Arg="phi" Name="GeneralizedInverse" Label="for maps"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The generalized inverse of the epimorphism <A>phi</A> (cf. <Cite Key="BaSF" Where="Cor. 4.8"/>)).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "GeneralizedInverse",
        IsHomalgMorphism );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "RemoveMorphismAid",
        [ IsHomalgMorphism ] );

DeclareOperation( "GeneralizedMap",
        [ IsHomalgMorphism, IsObject ] );

DeclareOperation( "AddToMorphismAid",
        [ IsHomalgMorphism, IsObject ] );

DeclareOperation( "AssociatedMorphism",
        [ IsHomalgMorphism ] );

DeclareOperation( "AnIsomorphism",
        [ IsHomalgModule ] );

DeclareOperation( "Subobject",
        [ IsHomalgMorphism ] );

# basic operations:

DeclareOperation( "AreComparableMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "AreComposableMorphisms",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "*",					## this must remain, since an element in IsHomalgMorphism
        [ IsHomalgMorphism, IsHomalgMorphism ] );	## is not a priori IsMultiplicativeElement

DeclareOperation( "POW",				## this must remain, since an element in IsHomalgMorphism
        [ IsHomalgMorphism, IsInt ] );			## is not a priori IsMultiplicativeElement

DeclareOperation( "PreCompose",
        [ IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "PreInverse",
        [ IsHomalgMorphism ] );

DeclareOperation( "PostInverse",
        [ IsHomalgMorphism ] );

DeclareOperation( "CompleteImageSquare",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "CompleteKernelSquare",
        [ IsHomalgMorphism, IsHomalgMorphism, IsHomalgMorphism ] );

DeclareOperation( "UpdateObjectsByMorphism",
        [ IsHomalgMorphism ] );

