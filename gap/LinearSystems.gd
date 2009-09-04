#############################################################################
##
##  LinearSystems.gd            Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Declaration stuff for linear systems.
##
#############################################################################

####################################
#
# categories:
#
####################################

# three new GAP-categories:

##  <#GAPDoc Label="IsLinearSystem">
##  <ManSection>
##    <Filt Type="Category" Arg="L" Name="IsLinearSystem"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of linear systems.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsLinearSystem",
        IsAttributeStoringRep );

##  <#GAPDoc Label="IsMorphismOfLinearSystems">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsMorphismOfLinearSystems"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of morphisms of linear systems.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsMorphismOfLinearSystems",
        IsAttributeStoringRep );

##  <#GAPDoc Label="IsEndomorphismOfLinearSystems">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsEndomorphismOfLinearSystems"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of endomorphisms of linear systems.
##      (It is a subcategory of the &GAP; category <C>IsMorphismOfLinearSystems</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsEndomorphismOfLinearSystems",
        IsMorphismOfLinearSystems );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsEmpty:linsys">
##  <ManSection>
##    <Prop Arg="L" Name="IsEmpty" Label="for linear systems"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the linear system <A>L</A> is empty.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsEmpty",
        IsLinearSystem );

##  <#GAPDoc Label="IsComplete:linsys">
##  <ManSection>
##    <Prop Arg="L" Name="IsComplete" Label="for linear systems"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the linear system <A>L</A> is complete. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsComplete",
        IsLinearSystem );

##  <#GAPDoc Label="IsBasePointFree">
##  <ManSection>
##    <Prop Arg="L" Name="IsBasePointFree"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the linear system <A>L</A> is base point free. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsBasePointFree",
        IsLinearSystem );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="AssociatedGradedPolynomialRing">
##  <ManSection>
##    <Attr Arg="L" Name="AssociatedGradedPolynomialRing"/>
##    <Returns>a string</Returns>
##    <Description>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AssociatedGradedPolynomialRing",
        IsLinearSystem );

## intrinsic attributes:
##
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## should all be added by hand to LILIN.intrinsic_attributes
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

##  <#GAPDoc Label="Dimension:linsys">
##  <ManSection>
##    <Attr Arg="L" Name="Dimension" Label="for linear systems"/>
##    <Returns>a nonnegative integer or -1</Returns>
##    <Description>
##      The dimension of the linear system <A>L</A>, i.e. the dimension of the projective variety <M>P(</M><A>L</A><M>)</M>.
##      The dimension is <M>-1</M> if <M>P(</M><A>L</A><M>)</M> is empty.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Dimension",
        IsLinearSystem );

##  <#GAPDoc Label="DegreeOfLinearSystem">
##  <ManSection>
##    <Attr Arg="L" Name="DegreeOfLinearSystem"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The degree of the linear system <A>L</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DegreeOfLinearSystem",
        IsLinearSystem );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "AsLinearSystem",
        [ IsHomalgModule, IsString ] );

DeclareOperation( "AsLinearSystem",
        [ IsHomalgModule ] );

# basic operations:

DeclareOperation( "UnderlyingModule",
        [ IsLinearSystem ] );

DeclareOperation( "HomalgRing",
        [ IsLinearSystem ] );

DeclareOperation( "GeneratorsOfLinearSystem",
        [ IsLinearSystem ] );

DeclareOperation( "HomalgRingOfGenerators",
        [ IsLinearSystem ] );

DeclareOperation( "MatrixOfGenerators",
        [ IsLinearSystem ] );

DeclareOperation( "InducedRingMap",
        [ IsLinearSystem ] );

DeclareOperation( "InducedMorphismToProjectiveSpace",
        [ IsLinearSystem ] );

####################################
#
# synonyms:
#
####################################

