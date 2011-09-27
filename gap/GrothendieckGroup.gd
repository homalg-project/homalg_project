#############################################################################
##
##  GrothendieckGroup.gd                                     Modules package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for elements of the Grothendieck group of a projective space.
##
#############################################################################

####################################
#
# categories:
#
####################################

##  <#GAPDoc Label="IsElementOfGrothendieckGroupOfProjectiveSpace">
##  <ManSection>
##    <Filt Type="Category" Arg="P" Name="IsElementOfGrothendieckGroupOfProjectiveSpace"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of elements of the Grothendieck group of the projective space.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsElementOfGrothendieckGroupOfProjectiveSpace",
        IsExtAElement and
        IsExtLElement and
        IsExtRElement and
        IsAdditiveElementWithInverse and
        IsMultiplicativeElementWithInverse and
        IsAssociativeElement and
        IsAdditivelyCommutativeElement and
	## all the above guarantees IsElementOfGrothendieckGroupOfProjectiveSpace => IsRingElement (in GAP4)
        IsAttributeStoringRep );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsPolynomialModuloSomePower">
##  <ManSection>
##    <Filt Type="Category" Arg="P" Name="IsPolynomialModuloSomePower"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of polynomials modulo some power.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsPolynomialModuloSomePower",
        IsExtAElement and
        IsExtLElement and
        IsExtRElement and
        IsAdditiveElementWithInverse and
        IsMultiplicativeElementWithInverse and
        IsAssociativeElement and
        IsAdditivelyCommutativeElement and
	## all the above guarantees IsPolynomialModuloSomePower => IsRingElement (in GAP4)
        IsAttributeStoringRep );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsChernPolynomialWithRank">
##  <ManSection>
##    <Filt Type="Category" Arg="P" Name="IsChernPolynomialWithRank"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of Chern polynomials with rank.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsChernPolynomialWithRank",
        IsExtAElement and
        IsExtLElement and
        IsExtRElement and
        IsAdditiveElementWithInverse and
        IsMultiplicativeElementWithInverse and
        IsAssociativeElement and
        IsAdditivelyCommutativeElement and
	## all the above guarantees IsChernPolynomialWithRank => IsRingElement (in GAP4)
        IsAttributeStoringRep );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsChernCharacter">
##  <ManSection>
##    <Filt Type="Category" Arg="P" Name="IsChernCharacter"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of Chern characters.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsChernCharacter",
        IsExtAElement and
        IsExtLElement and
        IsExtRElement and
        IsAdditiveElementWithInverse and
        IsMultiplicativeElementWithInverse and
        IsAssociativeElement and
        IsAdditivelyCommutativeElement and
	## all the above guarantees IsChernCharacter => IsRingElement (in GAP4)
        IsAttributeStoringRep );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="GrothendieckGroup">
##  <ManSection>
##    <Attr Arg="P" Name="GrothendieckGroup"/>
##    <Returns>a &ZZ;-module</Returns>
##    <Description>
##      The Grothendieck group of the element of the Grothendieck group of the projective space.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "GrothendieckGroup",
        IsElementOfGrothendieckGroupOfProjectiveSpace );

##  <#GAPDoc Label="UnderlyingModuleElement">
##  <ManSection>
##    <Attr Arg="P" Name="UnderlyingModuleElement"/>
##    <Returns>a list of integers</Returns>
##    <Description>
##      The element of the Grothendieck group considered as an abstract &ZZ;-module.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingModuleElement",
        IsElementOfGrothendieckGroupOfProjectiveSpace );

##  <#GAPDoc Label="AssociatedPolynomial">
##  <ManSection>
##    <Attr Arg="P" Name="AssociatedPolynomial"/>
##    <Returns>a univariate polynomial</Returns>
##    <Description>
##      The polynomial associated to the element of the Grothendieck group of the projective space <A>P</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AssociatedPolynomial",
        IsElementOfGrothendieckGroupOfProjectiveSpace );

##  <#GAPDoc Label="AmbientDimension:ElementOfGrothendieckGroup">
##  <ManSection>
##    <Attr Arg="P" Name="AmbientDimension" Label="for Grothendieck group elements"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The ambient dimension of the element of the Grothendieck group of the projective space,
##      i.e, the dimension of the projective space over which <A>P</A> is defined.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AmbientDimension",
        IsElementOfGrothendieckGroupOfProjectiveSpace );

##  <#GAPDoc Label="Dimension:ElementOfGrothendieckGroup">
##  <ManSection>
##    <Attr Arg="P" Name="Dimension" Label="for Grothendieck group elements"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The dimension of the element of the Grothendieck group of the projective space.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Dimension",
        IsElementOfGrothendieckGroupOfProjectiveSpace );

