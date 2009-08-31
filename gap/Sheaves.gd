#############################################################################
##
##  Sheaves.gd                  Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Declaration stuff for sheaves.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new GAP-category:

DeclareCategory( "IsSetOfUnderlyingModules",
        IsComponentObjectRep );

# four new GAP-categories:

##  <#GAPDoc Label="IsHomalgSheafOfRings">
##  <ManSection>
##    <Filt Type="Category" Arg="O" Name="IsHomalgSheafOfRings"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaves of rings. <Br/><Br/>
##      (It is a subcategory of the &GAP; category
##      <C>IsHomalgRingOrObject</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgSheafOfRings",
        IsHomalgRingOrObject );

##  <#GAPDoc Label="IsHomalgSheaf">
##  <ManSection>
##    <Filt Type="Category" Arg="E" Name="IsHomalgSheaf"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaves. <Br/><Br/>
##      (It is a subcategory of the &GAP; categories
##      <C>IsHomalgRingOrObject</C> and <C>IsHomalgObject</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgSheaf",
        IsHomalgRingOrObject and IsHomalgObject );

##  <#GAPDoc Label="IsHomalgSheafMap">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsHomalgSheafMap"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaf maps. <Br/><Br/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgMorphism</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgSheafMap",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsHomalgSheafSelfMap">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsHomalgSheafSelfMap"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaf self-maps. <Br/><Br/>
##      (It is a subcategory of the &GAP; categories
##       <C>IsHomalgSheafMap</C> and <C>IsHomalgEndomorphism</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgSheafSelfMap",
        IsHomalgSheafMap and
        IsHomalgEndomorphism );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsFree">
##  <ManSection>
##    <Prop Arg="E" Name="IsFree"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> is free.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsFree",
        IsHomalgSheaf );

##  <#GAPDoc Label="IsStablyFree">
##  <ManSection>
##    <Prop Arg="E" Name="IsStablyFree"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> is stably free.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsStablyFree",
        IsHomalgSheaf );

##  <#GAPDoc Label="IsDirectSumOfLineBundles">
##  <ManSection>
##    <Prop Arg="E" Name="IsDirectSumOfLineBundles"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> is a direct sum of line bundles.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsDirectSumOfLineBundles",
        IsHomalgSheaf );

##  <#GAPDoc Label="IsLocallyFree">
##  <ManSection>
##    <Prop Arg="E" Name="IsLocallyFree"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> is locally free (a vector bundle).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLocallyFree",
        IsHomalgSheaf );

##  <#GAPDoc Label="IsReflexive">
##  <ManSection>
##    <Prop Arg="E" Name="IsReflexive"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> is reflexive.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsReflexive",
        IsHomalgSheaf );

##  <#GAPDoc Label="IsTorsionFree">
##  <ManSection>
##    <Prop Arg="E" Name="IsTorsionFree"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> is torsion-free.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsTorsionFree",
        IsHomalgSheaf );

##  <#GAPDoc Label="IsTorsion">
##  <ManSection>
##    <Prop Arg="E" Name="IsTorsion"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> is torsion.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsTorsion",
        IsHomalgSheaf );

##  <#GAPDoc Label="IsPure">
##  <ManSection>
##    <Prop Arg="E" Name="IsPure"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> is pure.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsPure",
        IsHomalgSheaf );

##  <#GAPDoc Label="FiniteLocallyFreeResolutionExists">
##  <ManSection>
##    <Prop Arg="E" Name="FiniteLocallyFreeResolutionExists"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> allows a finite locally free resolution. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "FiniteLocallyFreeResolutionExists",
        IsHomalgSheaf );

##  <#GAPDoc Label="HasConstantRank">
##  <ManSection>
##    <Prop Arg="E" Name="HasConstantRank"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> has constant rank. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "HasConstantRank",
        IsHomalgSheaf );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="StructureSheafOfProj">
##  <ManSection>
##    <Attr Arg="S" Name="StructureSheafOfProj"/>
##    <Returns>a sheaf of rings</Returns>
##    <Description>
##      The structure sheaf of <M>Proj(</M><A>S</A><M>)</M> of the &homalg; graded ring <A>S</A>.
##      The grading of <A>S</A> is determined by the attribute <C>WeightsOfIndeterminates</C>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "StructureSheafOfProj",
        IsHomalgRing );

## intrinsic attributes:
##
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
## should all be added by hand to LISHV.intrinsic_attributes
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

