#############################################################################
##
##  ToricDivisors.gd     ToricVarieties       Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of the Divisors of a toric Variety
##
#############################################################################

##  <#GAPDoc Label="IsToricDivisor">
##  <ManSection>
##    <Filt Type="Category" Arg="M" Name="IsToricDivisor"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of torus invariant Weil divisors.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsToricDivisor",
                 IsObject );

#################################
##
## Properties
##
#################################

##  <#GAPDoc Label="IsCartier">
##  <ManSection>
##    <Prop Arg="divi" Name="IsCartier"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the torus invariant Weil divisor <A>divi</A> is cartier i.e.
##      if it is locally principal.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsCartier",
                 IsToricDivisor );

##  <#GAPDoc Label="IsPrincipal">
##  <ManSection>
##    <Prop Arg="divi" Name="IsPrincipal"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the torus invariant Weil divisor <A>divi</A> is principal
##      which in the toric invariant case means that
##      it is the divisor of a character.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsPrincipal",
                 IsToricDivisor );

##  <#GAPDoc Label="IsPrimedivisor">
##  <ManSection>
##    <Prop Arg="divi" Name="IsPrimedivisor"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the Weil divisor <A>divi</A> represents a prime divisor,
##      i.e. if it is a standard generator of the divisor group.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsPrimedivisor",
                 IsToricDivisor );

##  <#GAPDoc Label="IsBasepointFree">
##  <ManSection>
##    <Prop Arg="divi" Name="IsBasepointFree"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the divisor <A>divi</A> is basepoint free. What else?
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsBasepointFree",
                 IsToricDivisor );

##  <#GAPDoc Label="IsAmple">
##  <ManSection>
##    <Prop Arg="divi" Name="IsAmple"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the divisor <A>divi</A> is ample, i.e. if it is colored red, yellow and green.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsAmple",
                 IsToricDivisor );

##  <#GAPDoc Label="IsVeryAmple">
##  <ManSection>
##    <Prop Arg="divi" Name="IsVeryAmple"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the divisor <A>divi</A> is very ample.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsVeryAmple",
                 IsToricDivisor );

#################################
##
## Attributes
##
#################################

##  <#GAPDoc Label="CartierData">
##  <ManSection>
##    <Attr Arg="divi" Name="CartierData"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns the cartier data of the divisor <A>divi</A>, if it is cartier, and fails otherwise.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CartierData",
                 IsToricDivisor );

##  <#GAPDoc Label="CharacterOfPrincipalDivisor">
##  <ManSection>
##    <Attr Arg="divi" Name="CharacterOfPrincipalDivisor"/>
##    <Returns>an element</Returns>
##    <Description>
##      Returns the character corresponding to principal divisor <A>divi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CharacterOfPrincipalDivisor",
                 IsToricDivisor );

##  <#GAPDoc Label="ToricVarietyOfDivisor">
##  <ManSection>
##    <Attr Arg="divi" Name="ToricVarietyOfDivisor"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Returns the closure of the torus orbit corresponding to the prime divisor <A>divi</A>. Not implemented for other divisors.
##      Maybe we should add the support here. Is this even a toric variety? Exercise left to the reader.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ToricVarietyOfDivisor",
                 IsToricDivisor );

##  <#GAPDoc Label="ClassOfDivisor">
##  <ManSection>
##    <Attr Arg="divi" Name="ClassOfDivisor"/>
##    <Returns>an element</Returns>
##    <Description>
##      Returns the class group element corresponding to the divisor <A>divi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ClassOfDivisor",
                 IsToricDivisor );

##  <#GAPDoc Label="PolytopeOfDivisor">
##  <ManSection>
##    <Attr Arg="divi" Name="PolytopeOfDivisor"/>
##    <Returns>a polytope</Returns>
##    <Description>
##      Returns the polytope corresponding to the divisor <A>divi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "PolytopeOfDivisor",
                  IsToricDivisor );

##  <#GAPDoc Label="BasisOfGlobalSectionsOfDivisorSheaf">
##  <ManSection>
##    <Attr Arg="divi" Name="BasisOfGlobalSectionsOfDivisorSheaf"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns a basis of the global section module of the quasi-coherent sheaf of the divisor <A>divi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "BasisOfGlobalSectionsOfDivisorSheaf",
                  IsToricDivisor );

##  <#GAPDoc Label="IntegerForWhichIsSureVeryAmple">
##  <ManSection>
##    <Attr Arg="divi" Name="IntegerForWhichIsSureVeryAmple"/>
##    <Returns>an integer</Returns>
##    <Description>
##      Returns an integer which, to be multiplied with the ample divisor <A>divi</A>, someone gets a very ample divisor.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "IntegerForWhichIsSureVeryAmple",
                  IsToricDivisor );

##  <#GAPDoc Label="AmbientToricVariety">
##  <ManSection>
##    <Attr Arg="divi" Name="AmbientToricVariety"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Returns the containing variety of the prime divisors of the divisor <A>divi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AmbientToricVariety",
                  IsToricDivisor );

##  <#GAPDoc Label="UnderlyingGroupElement">
##  <ManSection>
##    <Attr Arg="divi" Name="UnderlyingGroupElement"/>
##    <Returns>an element</Returns>
##    <Description>
##      Returns an element which represents the divisor <A>divi</A> in the Weil group.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingGroupElement",
                  IsToricDivisor );

##  <#GAPDoc Label="UnderlyingToricVariety">
##  <ManSection>
##    <Attr Arg="divi" Name="UnderlyingToricVariety"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Returns the closure of the torus orbit corresponding to the prime divisor <A>divi</A>. Not implemented for other divisors.
##      Maybe we should add the support here. Is this even a toric variety? Exercise left to the reader.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnderlyingToricVariety",
                  IsToricDivisor );

#################################
##
## Methods
##
#################################

DeclareOperation( "VeryAmpleMultiple",
                  [ IsToricDivisor ] );

DeclareOperation( "CharactersForClosedEmbedding",
                  [ IsToricDivisor ] );

DeclareOperation( "\+",
                  [ IsToricDivisor, IsToricDivisor ] );

DeclareOperation( "\*",
                  [ IsInt, IsToricDivisor ] );

##################################
##
## Constructors
##
##################################

DeclareOperation( "DivisorOfCharacter",
                  [ IsHomalgElement, IsToricVariety ] );

DeclareOperation( "DivisorOfCharacter",
                  [ IsList, IsToricVariety ] );

DeclareOperation( "Divisor",
                  [ IsHomalgElement, IsToricVariety ] );

DeclareOperation( "Divisor",
                  [ IsList, IsToricVariety ] );