##  <#GAPDoc Label="DegreeOfElementOfGrothendieckGroupOfProjectiveSpace">
##  <ManSection>
##    <Attr Arg="P" Name="DegreeOfElementOfGrothendieckGroupOfProjectiveSpace"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The degree of the element of the Grothendieck group of the projective space. A short hand is the operation <C>Degree</C>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DegreeOfElementOfGrothendieckGroupOfProjectiveSpace",
        IsElementOfGrothendieckGroupOfProjectiveSpace );

##  <#GAPDoc Label="RankOfObject:ElementOfGrothendieckGroup">
##  <ManSection>
##    <Attr Arg="P" Name="RankOfObject" Label="for Grothendieck group elements"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The rank of the element of the Grothendieck group of the projective space. A short hand is the operation <C>Rank</C>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RankOfObject",
        IsElementOfGrothendieckGroupOfProjectiveSpace );

##  <#GAPDoc Label="ChernPolynomial:ElementOfGrothendieckGroup">
##  <ManSection>
##    <Attr Arg="P" Name="ChernPolynomial" Label="for Grothendieck group elements"/>
##    <Returns>a Chern polynomial with rank</Returns>
##    <Description>
##      The Chern polynomial (with rank) of the element of the Grothendieck group of the projective space.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ChernPolynomial",
        IsElementOfGrothendieckGroupOfProjectiveSpace );

##  <#GAPDoc Label="ElementOfGrothendieckGroupOfProjectiveSpace">
##  <ManSection>
##    <Attr Arg="P" Name="ElementOfGrothendieckGroupOfProjectiveSpace"/>
##    <Returns>an element of the Grothendieck group of a projective space</Returns>
##    <Description>
##      The element of the Grothendieck group of the projective space of the Chern polynomial.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ElementOfGrothendieckGroupOfProjectiveSpace",
        IsChernPolynomialWithRank );

##  <#GAPDoc Label="TotalChernClass">
##  <ManSection>
##    <Attr Arg="C" Name="TotalChernClass"/>
##    <Returns>a polynomial modulo some power</Returns>
##    <Description>
##      The total Chern class of the (Chern polynomial with rank).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "TotalChernClass",
        IsChernPolynomialWithRank );

##  <#GAPDoc Label="AmbientDimension:ChernPolynomial">
##  <ManSection>
##    <Attr Arg="C" Name="AmbientDimension" Label="for Chern polynomials"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The ambient dimension of the (Chern polynomial with rank),
##      i.e, the dimension of the projective space over which <A>C</A> is defined.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AmbientDimension",
        IsChernPolynomialWithRank );

##  <#GAPDoc Label="Dimension:ChernPolynomial">
##  <ManSection>
##    <Attr Arg="C" Name="Dimension Label="for Chern polynomials""/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The dimension of the (Chern polynomial with rank).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Dimension",
        IsChernPolynomialWithRank );

##  <#GAPDoc Label="DegreeOfChernPolynomial">
##  <ManSection>
##    <Attr Arg="C" Name="DegreeOfChernPolynomial"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The degree of the (Chern polynomial with rank). A short hand is <C>Degree</C>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DegreeOfChernPolynomial",
        IsChernPolynomialWithRank );

##  <#GAPDoc Label="RankOfObject:ChernPolynomial">
##  <ManSection>
##    <Attr Arg="C" Name="RankOfObject" Label="for Chern polynomials"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The rank of the (Chern polynomial with rank). A short hand is <C>Rank</C>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RankOfObject",
        IsChernPolynomialWithRank );

##  <#GAPDoc Label="ChernCharacter:ChernPolynomial">
##  <ManSection>
##    <Attr Arg="C" Name="ChernCharacter" Label="for Chern polynomials"/>
##    <Returns>a Chern character</Returns>
##    <Description>
##      The Chern character of a Chern polynomial with rank.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ChernCharacter",
        IsChernPolynomialWithRank );

##  <#GAPDoc Label="HilbertPolynomial:ChernPolynomial">
##  <ManSection>
##    <Attr Arg="C" Name="HilbertPolynomial" Label="for Chern polynomials"/>
##    <Returns>a univariate polynomial</Returns>
##    <Description>
##      The Hilbert polynomial of the Chern polynomial with rank.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "HilbertPolynomial",
        IsChernPolynomialWithRank );

##  <#GAPDoc Label="ChernCharacterPolynomial">
##  <ManSection>
##    <Attr Arg="C" Name="ChernCharacterPolynomial"/>
##    <Returns>a polynomial modulo some power</Returns>
##    <Description>
##      The Chern character polynomial of the Chern character.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ChernCharacterPolynomial",
        IsChernCharacter );

