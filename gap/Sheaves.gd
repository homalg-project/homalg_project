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

##  <#GAPDoc Label="IsHomalgSheaf">
##  <ManSection>
##    <Filt Type="Category" Arg="O" Name="IsHomalgSheaf"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaves. <P/>
##      (It is a subcategory of the &GAP; category
##      <C>IsHomalgRingOrObject</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgSheaf",
        IsHomalgRingOrObject );

##  <#GAPDoc Label="IsSheafOfRings">
##  <ManSection>
##    <Filt Type="Category" Arg="O" Name="IsSheafOfRings"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaves of rings. <P/>
##      (It is a subcategory of the &GAP; category
##      <C>IsHomalgSheaf</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsSheafOfRings",
        IsHomalgSheaf );

##  <#GAPDoc Label="IsSheafOfModules">
##  <ManSection>
##    <Filt Type="Category" Arg="E" Name="IsSheafOfModules"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaves. <P/>
##      (It is a subcategory of the &GAP; categories
##      <C>IsHomalgSheaf</C> and <C>IsHomalgObject</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsSheafOfModules",
        IsHomalgSheaf and IsHomalgObject );

##  <#GAPDoc Label="IsSheafMap">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsSheafOfModulesMap"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaf maps. <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgMorphism</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsSheafOfModulesMap",
        IsHomalgMorphism );

##  <#GAPDoc Label="IsSheafSelfMap">
##  <ManSection>
##    <Filt Type="Category" Arg="phi" Name="IsSheafSelfMap"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of sheaf self-maps. <P/>
##      (It is a subcategory of the &GAP; categories
##       <C>IsSheafOfModulesMap</C> and <C>IsHomalgEndomorphism</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsSheafSelfMap",
        IsSheafOfModulesMap and
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
        IsSheafOfModules );

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
        IsSheafOfModules );

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
        IsSheafOfModules );

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
        IsSheafOfModules );

##  <#GAPDoc Label="IsReflexive">
##  <ManSection>
##    <Prop Arg="E" Name="IsReflexive"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> is reflexive.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsTorsionFree">
##  <ManSection>
##    <Prop Arg="E" Name="IsTorsionFree"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> is torsion-free.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsTorsion">
##  <ManSection>
##    <Prop Arg="E" Name="IsTorsion"/>
##    <Returns>true or false</Returns>
##    <Description>
##      Check if the sheaf <A>E</A> is torsion.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

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
        IsSheafOfModules );

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
        IsSheafOfModules );

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
        IsSheafOfModules );

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

##  <#GAPDoc Label="IdealSheaf:sheaf">
##  <ManSection>
##    <Attr Arg="O" Name="IdealSheaf" Label="for structure sheaves"/>
##    <Returns>a sheaf</Returns>
##    <Description>
##      The sheaf of ideals <M>Proj(J)</M> of the &homalg; graded ideal <A>J</A>, where <A>O</A><M>=Proj(S/J)</M>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IdealSheaf",
        IsSheafOfRings );

##  <#GAPDoc Label="AsModuleOverStructureSheafOfAmbientSpace">
##  <ManSection>
##    <Attr Arg="O" Name="AsModuleOverStructureSheafOfAmbientSpace"/>
##    <Returns>a sheaf</Returns>
##    <Description>
##      The sheaf of modules <A>O</A> regarded as a sheaf of modules over the structure sheaf of the ambient space.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AsModuleOverStructureSheafOfAmbientSpace",
        IsSheafOfRings );

##  <#GAPDoc Label="Support">
##  <ManSection>
##    <Attr Arg="E" Name="Support"/>
##    <Returns>a scheme</Returns>
##    <Description>
##      The support of the sheaf <A>E</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Support",
        IsHomalgSheaf );

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
        IsSheafOfModules );

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
        IsSheafOfModules );

##  <#GAPDoc Label="AbsoluteDepth">
##  <ManSection>
##    <Attr Arg="E" Name="AbsoluteDepth"/>
##    <Returns>a nonnegative integer or infinity</Returns>
##    <Description>
##      The depth of the sheaf <A>E</A>.
##      It is set to infinity only for <A>E</A><M>=0</M>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

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
        IsSheafOfModules );

##  <#GAPDoc Label="CodegreeOfPurity">
##  <ManSection>
##    <Attr Arg="E" Name="CodegreeOfPurity"/>
##    <Returns>a list of nonnegative integers</Returns>
##    <Description>
##      The codegree of purity of the sheaf <A>E</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

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
        IsSheafOfModules );

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
        [ IsSheafOfRings, IsInt ] );

DeclareOperation( "POW",
        [ IsSheafOfRings, IsList ] );

# basic operations:

DeclareOperation( "StructureSheafOfAmbientSpace",
        [ IsSheafOfModules ] );

DeclareOperation( "DimensionOfAmbientSpace",
        [ IsSheafOfModules ] );

DeclareOperation( "HomalgRing",
        [ IsSheafOfRings ] );

DeclareOperation( "PositionOfTheDefaultUnderlyingModule",
        [ IsSheafOfModules ] );

DeclareOperation( "SetPositionOfTheDefaultUnderlyingModule",
        [ IsSheafOfModules, IsInt ] );

DeclareOperation( "SetOfUnderlyingModules",
        [ IsSheafOfModules ] );

DeclareOperation( "UnderlyingModule",
        [ IsSheafOfModules, IsInt ] );

DeclareOperation( "UnderlyingModule",
        [ IsSheafOfModules ] );

DeclareOperation( "homalgProjString",
        [ IsHomalgRing ] );

DeclareOperation( "GlobalSections",
        [ IsSheafOfModules ] );

DeclareOperation( "InducedMorphismToProjectiveSpace",
        [ IsSheafOfModules ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonymAttr( "IsVectorBundle",
        IsLocallyFree );

