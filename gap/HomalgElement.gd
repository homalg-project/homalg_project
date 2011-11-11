#############################################################################
##
##  HomalgElement.gd                                          homalg package
##
##  Copyright 2011 Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for homalg elements.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

##  <#GAPDoc Label="IsHomalgElement">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsHomalgElement"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of object elements.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgElement",
        IsAttributeStoringRep and
        IsAdditiveElementWithInverse );

####################################
#
# properties:
#
####################################

##
DeclareProperty( "Twitter",
        IsHomalgElement );

##  <#GAPDoc Label="IsZero:element">
##  <ManSection>
##    <Prop Arg="m" Name="IsZero" Label="for elements"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the object element <A>m</A> is zero.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsCyclicGenerator">
##  <ManSection>
##    <Prop Arg="m" Name="IsCyclicGenerator"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the object element <A>m</A> is a cyclic generator.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsCyclicGenerator",
        IsHomalgElement );

##  <#GAPDoc Label="IsTorsion:element" Label="for elements">
##  <ManSection>
##    <Prop Arg="m" Name="IsTorsion"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the object element <A>m</A> is a torsion element.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareProperty( "IsTorsion",
        IsHomalgElement );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="UnderlyingMorphism">
##  <ManSection>
##    <Attr Arg="m" Name="UnderlyingMorphism"/>
##    <Returns>a &homalg; object</Returns>
##    <Description>
##      The morphism underlying the element <A>m</A> is the morphism from the structure object in the category
##      to the <C>SuperObject</C><M>(</M><A>m</A><M>)</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingMorphism",
        IsHomalgElement );

##  <#GAPDoc Label="SuperObject:elements">
##  <ManSection>
##    <Attr Arg="m" Name="SuperObject" Label="for object elements"/>
##    <Returns>a &homalg; object</Returns>
##    <Description>
##      The object <A>M</A> containing the element <A>m</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "SuperObject",
        IsHomalgElement );

##  <#GAPDoc Label="Annihilator:elements">
##  <ManSection>
##    <Attr Arg="e" Name="Annihilator" Label="for elements"/>
##    <Returns>a &homalg; subobject</Returns>
##    <Description>
##      The annihilator of the object element <A>e</A> as a subobject of the structure object.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Annihilator",
        IsHomalgElement );

DeclareAttribute( "One",
        IsHomalgElement );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "HomalgElement",
   [ IsHomalgStaticMorphism ] );

# global functions:

# basic operations:

DeclareOperation( "DecideZero",
   [ IsHomalgElement ] );

DeclareOperation( "ApplyMorphismToElement",
   [ IsHomalgStaticMorphism, IsHomalgElement ] );

DeclareOperation( "POW",
   [ IsObject, IsHomalgElement ] );
