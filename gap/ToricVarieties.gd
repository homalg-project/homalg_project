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

##  <#GAPDoc Label="twitter">
##  <ManSection>
##    <Attr Arg="vari" Name="twitter"/>
##    <Returns>a ring</Returns>
##    <Description>
##      This is a dummy to get immediate methods triggered at some times.
##      It never has a value.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "twitter",
                  IsToricVariety );

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
##    <Prop Arg="vari" Name="IsAffine"/>
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

##  <#GAPDoc Label="HasNoTorusfactor">
##  <ManSection>
##    <Prop Arg="vari" Name="HasNoTorusfactor"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the toric variety <A>vari</A> has no torus factor.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "HasNoTorusfactor",
                 IsToricVariety );

##  <#GAPDoc Label="IsOrbifold">
##  <ManSection>
##    <Prop Arg="vari" Name="IsOrbifold"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the toric variety <A>vari</A> has an orbifold, which is, in the toric case, equivalent
##      to the simpliciality of the fan.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsOrbifold",
                 IsToricVariety );

#################################
##
## Attributes
##
#################################

##  <#GAPDoc Label="AffineOpenCovering">
##  <ManSection>
##    <Attr Arg="vari" Name="AffineOpenCovering"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns a torus invariant affine open covering of the variety <A>vari</A>.
##      The affine open cover is computed out of the cones of the fan.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AffineOpenCovering",
                  IsToricVariety );

##  <#GAPDoc Label="CoxRing">
##  <ManSection>
##    <Attr Arg="vari" Name="CoxRing"/>
##    <Returns>a ring</Returns>
##    <Description>
##      Returns the Cox ring of the variety <A>vari</A>. The actual method requires
##      a string with a name for the variables. A method for computing the Cox ring without
##      a variable given is not implemented. You will get an error.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CoxRing",
                  IsToricVariety );

DeclareAttribute( "ListOfVariablesOfCoxRing",
                  IsToricVariety );

##  <#GAPDoc Label="ClassGroup">
##  <ManSection>
##    <Attr Arg="vari" Name="ClassGroup"/>
##    <Returns>a module</Returns>
##    <Description>
##      Returns the class group of the variety <A>vari</A> as factor of a free module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ClassGroup",
                  IsToricVariety );

##  <#GAPDoc Label="TorusInvariantDivisorGroup">
##  <ManSection>
##    <Attr Arg="vari" Name="TorusInvariantDivisorGroup"/>
##    <Returns>a module</Returns>
##    <Description>
##      Returns the subgroup of the Weil divisor group of the variety <A>vari</A> generated by the torus invariant prime divisors.
##      This is always a finitely generated free module over the integers. 
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "TorusInvariantDivisorGroup",
                  IsToricVariety );

##  <#GAPDoc Label="MapFromCharacterToPrincipalDivisor">
##  <ManSection>
##    <Attr Arg="vari" Name="MapFromCharacterToPrincipalDivisor"/>
##    <Returns>a morphism</Returns>
##    <Description>
##    Returns a map which maps an element of the character group into the torus invariant Weil group of the variety <A>vari</A>.
##    This has to viewn as an help method to compute divisor classes.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "MapFromCharacterToPrincipalDivisor",
                  IsToricVariety );

##  <#GAPDoc Label="Dimension">
##  <ManSection>
##    <Attr Arg="vari" Name="Dimension"/>
##    <Returns>an integer</Returns>
##    <Description>
##    Returns the dimension of the variety <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Dimension",
                  IsToricVariety );

##  <#GAPDoc Label="DimensionOfTorusfactor">
##  <ManSection>
##    <Attr Arg="vari" Name="DimensionOfTorusfactor"/>
##    <Returns>an integer</Returns>
##    <Description>
##    Returns the dimension of the torusfactor of the variety <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DimensionOfTorusfactor",
                  IsToricVariety );

##  <#GAPDoc Label="CoordinateRingOfTorus">
##  <ManSection>
##    <Attr Arg="vari" Name="CoordinateRingOfTorus"/>
##    <Returns>a ring</Returns>
##    <Description>
##    Returns the coordinatering of the torus of the variety <A>vari</A>.
##    This method is not implemented, you need to call it with a second argument, which is a list of strings for the variables of the ring.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CoordinateRingOfTorus",
                  IsToricVariety );

DeclareAttribute( "ListOfVariablesOfCoordinateRingOfTorus",
                  IsToricVariety );

##  <#GAPDoc Label="IsProductOf">
##  <ManSection>
##    <Attr Arg="vari" Name="IsProductOf"/>
##    <Returns>a list</Returns>
##    <Description>
##    If the variety <A>vari</A> is a product of 2 or more varieties, the list contain those varieties.
##    If it is not a product or at least not generated as a product, the list only contains the variety itself.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IsProductOf",
                  IsToricVariety );

##  <#GAPDoc Label="CharacterGrid">
##  <ManSection>
##    <Attr Arg="vari" Name="CharacterGrid"/>
##    <Returns>a module</Returns>
##    <Description>
##    The method returns the character grid of the variety <A>vari</A>, computed as the containing grid of the underlying convex object, if it exists.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CharacterGrid",
                  IsToricVariety );

