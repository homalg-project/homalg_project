#############################################################################
##
##  AffineToricVariety.gd     ToricVarieties package       Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of affine toric Varieties
##
#############################################################################


##  <#GAPDoc Label="IsAffineToricVariety">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsAffineToricVariety"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of an affine toric variety. All affine toric varieties are toric varieties,
##      so everything applicable to toric vatieties is applicable to affine toric varieties.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsAffineToricVariety",
                 IsToricVariety );

#############################
##
## Properties
##
#############################


#############################
##
## Attributes
##
#############################

##  <#GAPDoc Label="CoordinateRing">
##  <ManSection>
##    <Attr Arg="vari" Name="CoordinateRing"/>
##    <Returns>a ring</Returns>
##    <Description>
##      Returns the coordinate ring of the affine toric variety <A>vari</A>. The computation is mainly done in ToricIdeals package.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CoordinateRing",
                  IsAffineToricVariety );

DeclareAttribute( "ListOfVariablesOfCoordinateRing",
                  IsAffineToricVariety );

DeclareAttribute( "MorphismFromCoordinateRingToCoordinateRingOfTorus",
                  IsToricVariety );

##  <#GAPDoc Label="ConeOfVariety">
##  <ManSection>
##    <Attr Arg="vari" Name="ConeOfVariety"/>
##    <Returns>a cone</Returns>
##    <Description>
##      Returns the cone ring of the affine toric variety <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ConeOfVariety",
                  IsToricVariety );

#############################
##
## Methods
##
#############################

##  <#GAPDoc Label="CoordinateRing2">
##  <ManSection>
##    <Oper Arg="vari,indet" Name="CoordinateRing"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Computes the coordinate ring of the affine toric variety <A>vari</A> with indeterminates <A>indet</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "CoordinateRing",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "Cone",
                  [ IsToricVariety ] );

#############################
##
## Constructors
##
#############################
