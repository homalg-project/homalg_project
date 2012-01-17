#############################################################################
##
##  ToricVariety.gd         ToricVarieties package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of toric Varieties
##
#############################################################################

#################################
##
## Global Variable
##
#################################

DeclareGlobalVariable( "TORIC_VARIETIES" );

#################################
##
## Categorys
##
#################################

##  <#GAPDoc Label="IsToricVariety">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsToricVariety"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of a toric variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsToricVariety",
                 IsObject );

#################################
##
## Properties
##
#################################

##  <#GAPDoc Label="IsNormalVariety">
##  <ManSection>
##    <Prop Arg="vari" Name="IsNormalVariety"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the toric variety <A>vari</A> is a normal variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsNormalVariety",
                  IsToricVariety );

##  <#GAPDoc Label="IsAffine">
##  <ManSection>
##    <Prop Arg="m" Name="IsAffine"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the toric variety <A>vari</A> is an affine variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsAffine",
                 IsToricVariety );

##  <#GAPDoc Label="IsProjective">
##  <ManSection>
##    <Prop Arg="vari" Name="IsProjective"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the toric variety <A>vari</A> is a projective variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsProjective",
                 IsToricVariety );

##  <#GAPDoc Label="IsSmooth">
##  <ManSection>
##    <Prop Arg="vari" Name="IsSmooth"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the toric variety <A>vari</A> is a smooth variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSmooth",
                 IsToricVariety );

##  <#GAPDoc Label="IsComplete">
##  <ManSection>
##    <Prop Arg="vari" Name="IsComplete"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the toric variety <A>vari</A> is a complete variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsComplete",
                 IsToricVariety );

##  <#GAPDoc Label="HasTorusfactor">
##  <ManSection>
##    <Prop Arg="vari" Name="HasTorusfactor"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the toric variety <A>vari</A> has a torus factor.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "HasTorusfactor",
                 IsToricVariety );

#################################
##
## Attributes
##
#################################

DeclareAttribute( "AffineOpenCovering",
                  IsToricVariety );

DeclareAttribute( "CoxRing",
                  IsToricVariety );

DeclareAttribute( "ClassGroup",
                  IsToricVariety );

DeclareAttribute( "PicardGroup",
                  IsToricVariety );

DeclareAttribute( "DivisorGroup",
                  IsToricVariety );

DeclareAttribute( "MapFromCharacterToPrincipalDivisor",
                  IsToricVariety );

DeclareAttribute( "Dimension",
                  IsToricVariety );

DeclareAttribute( "DimensionOfTorusfactor",
                  IsToricVariety );

DeclareAttribute( "CoordinateRingOfTorus",
                  IsToricVariety );

DeclareAttribute( "IsProductOf",
                  IsToricVariety );

DeclareAttribute( "CharacterGrid",
                  IsToricVariety );

DeclareAttribute( "PrimeDivisors",
                  IsToricVariety );

DeclareAttribute( "IrrelevantIdeal",
                  IsToricVariety );

DeclareAttribute( "MorphismFromCoxVariety",
                  IsToricVariety );

#################################
##
## Methods
##
#################################

DeclareOperation( "UnderlyingConvexObject",
                  [ IsToricVariety ] );

DeclareOperation( "UnderlyingSheaf",
                  [ IsToricVariety ] );

DeclareOperation( "CoordinateRingOfTorus",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "\*",
                  [ IsToricVariety, IsToricVariety ] );

DeclareOperation( "CharacterToRationalFunction",
                  [ IsHomalgElement, IsToricVariety ] );

DeclareOperation( "CharacterToRationalFunction",
                  [ IsList, IsToricVariety ] );

DeclareOperation( "CoxRing",
                  [ IsToricVariety, IsString ] );

#################################
##
## Constructors
##
#################################

DeclareOperation( "ToricVariety",
                  [ IsToricVariety ] );

DeclareOperation( "ToricVariety",
                  [ IsConvexObject ] );