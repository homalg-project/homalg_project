#############################################################################
##
##  ProjectiveToricVariety.gd         ToricVarieties package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of projective toric Varieties
##
#############################################################################

##  <#GAPDoc Label="IsProjectiveToricVariety">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsProjectiveToricVariety"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of a projective toric variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsProjectiveToricVariety",
                 IsToricVariety );

###################################
##
## Attribute
##
###################################


##  <#GAPDoc Label="PolytopeOfVariety">
##  <ManSection>
##    <Attr Arg="vari" Name="PolytopeOfVariety"/>
##    <Returns>a polytope</Returns>
##    <Description>
##      Returns the polytope corresponding to the projective toric variety <A>vari</A>, if it exists.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "PolytopeOfVariety",
                  IsToricVariety );

##  <#GAPDoc Label="AffineCone">
##  <ManSection>
##    <Attr Arg="vari" Name="AffineCone"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Returns the affine cone of the projective toric variety <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AffineCone",
                  IsToricVariety );

##  <#GAPDoc Label="ProjectiveEmbedding">
##  <ManSection>
##    <Attr Arg="vari" Name="ProjectiveEmbedding"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns characters for a closed embedding in an projective space for the projective toric variety <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ProjectiveEmbedding",
                  IsToricVariety );

###################################
##
## Constructors
##
###################################
