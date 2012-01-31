#############################################################################
##
##  ToricSubvariety.gd         ToricVarieties package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of toric Subvarieties
##
#############################################################################

##  <#GAPDoc Label="IsToricSubvariety">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsToricSubvariety"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of a toric subvariety. Every toric subvariety is a toric variety,
##      so every method applicable to toric varieties is also applicable to toric subvarieties.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsToricSubvariety",
                 IsToricVariety );

#################################
##
## Properties
##
#################################

##  <#GAPDoc Label="IsClosed">
##  <ManSection>
##    <Prop Arg="vari" Name="IsClosed"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the subvariety <A>vari</A> is a closed subset of its ambient variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsClosed",
                 IsToricSubvariety );

##  <#GAPDoc Label="IsOpen">
##  <ManSection>
##    <Prop Arg="vari" Name="IsOpen"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if a subvariety is a closed subset.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsOpen",
                 IsToricSubvariety );

##  <#GAPDoc Label="IsWholeVariety">
##  <ManSection>
##    <Prop Arg="vari" Name="IsWholeVariety"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Returns true if the subvariety <A>vari</A> is the whole variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsWholeVariety",
                 IsToricSubvariety );

################################
##
## Attributes
##
################################

##  <#GAPDoc Label="UnderlyingToricVariety">
##  <ManSection>
##    <Attr Arg="vari" Name="UnderlyingToricVariety"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Returns the toric variety which is represented by <A>vari</A>. This
##      method implements the forgetful functor subvarieties -> varieties.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingToricVariety",
                  IsToricSubvariety );

##  <#GAPDoc Label="InclusionMorphism">
##  <ManSection>
##    <Attr Arg="vari" Name="InclusionMorphism"/>
##    <Returns>a morphism</Returns>
##    <Description>
##      If the variety <A>vari</A> is an open subvariety, this method returns
##      the inclusion morphism in its ambient variety. If not, it will fail.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "InclusionMorphism",
                  IsToricSubvariety );

##  <#GAPDoc Label="AmbientToricVariety">
##  <ManSection>
##    <Attr Arg="vari" Name="AmbientToricVariety"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Returns the ambient toric variety of the subvariety <A>vari</A>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AmbientToricVariety",
                  IsToricSubvariety );

################################
##
## Methods
##
################################

##  <#GAPDoc Label="ClosureOfTorusOrbitOfCone">
##  <ManSection>
##    <Oper Arg="vari,cone" Name="ClosureOfTorusOrbitOfCone"/>
##    <Returns>a subvariety</Returns>
##    <Description>
##      The method returns the closure of the orbit of the torus contained in <A>vari</A> which corresponds to the cone <A>cone</A>
##      as a closed subvariety of <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "ClosureOfTorusOrbitOfCone",
                  [ IsToricVariety, IsCone ] );

################################
##
## Constructors
##
################################

##  <#GAPDoc Label="ToricSubvariety">
##  <ManSection>
##    <Oper Arg="vari,ambvari" Name="ToricSubvariety"/>
##    <Returns>a subvariety</Returns>
##    <Description>
##      The method returns the closure of the orbit of the torus contained in <A>vari</A> which corresponds to the cone <A>cone</A>
##      as a closed subvariety of <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "ToricSubvariety",
                  [ IsToricVariety, IsToricVariety ] );
