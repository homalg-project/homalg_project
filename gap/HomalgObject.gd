#############################################################################
##
##  HomalgObject.gd             homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declaration for objects of (Abelian) categories.
##
#############################################################################

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
##      Check if the &homalg; module <A>M</A> is projective.
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
##      Check if the &homalg; module <A>M</A> allows a finite free resolution. <Br/>
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
##      Check if the &homalg; module <A>M</A> is reflexive.
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
##      Check if the &homalg; module <A>M</A> is torsion-free.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsTorsionFree",
        IsHomalgObject );

##  <#GAPDoc Label="IsArtinian:module">
##  <ManSection>
##    <Prop Arg="M" Name="IsArtinian" Label="for modules"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; module <A>M</A> is artinian.
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
##      Check if the &homalg; module <A>M</A> is torsion.
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
##      Check if the &homalg; module <A>M</A> is pure.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsPure",
        IsHomalgObject );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="TheMorphismToZero">
##  <ManSection>
##    <Attr Arg="M" Name="TheMorphismToZero"/>
##    <Returns>a &homalg; map</Returns>
##    <Description>
##      The zero morphism from the &homalg; module <A>M</A> to zero.
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
##      The identity automorphism of the &homalg; module <A>M</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "TheIdentityMorphism",
        IsHomalgObject );

DeclareAttribute( "Genesis",
        IsHomalgObject );

##  <#GAPDoc Label="FullSubmodule">
##  <ManSection>
##    <Attr Arg="M" Name="FullSubmodule"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      The &homalg; module <A>M</A> as a submodule of itself.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "FullSubmodule",
        IsHomalgObject );

##  <#GAPDoc Label="UnderlyingSubobject">
##  <ManSection>
##    <Attr Arg="M" Name="UnderlyingSubobject"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      In case <A>M</A> was defined as the module underlying a submodule <M>L</M> then <M>L</M> is returned. <Br/>
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
## should all be added by hand to LIMOD.intrinsic_attributes
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

##  <#GAPDoc Label="ProjectiveDimension">
##  <ManSection>
##    <Attr Arg="M" Name="ProjectiveDimension"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The projective dimension of the &homalg; module <A>M</A>.
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
##      Auslander's degree of torsion-freeness of the &homalg; module <A>M</A>.
##      It is set to infinity only for <A>M</A><M>=0</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DegreeOfTorsionFreeness",
        IsHomalgObject );

##  <#GAPDoc Label="Codim">
##  <ManSection>
##    <Attr Arg="M" Name="Codim"/>
##    <Returns>a nonnegative integer of infinity</Returns>
##    <Description>
##      The codimension of the &homalg; module <A>M</A>.
##      It is set to infinity only for <A>M</A><M>=0</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Codim",
        IsHomalgObject );

##  <#GAPDoc Label="PurityFiltration">
##  <ManSection>
##    <Attr Arg="M" Name="PurityFiltration"/>
##    <Returns>a &homalg; filtration</Returns>
##    <Description>
##      The purity filtration of the &homalg; module <A>M</A>.
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
##      The codegree of purity of the &homalg; module <A>M</A>.
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

DeclareOperation( "SetUpperBoundForProjectiveDimension",
        [ IsHomalgObject, IsInt ] );

DeclareOperation( "SetUpperBoundForProjectiveDimension",
        [ IsHomalgObject, IsInfinity ] );

