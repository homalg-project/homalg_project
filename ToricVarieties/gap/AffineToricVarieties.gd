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
##      so everything applicable to toric varieties is applicable to affine toric varieties.
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

##  <#GAPDoc Label="ListOfVariablesOfCoordinateRing">
##  <ManSection>
##    <Attr Arg="vari" Name="ListOfVariablesOfCoordinateRing"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns a list containing the variables of the CoordinateRing of the variety <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ListOfVariablesOfCoordinateRing",
                  IsAffineToricVariety );

##  <#GAPDoc Label="MorphismFromCoordinateRingToCoordinateRingOfTorus">
##  <ManSection>
##    <Attr Arg="vari" Name="MorphismFromCoordinateRingToCoordinateRingOfTorus"/>
##    <Returns>a morphism</Returns>
##    <Description>
##      Returns the morphism between the coordinate ring of the variety <A>vari</A> and the coordinate ring of its torus.
##      This defines the embedding of the torus in the variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
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
##    <Oper Arg="vari,indet" Name="CoordinateRing" Label="for affine Varieties"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Computes the coordinate ring of the affine toric variety <A>vari</A> with indeterminates <A>indet</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "CoordinateRing",
                  [ IsToricVariety, IsList ] );

##  <#GAPDoc Label="ConeMethod">
##  <ManSection>
##    <Oper Arg="vari" Name="Cone"/>
##    <Returns>a cone</Returns>
##    <Description>
##      Returns the cone of the variety <A>vari</A>. Another name for ConeOfVariety for compatibility and shortness.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "Cone",
                  [ IsToricVariety ] );

#############################
##
## Constructors
##
#############################

## This is a fallback to not cause errors if ToricIdeals is not loaded

if not IsPackageMarkedForLoading( "ToricIdeals", ">=2011.01.01" ) then
    
    DeclareOperation( "GensetForToricIdeal",
                      [ IsMatrix ] );
    
fi;
