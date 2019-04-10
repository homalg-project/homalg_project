#############################################################################
##
##  HomalgRingMaps.gd           MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##
##  Declarations of procedures for homalg ring maps.
##
#############################################################################

####################################
#
# categories:
#
####################################

# two new GAP-categories:

##  <#GAPDoc Label="IsHomalgRingMap">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsHomalgRingMap"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of ring maps.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgRingMap",
        IsStructureObjectMorphism );

##  <#GAPDoc Label="IsHomalgRingSelfMap">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsHomalgRingSelfMap"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of ring self-maps. <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgRingMap</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgRingSelfMap",
        IsHomalgRingMap );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsMorphism:ringmap">
##  <ManSection>
##    <Prop Arg="phi" Name="IsMorphism" Label="for ring maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if <A>phi</A> is a well-defined map, i.e. independent of all involved presentations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsMorphism",
        IsHomalgRingMap );

##  <#GAPDoc Label="IsIdentityMorphism:ringmap">
##  <ManSection>
##    <Prop Arg="phi" Name="IsIdentityMorphism" Label="for ring maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; ring map <A>phi</A> is the identity morphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsIdentityMorphism",
        IsHomalgRingMap );

##  <#GAPDoc Label="IsMonomorphism:ringmap">
##  <ManSection>
##    <Prop Arg="phi" Name="IsMonomorphism" Label="for ring maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; ring map <A>phi</A> is a monomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsMonomorphism",
        IsHomalgRingMap );

##  <#GAPDoc Label="IsEpimorphism:ringmap">
##  <ManSection>
##    <Prop Arg="phi" Name="IsEpimorphism" Label="for ring maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; ring map <A>phi</A> is an epimorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsEpimorphism",
        IsHomalgRingMap );

##  <#GAPDoc Label="IsIsomorphism:ringmap">
##  <ManSection>
##    <Prop Arg="phi" Name="IsIsomorphism" Label="for ring maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; ring map <A>phi</A> is an isomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsIsomorphism",
        IsHomalgRingMap );

##  <#GAPDoc Label="IsAutomorphism:ringmap">
##  <ManSection>
##    <Prop Arg="phi" Name="IsAutomorphism" Label="for ring maps"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; ring map <A>phi</A> is an automorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsAutomorphism",	## do not make an ``and''-filter out of this property (I hope the other GAP packages respect this)
        IsHomalgRingMap );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="Source:ringmap">
##  <ManSection>
##    <Attr Arg="phi" Name="Source" Label="for ring maps"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      The source of the &homalg; ring map <A>phi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Source",
        IsHomalgRingMap );

##  <#GAPDoc Label="Range:ringmap">
##  <ManSection>
##    <Attr Arg="phi" Name="Range" Label="for ring maps"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      The target (range) of the &homalg; ring map <A>phi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Range",
        IsHomalgRingMap );

##  <#GAPDoc Label="DegreeOfMorphism:ringmap">
##  <ManSection>
##    <Attr Arg="phi" Name="DegreeOfMorphism" Label="for ring maps"/>
##    <Returns>an integer</Returns>
##    <Description>
##      The degree of the morphism <A>phi</A> of graded rings. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DegreeOfMorphism",
        IsHomalgRingMap );

##  <#GAPDoc Label="CoordinateRingOfGraph">
##  <ManSection>
##    <Attr Arg="phi" Name="CoordinateRingOfGraph" Label="for ring maps"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      The coordinate ring of the graph of the ring map <A>phi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CoordinateRingOfGraph",
        IsHomalgRingMap );

##  <#GAPDoc Label="GeneratorsOfKernelOfRingMap:ringmap">
##  <ManSection>
##    <Attr Arg="phi" Name="GeneratorsOfKernelOfRingMap" Label="for ring maps"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      The kernel ideal of the ring map <A>phi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "GeneratorsOfKernelOfRingMap",
        IsHomalgRingMap );

## intrinsic attributes:
##
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## should all be added by hand to LIMAP.intrinsic_attributes
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "RingMap",
        [ IsHomalgMatrix, IsHomalgRing, IsHomalgRing ] );

DeclareOperation( "RingMap",
        [ IsList, IsHomalgRing, IsHomalgRing ] );

DeclareOperation( "RingMap",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "RingMap",
        [ IsHomalgMatrix ] );

# attributes

DeclareAttribute( "ImagesOfRingMap",
        IsHomalgRingMap );

DeclareAttribute( "ImagesOfRingMapAsColumnMatrix",
        IsHomalgRingMap );

DeclareAttribute( "DataOfCoordinateRingOfGraph",
        IsHomalgRingMap );

# basic operations:
DeclareOperation( "Pullback",
        [ IsHomalgRingMap, IsHomalgMatrix ] );

DeclareOperation( "PreCompose",
        [ IsHomalgRingMap, IsHomalgRingMap ] );