##  <#GAPDoc Label="TorusInvariantPrimeDivisors">
##  <ManSection>
##    <Attr Arg="vari" Name="TorusInvariantPrimeDivisors"/>
##    <Returns>a list</Returns>
##    <Description>
##    The method returns a list of the torus invariant prime divisors of the variety <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "TorusInvariantPrimeDivisors",
                  IsToricVariety );

##  <#GAPDoc Label="IrrelevantIdeal">
##  <ManSection>
##    <Attr Arg="vari" Name="IrrelevantIdeal"/>
##    <Returns>an ideal</Returns>
##    <Description>
##    Returns the irelevant ideal of the cox ring of the variety <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IrrelevantIdeal",
                  IsToricVariety );

##  <#GAPDoc Label="MorphismFromCoxVariety">
##  <ManSection>
##    <Attr Arg="vari" Name="MorphismFromCoxVariety"/>
##    <Returns>a morphism</Returns>
##    <Description>
##    The method returns the quotient morphism from the variety of the Cox ring to the variety <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "MorphismFromCoxVariety",
                  IsToricVariety );

##  <#GAPDoc Label="CoxVariety">
##  <ManSection>
##    <Attr Arg="vari" Name="CoxVariety"/>
##    <Returns>a variety</Returns>
##    <Description>
##    The method returns the Cox variety of the variety <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CoxVariety",
                  IsToricVariety );

##  <#GAPDoc Label="FanOfVariety">
##  <ManSection>
##    <Attr Arg="vari" Name="FanOfVariety"/>
##    <Returns>a fan</Returns>
##    <Description>
##    Returns the fan of the variety <A>vari</A>. This is set by default.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "FanOfVariety",
                  IsToricVariety );

##  <#GAPDoc Label="CartierTorusInvariantDivisorGroup">
##  <ManSection>
##    <Attr Arg="vari" Name="CartierTorusInvariantDivisorGroup"/>
##    <Returns>a module</Returns>
##    <Description>
##    Returns the the group of cartier divisors of the variety <A>vari</A> as a subgroup of the divisor group.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CartierTorusInvariantDivisorGroup",
                  IsToricVariety );

##  <#GAPDoc Label="PicardGroup">
##  <ManSection>
##    <Attr Arg="vari" Name="PicardGroup"/>
##    <Returns>a module</Returns>
##    <Description>
##      Returns the Picard group of the variety <A>vari</A> as factor of a free module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "PicardGroup",
                  IsToricVariety );


#################################
##
## Methods
##
#################################

##  <#GAPDoc Label="UnderlyingSheaf">
##  <ManSection>
##    <Oper Arg="vari" Name="UnderlyingSheaf"/>
##    <Returns>a sheaf</Returns>
##    <Description>
##    The method returns the underlying sheaf of the variety <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "UnderlyingSheaf",
                  [ IsToricVariety ] );

##  <#GAPDoc Label="CoordinateRingOfTorus2">
##  <ManSection>
##    <Oper Arg="vari,vars" Name="CoordinateRingOfTorus"/>
##    <Returns>a ring</Returns>
##    <Description>
##    Computes the coordinate ring of the torus of the variety <A>vari</A> with the variables <A>vars</A>. The argument <A>vars</A> need to be a
##    list of strings with lenght dimension or two times dimension.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "CoordinateRingOfTorus",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "CoordinateRingOfTorus",
                  [ IsToricVariety, IsStringRep ] );

##  <#GAPDoc Label="PROD">
##  <ManSection>
##    <Oper Arg="vari1,vari2" Name="\*"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Computes the categorian product of the varieties <A>vari1</A> and <A>vari2</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "\*",
                  [ IsToricVariety, IsToricVariety ] );

##  <#GAPDoc Label="CharacterToRationalFunction">
##  <ManSection>
##    <Oper Arg="elem,vari" Name="CharacterToRationalFunction"/>
##    <Returns>a homalg element</Returns>
##    <Description>
##      Computes the rational function corresponding to the character grid element <A>elem</A> or to the list of integers <A>elem</A>.
##      To compute rational functions you first need to compute to coordinate ring of the torus of the variety <A>vari</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "CharacterToRationalFunction",
                  [ IsHomalgElement, IsToricVariety ] );

DeclareOperation( "CharacterToRationalFunction",
                  [ IsList, IsToricVariety ] );

##  <#GAPDoc Label="CoxRing2">
##  <ManSection>
##    <Oper Arg="vari,vars" Name="CoxRing"/>
##    <Returns>a ring</Returns>
##    <Description>
##      Computes the Cox ring of the variety <A>vari</A>. <A>vars</A> needs to be a string containing one variable,
##      which will be numbered by the method. 
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "CoxRing",
                  [ IsToricVariety, IsString ] );

##  <#GAPDoc Label="WeilDivisorsOfVariety">
##  <ManSection>
##    <Oper Arg="vari" Name="WeilDivisorsOfVariety"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns a list of the currently defined Divisors of the toric variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "WeilDivisorsOfVariety",
                  [ IsToricVariety ] );

DeclareOperation( "Fan",
                  [ IsToricVariety ] );

#################################
##
## Constructors
##
#################################

DeclareOperation( "ToricVariety",
                  [ IsToricVariety ] );


##  <#GAPDoc Label="ToricVarietyConst">
##  <ManSection>
##    <Oper Arg="conv" Name="ToricVariety"/>
##    <Returns>a ring</Returns>
##    <Description>
##      Creates a toric variety out of the convex object <A>conv</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "ToricVariety",
                  [ IsConvexObject ] );