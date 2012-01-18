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
                  [ IsAffineToricVariety, IsList ] );

DeclareOperation( "CoordinateRing",
                  [ IsToricVariety, IsList ] );

##  <#GAPDoc Label="FanToConeRep">
##  <ManSection>
##    <Oper Arg="vari" Name="FanToConeRep"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Changes the representation of the affine variety vari <A>vari</A> to a representation with a cone.
##      This makes it possible to compute a coordinate ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "FanToConeRep",
                  [ IsToricVariety ] );

##  <#GAPDoc Label="ConeToFanRep">
##  <ManSection>
##    <Oper Arg="vari" Name="FanToConeRep"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Changes the representation of <A>vari</A> to a fan rep.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "ConeToFanRep",
                  [ IsToricVariety ] );


#############################
##
## Constructors
##
#############################
