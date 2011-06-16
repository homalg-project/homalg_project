#############################################################################
##
##  HomalgRingRelations.gd      MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, RWTH-Aachen University
##
##  Declaration stuff for a set of ring relations.
##
#############################################################################

####################################
#
# categories:
#
####################################

# A new GAP-category:

##  <#GAPDoc Label="IsHomalgRingRelations">
##  <ManSection>
##    <Filt Type="Category" Arg="rel" Name="IsHomalgRingRelations"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; ring relations.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgRingRelations",
        IsAttributeStoringRep );

## CAUTION: in the code the following two categories are the only ones for sets of ring relations,
##          i.e. IsHomalgRingRelations and not IsHomalgRingRelationsAsGeneratorsOfLeftIdeal => IsHomalgRingRelationsAsGeneratorsOfRightIdeal

##  <#GAPDoc Label="IsHomalgRingRelationsAsGeneratorsOfLeftIdeal">
##  <ManSection>
##    <Filt Type="Category" Arg="rel" Name="IsHomalgRingRelationsAsGeneratorsOfLeftIdeal"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; relations of a left module. <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgRingRelations</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgRingRelationsAsGeneratorsOfLeftIdeal",
        IsHomalgRingRelations );

##  <#GAPDoc Label="IsHomalgRingRelationsAsGeneratorsOfRightIdeal">
##  <ManSection>
##    <Filt Type="Category" Arg="rel" Name="IsHomalgRingRelationsAsGeneratorsOfRightIdeal"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; relations of a right module. <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgRingRelations</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgRingRelationsAsGeneratorsOfRightIdeal",
        IsHomalgRingRelations );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="CanBeUsedToDecideZero">
##  <ManSection>
##    <Prop Arg="rel" Name="CanBeUsedToDecideZero"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; set of relations <A>rel</A> can be used for normal form reductions. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "CanBeUsedToDecideZero",
        IsHomalgRingRelations );

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
        IsHomalgRingRelations );

####################################
#
# attributes:
#
####################################

##
DeclareAttribute( "EvalMatrixOfRingRelations",
        IsHomalgRingRelations );

##
DeclareAttribute( "EvaluatedMatrixOfRingRelations",
        IsHomalgRingRelations );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "HomalgRingRelationsAsGeneratorsOfLeftIdeal" );

DeclareGlobalFunction( "HomalgRingRelationsAsGeneratorsOfRightIdeal" );

# basic operations:

DeclareOperation( "DegreesOfGenerators",
        [ IsHomalgRingRelations ] );

DeclareOperation( "MatrixOfRelations",
        [ IsHomalgRingRelations ] );

DeclareOperation( "HomalgRing",
        [ IsHomalgRingRelations ] );

DeclareOperation( "HasNrRelations",
        [ IsHomalgRingRelations ] );

DeclareOperation( "NrRelations",
        [ IsHomalgRingRelations ] );

DeclareOperation( "CertainRelations",
        [ IsHomalgRingRelations, IsList ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgRingRelations, IsHomalgRingRelations ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgMatrix, IsHomalgRingRelations ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgRingRelations, IsHomalgMatrix ] );

DeclareOperation( "BasisOfModule",
        [ IsHomalgRingRelations ] );

DeclareOperation( "DecideZero",
        [ IsHomalgRingRelations, IsHomalgRingRelations ] );

DeclareOperation( "BasisCoeff",
        [ IsHomalgRingRelations ] );

DeclareOperation( "RightDivide",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgRingRelations ] );

DeclareOperation( "LeftDivide",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgRingRelations ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgRingRelations ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgMatrix, IsHomalgRingRelations ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsHomalgRingRelations ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsHomalgMatrix, IsHomalgRingRelations ] );

DeclareOperation( "NonZeroGenerators",
        [ IsHomalgRingRelations ] );

DeclareOperation( "GetRidOfObsoleteRelations",
        [ IsHomalgRingRelations ] );

DeclareOperation( "POW",
        [ IsHomalgRingRelations, IsHomalgMatrix ] );

DeclareOperation( "*",
        [ IsHomalgRing, IsHomalgRingRelations ] );

DeclareOperation( "*",
        [ IsHomalgRingRelations, IsHomalgRing ] );