##  <#GAPDoc Label="RankOfSheaf">
##  <ManSection>
##    <Attr Arg="E" Name="RankOfSheaf"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The projective rank of the sheaf <A>E</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RankOfSheaf",
        IsHomalgSheaf );

##  <#GAPDoc Label="DegreeOfTorsionFreeness">
##  <ManSection>
##    <Attr Arg="E" Name="DegreeOfTorsionFreeness"/>
##    <Returns>a nonnegative integer or infinity</Returns>
##    <Description>
##      Auslander's degree of torsion-freeness of the sheaf <A>E</A>.
##      It is set to infinity only for <A>E</A><M>=0</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DegreeOfTorsionFreeness",
        IsHomalgSheaf );

##  <#GAPDoc Label="Codim">
##  <ManSection>
##    <Attr Arg="E" Name="Codim"/>
##    <Returns>a nonnegative integer or infinity</Returns>
##    <Description>
##      The codimension of the sheaf <A>E</A>.
##      It is set to infinity only for <A>E</A><M>=0</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Codim",
        IsHomalgSheaf );

##  <#GAPDoc Label="PurityFiltration">
##  <ManSection>
##    <Attr Arg="E" Name="PurityFiltration"/>
##    <Returns>a &homalg; filtration</Returns>
##    <Description>
##      The purity filtration of the sheaf <A>E</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "PurityFiltration",
        IsHomalgSheaf );

##  <#GAPDoc Label="CodegreeOfPurity">
##  <ManSection>
##    <Attr Arg="E" Name="CodegreeOfPurity"/>
##    <Returns>a list of nonnegative integers</Returns>
##    <Description>
##      The codegree of purity of the sheaf <A>E</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CodegreeOfPurity",
        IsHomalgSheaf );

##  <#GAPDoc Label="CastelnuovoMumfordRegularity">
##  <ManSection>
##    <Attr Arg="E" Name="CastelnuovoMumfordRegularity"/>
##    <Returns>a non-negative integer</Returns>
##    <Description>
##      The Castelnuovo-Mumford regularity of the sheaf <A>E</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CastelnuovoMumfordRegularity",
        IsHomalgSheaf );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "CreateSetOfUnderlyingModulesOfSheaf",
        [ IsHomalgModule ] );

DeclareOperation( "HomalgSheaf",
        [ IsHomalgModule ] );

DeclareOperation( "LeftSheaf",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "LeftSheaf",
        [ IsHomalgMatrix, IsInt ] );

DeclareOperation( "LeftSheaf",
        [ IsHomalgMatrix ] );

DeclareOperation( "RightSheaf",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "RightSheaf",
        [ IsHomalgMatrix, IsInt ] );

DeclareOperation( "RightSheaf",
        [ IsHomalgMatrix ] );

DeclareOperation( "DirectSumOfLeftLineBundles",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "DirectSumOfLeftLineBundles",
        [ IsInt, IsHomalgRing, IsInt ] );

DeclareOperation( "DirectSumOfLeftLineBundles",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "DirectSumOfRightLineBundles",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "DirectSumOfRightLineBundles",
        [ IsInt, IsHomalgRing, IsInt ] );

DeclareOperation( "DirectSumOfRightLineBundles",
        [ IsInt, IsHomalgRing ] );

DeclareOperation( "POW",
        [ IsHomalgSheafOfRings, IsInt ] );

DeclareOperation( "POW",
        [ IsHomalgSheafOfRings, IsList ] );

# basic operations:

DeclareOperation( "StructureSheafOfAmbientSpace",
        [ IsHomalgSheaf ] );

DeclareOperation( "DimensionOfAmbientSpace",
        [ IsHomalgSheaf ] );

DeclareOperation( "HomalgRing",
        [ IsHomalgSheafOfRings ] );

DeclareOperation( "PositionOfTheDefaultUnderlyingModule",
        [ IsHomalgSheaf ] );

DeclareOperation( "SetPositionOfTheDefaultUnderlyingModule",
        [ IsHomalgSheaf, IsInt ] );

DeclareOperation( "SetOfUnderlyingModules",
        [ IsHomalgSheaf ] );

DeclareOperation( "UnderlyingModule",
        [ IsHomalgSheaf, IsInt ] );

DeclareOperation( "UnderlyingModule",
        [ IsHomalgSheaf ] );

DeclareOperation( "homalgProjString",
        [ IsHomalgRing ] );

DeclareOperation( "GlobalSections",
        [ IsHomalgSheaf ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonymAttr( "IsVectorBundle",
        IsLocallyFree );

