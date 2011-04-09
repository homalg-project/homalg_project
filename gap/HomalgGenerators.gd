#############################################################################
##
##  HomalgGenerators.gd         Modules package              Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for a set of generators.
##
#############################################################################

####################################
#
# categories:
#
####################################

# three new GAP-categories:

##  <#GAPDoc Label="IsHomalgGenerators">
##  <ManSection>
##    <Filt Type="Category" Arg="rel" Name="IsHomalgGenerators"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; generators.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgGenerators",
        IsAttributeStoringRep );

## CAUTION: in the code the following two categories are the only ones for sets of generators,
##          i.e. IsHomalgGenerators and not IsHomalgGeneratorsOfLeftModule => IsHomalgGeneratorsOfRightModule

##  <#GAPDoc Label="IsHomalgGeneratorsOfLeftModule">
##  <ManSection>
##    <Filt Type="Category" Arg="rel" Name="IsHomalgGeneratorsOfLeftModule"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; generators of a left module. <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgGenerators</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgGeneratorsOfLeftModule",
        IsHomalgGenerators );

##  <#GAPDoc Label="IsHomalgGeneratorsOfRightModule">
##  <ManSection>
##    <Filt Type="Category" Arg="rel" Name="IsHomalgGeneratorsOfRightModule"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; generators of a right module. <P/>
##      (It is a subcategory of the &GAP; category <C>IsHomalgGenerators</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgGeneratorsOfRightModule",
        IsHomalgGenerators );

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsReduced">
##  <ManSection>
##    <Prop Arg="gen" Name="IsReduced"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; set of generators <A>gen</A> is marked reduced. <Br/>
##      (no method installed)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsReduced",
        IsHomalgGenerators );

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="ProcedureToNormalizeGenerators">
##  <ManSection>
##    <Attr Arg="gen" Name="ProcedureToNormalizeGenerators"/>
##    <Returns>a function</Returns>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ProcedureToNormalizeGenerators",
        IsHomalgGenerators );

##  <#GAPDoc Label="ProcedureToReadjustGenerators">
##  <ManSection>
##    <Attr Arg="gen" Name="ProcedureToReadjustGenerators"/>
##    <Returns>a function</Returns>
##    <Description>
##      A function that takes the rows/columns of <A>gen</A> and returns an object (e.g. a matrix) that
##      can be interpreted as a generator (this is important for modules of homomorphisms).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ProcedureToReadjustGenerators",
        IsHomalgGenerators );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "HomalgGeneratorsForLeftModule" );

DeclareGlobalFunction( "HomalgGeneratorsForRightModule" );

DeclareOperation( "RingMap",
        [ IsHomalgGenerators, IsHomalgRing, IsHomalgRing ] );

# basic operations:

DeclareOperation( "MatrixOfGenerators",
        [ IsHomalgGenerators ] );

DeclareOperation( "HomalgRing",
        [ IsHomalgGenerators ] );

DeclareOperation( "RelationsOfHullModule",
        [ IsHomalgGenerators ] );

DeclareOperation( "HasNrRelations",
        [ IsHomalgGenerators ] );

DeclareOperation( "NrRelations",
        [ IsHomalgGenerators ] );

DeclareOperation( "MatrixOfRelations",
        [ IsHomalgGenerators ] );

DeclareOperation( "HasNrGenerators",
        [ IsHomalgGenerators ] );

DeclareOperation( "NrGenerators",
        [ IsHomalgGenerators ] );

DeclareOperation( "CertainGenerators",
        [ IsHomalgGenerators, IsList ] );

DeclareOperation( "CertainGenerator",
        [ IsHomalgGenerators, IsPosInt ] );

DeclareOperation( "NewHomalgGenerators",
        [ IsHomalgMatrix, IsHomalgGenerators ] );

DeclareOperation( "UnionOfRelations",
        [ IsHomalgGenerators, IsHomalgRelations ] );

DeclareOperation( "BasisOfModule",
        [ IsHomalgGenerators ] );

DeclareOperation( "DecideZero",
        [ IsHomalgGenerators ] );

DeclareOperation( "DecideZero",
        [ IsHomalgGenerators, IsHomalgRelations ] );

DeclareOperation( "SyzygiesGenerators",
        [ IsHomalgGenerators, IsHomalgRelations ] );

DeclareOperation( "ReducedSyzygiesGenerators",
        [ IsHomalgGenerators, IsHomalgRelations ] );

DeclareOperation( "GetRidOfObsoleteGenerators",
        [ IsHomalgGenerators ] );

DeclareOperation( "*",
        [ IsHomalgMatrix, IsHomalgGenerators ] );

DeclareOperation( "*",
        [ IsHomalgGenerators, IsHomalgGenerators ] );

DeclareOperation( "*",
        [ IsHomalgRelations, IsHomalgGenerators ] );

