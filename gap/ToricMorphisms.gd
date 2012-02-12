#############################################################################
##
##  ToricMorphisms.gd         ToricVarieties         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Morphisms for toric varieties
##
#############################################################################

##  <#GAPDoc Label="IsToricMorphism">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsToricMorphism"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of toric morphisms. A toric morphism is defined by a grid
##      homomorphism, which is compatible with the fan structure of the two varieties.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsToricMorphism",
                 IsObject );

###############################
##
## Properties
##
###############################

##  <#GAPDoc Label="IsMorphism">
##  <ManSection>
##    <Prop Arg="morph" Name="IsMorphism"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the grid morphism <A>morph</A> respects the fan structure.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsMorphism",
                 IsToricMorphism );

##  <#GAPDoc Label="IsProper">
##  <ManSection>
##    <Prop Arg="morph" Name="IsProper"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the defined morphism <A>morph</A> is proper.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsProper",
                 IsToricMorphism );

###############################
##
## Attributes
##
###############################

##  <#GAPDoc Label="SourceObject">
##  <ManSection>
##    <Attr Arg="morph" Name="SourceObject"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Returns the source object of the morphism <A>morph</A>. This attribute is a must have.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "SourceObject",
                  IsToricMorphism );

##  <#GAPDoc Label="UnderlyingGridMorphism">
##  <ManSection>
##    <Attr Arg="morph" Name="UnderlyingGridMorphism"/>
##    <Returns>a map</Returns>
##    <Description>
##      Returns the grid map which defines <A>morph</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingGridMorphism",
                  IsToricMorphism );

##  <#GAPDoc Label="ToricImageObject">
##  <ManSection>
##    <Attr Arg="morph" Name="ToricImageObject"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Returns the variety which is created by the fan which is the image of the fan of the source of <A>morph</A>.
##      This is not an image in the usual sense, but a toric image.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ToricImageObject",
                  IsToricMorphism );

##  <#GAPDoc Label="RangeObject">
##  <ManSection>
##    <Attr Arg="morph" Name="RangeObject"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Returns the range of the morphism <A>morph</A>. If no range is given
##      (yes, this is possible), the method returns the image.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RangeObject",
                  IsToricMorphism );

##  <#GAPDoc Label="MorphismOnWeilDivisorGroup">
##  <ManSection>
##    <Attr Arg="morph" Name="MorphismOnWeilDivisorGroup"/>
##    <Returns>a morphism</Returns>
##    <Description>
##      Returns the associated morphism between the divisor group of the range of <A>morph</A>
##      and the divisor group of the source.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "MorphismOnWeilDivisorGroup",
                  IsToricMorphism );

###############################
##
## Methods
##
###############################

##  <#GAPDoc Label="UnderlyingListList">
##  <ManSection>
##    <Attr Arg="morph" Name="UnderlyingListList"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns a list of list which represents the grid homomorphism.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "UnderlyingListList",
                  [ IsToricMorphism ] );

###############################
##
## Constructors
##
###############################

##  <#GAPDoc Label="ToricMorphism">
##  <ManSection>
##    <Oper Arg="vari,lis" Name="ToricMorphism"/>
##    <Returns>a morphism</Returns>
##    <Description>
##      Returns the toric morphism with source <A>vari</A> which is represented by the matrix <A>lis</A>.
##      The range is set to the image.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "ToricMorphism",
                  [ IsToricVariety, IsList ] );

##  <#GAPDoc Label="ToricMorphism2">
##  <ManSection>
##    <Oper Arg="vari,lis,vari2" Name="ToricMorphism"/>
##    <Returns>a morphism</Returns>
##    <Description>
##      Returns the toric morphism with source <A>vari</A> and range <A>vari2</A> which is represented by the matrix <A>lis</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "ToricMorphism",
                  [ IsToricVariety, IsList, IsToricVariety ] );
