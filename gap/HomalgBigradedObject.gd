#############################################################################
##
##  HomalgBigradedObject.gd     homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg bigraded objects.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

##  <#GAPDoc Label="IsHomalgBigradedObject">
##  <ManSection>
##    <Filt Type="Category" Arg="Er" Name="IsHomalgBigradedObject"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; bigraded objects. <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgObject</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgBigradedObject",
        IsHomalgObject );

# three new GAP-subcategories:

##  <#GAPDoc Label="IsHomalgBigradedObjectAssociatedToAnExactCouple">
##  <ManSection>
##    <Filt Type="Category" Arg="Er" Name="IsHomalgBigradedObjectAssociatedToAnExactCouple"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; bigraded objects associated to an exact couple. <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgBigradedObject</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgBigradedObjectAssociatedToAnExactCouple",
        IsHomalgBigradedObject );

##  <#GAPDoc Label="IsHomalgBigradedObjectAssociatedToAFilteredComplex">
##  <ManSection>
##    <Filt Type="Category" Arg="Er" Name="IsHomalgBigradedObjectAssociatedToAFilteredComplex"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; bigraded objects associated to a filtered complex. <Br/>
##      The <M>0</M>-th spectral sheet <M>E_0</M> stemming from a filtration is a bigraded (differential) object,
##      which, in general, does not stem from an exact couple (although <M>E_1</M>, <M>E_2</M>, ... do). <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgBigradedObject</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgBigradedObjectAssociatedToAFilteredComplex",
        IsHomalgBigradedObject );

##  <#GAPDoc Label="IsHomalgBigradedObjectAssociatedToABicomplex">
##  <ManSection>
##    <Filt Type="Category" Arg="Er" Name="IsHomalgBigradedObjectAssociatedToABicomplex"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; bigraded objects associated to a bicmplex. <P/>
##      (It is a subcategory of the &GAP; category <Br/>
##       <C>IsHomalgBigradedObjectAssociatedToAFilteredComplex</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgBigradedObjectAssociatedToABicomplex",
        IsHomalgBigradedObjectAssociatedToAFilteredComplex );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsEndowedWithDifferential">
##  <ManSection>
##    <Prop Arg="Er" Name="IsEndowedWithDifferential"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if <A>Er</A> is a differential bigraded object. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsEndowedWithDifferential",
        IsHomalgBigradedObject );

##  <#GAPDoc Label="IsStableSheet">
##  <ManSection>
##    <Prop Arg="Er" Name="IsStableSheet"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if <A>Er</A> is stable. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsStableSheet",
        IsHomalgBigradedObject );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "HomalgBigradedObject",
        [ IsHomalgBicomplex ] );

DeclareOperation( "AsDifferentialObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "DefectOfExactness",
        [ IsHomalgBigradedObject ] );

# basic operations:

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgBigradedObject ] );			## provided to avoid branching in the code and always returns fail

DeclareOperation( "ObjectDegreesOfBigradedObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "CertainObject",
        [ IsHomalgBigradedObject, IsList ] );

DeclareOperation( "ObjectsOfBigradedObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "LowestBidegreeInBigradedObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "HighestBidegreeInBigradedObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "LowestBidegreeObjectInBigradedObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "HighestBidegreeObjectInBigradedObject",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "CertainMorphism",
        [ IsHomalgBigradedObject, IsList ] );

DeclareOperation( "UnderlyingBicomplex",
        [ IsHomalgBigradedObjectAssociatedToABicomplex ] );

DeclareOperation( "BidegreeOfDifferential",
        [ IsHomalgBigradedObject ] );

DeclareOperation( "LevelOfBigradedObject",
        [ IsHomalgBigradedObject ] );

