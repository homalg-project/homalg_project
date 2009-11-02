#############################################################################
##
##  HomalgRelations.gd          homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for a set of relations.
##
#############################################################################

####################################
#
# categories:
#
####################################

# A new GAP-category:

##  <#GAPDoc Label="IsHomalgRelations">
##  <ManSection>
##    <Filt Type="Category" Arg="rel" Name="IsHomalgRelations"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; relations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgRelations",
        IsAttributeStoringRep );

## CAUTION: in the code the following two categories are the only ones for sets of generators,
##          i.e. IsHomalgRelations and not IsHomalgRelationsOfLeftModule => IsHomalgRelationsOfRightModule

##  <#GAPDoc Label="IsHomalgRelationsOfLeftModule">
##  <ManSection>
##    <Filt Type="Category" Arg="rel" Name="IsHomalgRelationsOfLeftModule"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; relations of a left module. <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgRelations</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgRelationsOfLeftModule",
        IsHomalgRelations );

##  <#GAPDoc Label="IsHomalgRelationsOfRightModule">
##  <ManSection>
##    <Filt Type="Category" Arg="rel" Name="IsHomalgRelationsOfRightModule"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; relations of a right module. <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgRelations</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgRelationsOfRightModule",
        IsHomalgRelations );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="CanBeUsedToDecideZeroEffectively">
##  <ManSection>
##    <Prop Arg="rel" Name="CanBeUsedToDecideZeroEffectively"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; set of relations <A>rel</A> can be used for normal form reductions. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "CanBeUsedToDecideZeroEffectively",
        IsHomalgRelations );

##  <#GAPDoc Label="IsInjectivePresentation">
##  <ManSection>
##    <Prop Arg="rel" Name="IsInjectivePresentation"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; set of relations <A>rel</A> has zero syzygies.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsInjectivePresentation",
        IsHomalgRelations );

##
DeclareProperty( "IsTorsion",
        IsHomalgRelations );

####################################
#
# attributes:
#
####################################

##
DeclareAttribute( "EvalMatrixOfRelations",
        IsHomalgRelations );

##
DeclareAttribute( "EvaluatedMatrixOfRelations",
        IsHomalgRelations );

##  <#GAPDoc Label="FreeResolution">
##  <ManSection>
##    <Attr Arg="rel" Name="FreeResolution"/>
##    <Returns>a &homalg; complex</Returns>
##    <Description>
##      The computed (part of a) free resolution of the module presented by &homalg; set of relations <A>rel</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "FreeResolution",
        IsHomalgRelations );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "HomalgRelationsForLeftModule" );

DeclareGlobalFunction( "HomalgRelationsForRightModule" );

# basic operations:

DeclareOperation( "DegreesOfGenerators",
        [ IsHomalgRelations ] );

DeclareOperation( "MatrixOfRelations",
        [ IsHomalgRelations ] );

DeclareOperation( "HomalgRing",
        [ IsHomalgRelations ] );

DeclareOperation( "HasNrGenerators",
        [ IsHomalgRelations ] );

DeclareOperation( "NrGenerators",
        [ IsHomalgRelations ] );

DeclareOperation( "HasNrRelations",
        [ IsHomalgRelations ] );

DeclareOperation( "NrRelations",
        [ IsHomalgRelations ] );

DeclareOperation( "CertainRelations",
        [ IsHomalgRelations, IsList ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgRelations, IsHomalgRelations ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgMatrix, IsHomalgRelations ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgRelations, IsHomalgMatrix ] );

DeclareOperation( "BasisOfModule",
        [ IsHomalgRelations ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMatrix, IsHomalgRelations ] );

DeclareOperation( "DecideZero",
        [ IsHomalgRelations, IsHomalgRelations ] );

DeclareOperation( "BasisCoeff",
        [ IsHomalgRelations ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgRelations ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgMatrix, IsHomalgRelations ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsHomalgRelations ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsHomalgMatrix, IsHomalgRelations ] );

DeclareOperation( "NonZeroGenerators",
        [ IsHomalgRelations ] );

DeclareOperation( "GetRidOfObsoleteRelations",
        [ IsHomalgRelations ] );

DeclareOperation( "GetIndependentUnitPositions",
        [ IsHomalgRelations, IsHomogeneousList ] );

DeclareOperation( "GetIndependentUnitPositions",
        [ IsHomalgRelations ] );

DeclareOperation( "POW",
        [ IsHomalgRelations, IsHomalgMatrix ] );

DeclareOperation( "*",
        [ IsHomalgRelations, IsHomalgMatrix ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonym ( "Reduce",
        DecideZero );

DeclareSynonym ( "BetterBasis",
        GetRidOfObsoleteRelations );