##  <#GAPDoc Label="AmbientDimension:ChernCharacter">
##  <ManSection>
##    <Attr Arg="ch" Name="AmbientDimension" Label="for Chern characters"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The ambient dimension of the Chern character,
##      i.e, the dimension of the projective space over which <A>ch</A> is defined.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AmbientDimension",
        IsChernCharacter );

##  <#GAPDoc Label="Dimension:ChernCharacter">
##  <ManSection>
##    <Attr Arg="ch" Name="Dimension" Label="for Chern characters"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The dimension of the Chern character.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Dimension",
        IsChernCharacter );

##  <#GAPDoc Label="RankOfObject:ChernCharacter">
##  <ManSection>
##    <Attr Arg="ch" Name="RankOfObject" Label="for Chern characters"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The rank of the Chern character. A short hand is <C>Rank</C>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RankOfObject",
        IsChernCharacter );

##  <#GAPDoc Label="HilbertPolynomial:ChernCharacter">
##  <ManSection>
##    <Attr Arg="ch" Name="HilbertPolynomial" Label="for Chern characters"/>
##    <Returns>a univariate polynomial</Returns>
##    <Description>
##      The Hilbert polynomial of the Chern character.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "HilbertPolynomial",
        IsChernCharacter );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "VariableForChernPolynomial" );

DeclareGlobalFunction( "VariableForChernCharacter" );

DeclareGlobalFunction( "ExpressSymmetricPolynomialInElementarySymmetricPolynomials" );

DeclareGlobalFunction( "ExpressSumOfPowersInElementarySymmetricPolynomials" );

# constructors:

DeclareOperation( "CreateElementOfGrothendieckGroupOfProjectiveSpace",
        [ IsHomalgModuleElement ] );

DeclareOperation( "CreateElementOfGrothendieckGroupOfProjectiveSpace",
        [ IsList, IsHomalgModule ] );

DeclareOperation( "CreateElementOfGrothendieckGroupOfProjectiveSpace",
        [ IsUnivariatePolynomial, IsHomalgModule ] );

DeclareOperation( "CreateElementOfGrothendieckGroupOfProjectiveSpace",
        [ IsUnivariatePolynomial, IsInt ] );

DeclareOperation( "CreateElementOfGrothendieckGroupOfProjectiveSpace",
        [ IsUnivariatePolynomial ] );

DeclareOperation( "CreateElementOfGrothendieckGroupOfProjectiveSpace",
        [ IsList, IsInt ] );

DeclareOperation( "CreateElementOfGrothendieckGroupOfProjectiveSpace",
        [ IsList ] );

DeclareOperation( "CreatePolynomialModuloSomePower",
        [ IsUnivariatePolynomial, IsInt ] );

DeclareOperation( "CreateChernPolynomial",
        [ IsInt, IsPolynomialModuloSomePower ] );

DeclareOperation( "CreateChernPolynomial",
        [ IsInt, IsUnivariatePolynomial, IsInt ] );

DeclareOperation( "CreateChernCharacter",
        [ IsPolynomialModuloSomePower ] );

DeclareOperation( "CreateChernCharacter",
        [ IsUnivariatePolynomial, IsInt ] );

# basic operations:

DeclareOperation( "ChernPolynomial",
        [ IsUnivariatePolynomial, IsInt, IsRingElement ] );

DeclareOperation( "ChernPolynomial",
        [ IsUnivariatePolynomial, IsInt ] );

DeclareOperation( "ElementarySymmetricPolynomial",
        [ IsInt, IsList ] );

DeclareOperation( "CoefficientsOfElementOfGrothendieckGroupOfProjectiveSpace",
        [ IsUnivariatePolynomial ] );

DeclareOperation( "Coefficients",
        [ IsElementOfGrothendieckGroupOfProjectiveSpace ] );

DeclareOperation( "Coefficients",
        [ IsElementOfGrothendieckGroupOfProjectiveSpace, IsString ] );

DeclareOperation( "Value",
        [ IsElementOfGrothendieckGroupOfProjectiveSpace, IsRat ] );

DeclareOperation( "ChernPolynomial",
        [ IsElementOfGrothendieckGroupOfProjectiveSpace, IsRingElement ] );

DeclareOperation( "Coefficients",
        [ IsPolynomialModuloSomePower ] );

DeclareOperation( "Coefficients",
        [ IsChernPolynomialWithRank ] );

DeclareOperation( "Coefficients",
        [ IsChernCharacter ] );
