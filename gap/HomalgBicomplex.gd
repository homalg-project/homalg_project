#############################################################################
##
##  HomalgBicomplex.gd          homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg bicomplexes.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

##  <#GAPDoc Label="IsHomalgBicomplex">
##  <ManSection>
##    <Filt Type="Category" Arg="BC" Name="IsHomalgBicomplex"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of &homalg; bi(co)complexes. <Br/><Br/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgObject</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgBicomplex",
        IsHomalgObject );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsBisequence">
##  <ManSection>
##    <Prop Arg="BC" Name="IsBisequence"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if all maps in <A>BC</A> are well-defined.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsBisequence",
        IsHomalgBicomplex );

##  <#GAPDoc Label="IsBicomplex">
##  <ManSection>
##    <Prop Arg="BC" Name="IsBicomplex"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if <A>BC</A> is bicomplex.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsBicomplex",
        IsHomalgBicomplex );

##  <#GAPDoc Label="IsTransposedWRTTheAssociatedComplex">
##  <ManSection>
##    <Prop Arg="BC" Name="IsTransposedWRTTheAssociatedComplex"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if <A>BC</A> is transposed with respect to the associated complex of complexes. <Br/>
##      (no method installed).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsTransposedWRTTheAssociatedComplex",
        IsHomalgBicomplex );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="TotalComplex">
##  <ManSection>
##    <Attr Arg="BC" Name="TotalComplex"/>
##    <Returns>a &homalg; (co)complex</Returns>
##    <Description>
##      The associated total complex.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "TotalComplex",
        IsHomalgBicomplex );

##  <#GAPDoc Label="SpectralSequence:bicomplex">
##  <ManSection>
##    <Attr Arg="BC" Name="SpectralSequence" Label="for bicomplexes"/>
##    <Returns>a &homalg; (co)homological spectral sequence</Returns>
##    <Description>
##      The associated spectral sequence.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "SpectralSequence",
        IsHomalgBicomplex );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "HomalgBicomplex" );

DeclareOperation( "TransposedBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "*",
        [ IsHomalgRing, IsHomalgBicomplex ] );

DeclareOperation( "*",
        [ IsHomalgBicomplex, IsHomalgRing ] );

# basic operations:

DeclareOperation( "UnderlyingComplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "homalgResetFilters",
        [ IsHomalgBicomplex ] );

DeclareOperation( "PositionOfTheDefaultSetOfRelations",
        [ IsHomalgBicomplex ] );			## provided to avoid branching in the code and always returns fail

DeclareOperation( "ObjectDegreesOfBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "CertainObject",
        [ IsHomalgBicomplex, IsList ] );

DeclareOperation( "ObjectsOfBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "LowestBidegreeInBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "HighestBidegreeInBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "LowestTotalObjectDegreeInBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "HighestTotalObjectDegreeInBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "TotalObjectDegreesOfBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "LowestBidegreeObjectInBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "HighestBidegreeObjectInBicomplex",
        [ IsHomalgBicomplex ] );

DeclareOperation( "CertainVerticalMorphism",
        [ IsHomalgBicomplex, IsList ] );

DeclareOperation( "CertainHorizontalMorphism",
        [ IsHomalgBicomplex, IsList ] );

DeclareOperation( "BidegreesOfBicomplex",
        [ IsHomalgBicomplex, IsInt ] );

DeclareOperation( "BidegreesOfObjectOfTotalComplex",
        [ IsHomalgBicomplex, IsInt ] );

DeclareOperation( "MorphismOfTotalComplex",
        [ IsHomalgBicomplex, IsList, IsList ] );

DeclareOperation( "MorphismOfTotalComplex",
        [ IsHomalgBicomplex, IsInt ] );

