#############################################################################
##
##  MorphismsOfSchemes.gd       Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Declaration stuff for morphisms of schemes.
##
#############################################################################

####################################
#
# categories:
#
####################################

# two new GAP-categories:

##  <#GAPDoc Label="IsMorphismOfSchemes">
##  <ManSection>
##    <Filt Type="Category" Arg="f" Name="IsMorphismOfSchemes"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of morphisms of schemes.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsMorphismOfSchemes",
        IsAttributeStoringRep );

##  <#GAPDoc Label="IsEndomorphismOfSchemes">
##  <ManSection>
##    <Filt Type="Category" Arg="f" Name="IsEndomorphismOfSchemes"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of endomorphisms of schemes.
##      (It is a subcategory of the &GAP; category <C>IsMorphismOfSchemes</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsEndomorphismOfSchemes",
        IsMorphismOfSchemes );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsProjective:morphism">
##  <ManSection>
##    <Prop Arg="f" Name="IsProjective" Label="for morphisms of schemes"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the morphism of schemes <A>f</A> is projective. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsProjective",
        IsScheme );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="Source:morphism">
##  <ManSection>
##    <Attr Arg="f" Name="Source" Label="for morphisms of schemes"/>
##    <Returns>a scheme</Returns>
##    <Description>
##      The source of the morphism of schemes <A>f</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Source",
        IsMorphismOfSchemes );

##  <#GAPDoc Label="Range:morphism">
##  <ManSection>
##    <Attr Arg="f" Name="Range" Label="for morphisms of schemes"/>
##    <Returns>a scheme</Returns>
##    <Description>
##      The target (range) of the morphism of schemes <A>f</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Range",
        IsMorphismOfSchemes );

## intrinsic attributes:
##
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## should all be added by hand to LISCM.intrinsic_attributes
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "Proj",
        [ IsHomalgRingMap ] );

# basic operations:

DeclareOperation( "AssociatedRingMap",
        [ IsMorphismOfSchemes ] );

DeclareOperation( "ImageScheme",
        [ IsMorphismOfSchemes ] );

DeclareOperation( "ImageScheme",
        [ IsMorphismOfSchemes, IsScheme ] );

DeclareOperation( "ImageScheme",
        [ IsScheme, IsMorphismOfSchemes ] );

####################################
#
# synonyms:
#
####################################

