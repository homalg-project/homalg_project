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

DeclareAttribute( "twitter",
                 IsToricDivisor );

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

##  <#GAPDoc Label="IsNumericallyEffective">
##  <ManSection>
##    <Prop Arg="divi" Name="IsNumericallyEffective"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Checks if the divisor <A>divi</A> is nef.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsNumericallyEffective",
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
##    <Attr Arg="divi" Name="BasisOfGlobalSections"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns a basis of the global section module of the quasi-coherent sheaf of the divisor <A>divi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "BasisOfGlobalSections",
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

##  <#GAPDoc Label="AmbientToricVarietyOfDivisor">
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

##  <#GAPDoc Label="UnderlyingToricVarietyDiv">
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

##  <#GAPDoc Label="DegreeOfDivisor">
##  <ManSection>
##    <Attr Arg="divi" Name="DegreeOfDivisor"/>
##    <Returns>an integer</Returns>
##    <Description>
##      Returns the degree of the divisor <A>divi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DegreeOfDivisor",
                  IsToricDivisor );

##  <#GAPDoc Label="VarietyOfDivisorpolytope">
##  <ManSection>
##    <Attr Arg="divi" Name="VarietyOfDivisorpolytope"/>
##    <Returns>a variety</Returns>
##    <Description>
##      Returns the variety corresponding to the polytope of the divisor <A>divi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "VarietyOfDivisorpolytope",
                  IsToricDivisor );

##  <#GAPDoc Label="MonomsOfCoxRingOfDegree">
##  <ManSection>
##    <Attr Arg="divi" Name="MonomsOfCoxRingOfDegree"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns the variety corresponding to the polytope of the divisor <A>divi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "MonomsOfCoxRingOfDegree",
                  IsToricDivisor );

##  <#GAPDoc Label="CoxRingOfTargetOfDivisorMorphism">
##  <ManSection>
##    <Attr Arg="divi" Name="CoxRingOfTargetOfDivisorMorphism"/>
##    <Returns>a ring</Returns>
##    <Description>
##      A basepoint free divisor <A>divi</A> defines a map from its ambient variety in a projective space.
##      This method returns the cox ring of such a projective space.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CoxRingOfTargetOfDivisorMorphism",
                  IsToricDivisor );

##  <#GAPDoc Label="RingMorphismOfDivisor">
##  <ManSection>
##    <Attr Arg="divi" Name="RingMorphismOfDivisor"/>
##    <Returns>a ring</Returns>
##    <Description>
##      A basepoint free divisor <A>divi</A> defines a map from its ambient variety in a projective space.
##      This method returns the morphism between the cox ring of this projective space to the cox ring of the
##      ambient variety of <A>divi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RingMorphismOfDivisor",
                  IsToricDivisor );

#################################
##
## Methods
##
#################################

##  <#GAPDoc Label="VeryAmpleMultiple">
##  <ManSection>
##    <Oper Arg="divi" Name="VeryAmpleMultiple"/>
##    <Returns>a divisor</Returns>
##    <Description>
##      Returns a very ample multiple of the ample divisor <A>divi</A>. Will fail if divisor is not ample.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "VeryAmpleMultiple",
                  [ IsToricDivisor ] );

##  <#GAPDoc Label="CharactersForClosedEmbedding">
##  <ManSection>
##    <Oper Arg="divi" Name="CharactersForClosedEmbedding"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns characters for closed embedding defined via the ample divisor <A>divi</A>.
##      Fails if divisor is not ample.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "CharactersForClosedEmbedding",
                  [ IsToricDivisor ] );

##  <#GAPDoc Label="PLUS">
##  <ManSection>
##    <Oper Arg="divi1,divi2" Name="+"/>
##    <Returns>a divisor</Returns>
##    <Description>
##      Returns the sum of the divisors <A>divi1</A> and <A>divi2</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "\+",
                  [ IsToricDivisor, IsToricDivisor ] );

##  <#GAPDoc Label="MINUS">
##  <ManSection>
##    <Oper Arg="divi1,divi2" Name="-"/>
##    <Returns>a divisor</Returns>
##    <Description>
##      Returns the divisor <A>divi1</A> minus <A>divi2</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "\-",
                  [ IsToricDivisor, IsToricDivisor ] );

##  <#GAPDoc Label="TIMES">
##  <ManSection>
##    <Oper Arg="k,divi" Name="*"/>
##    <Returns>a divisor</Returns>
##    <Description>
##      Returns <A>k</A> times the divisor <A>divi</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "\*",
                  [ IsInt, IsToricDivisor ] );

##  <#GAPDoc Label="MonomsOfCoxRingOfDegree2">
##  <ManSection>
##    <Oper Arg="vari,elem" Name="MonomsOfCoxRingOfDegree"/>
##    <Returns>a list</Returns>
##    <Description>
##      Returns the monoms of the Cox ring of the variety <A>vari</A> with degree to the class
##      group element <A>elem</A>. The variable <A>elem</A> can also be a list.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "MonomsOfCoxRingOfDegree",
                  [ IsToricVariety, IsHomalgElement ] );

DeclareOperation( "MonomsOfCoxRingOfDegree",
                  [ IsToricVariety, IsList ] );

##  <#GAPDoc Label="DivisorOfGivenClass">
##  <ManSection>
##    <Oper Arg="vari,elem" Name="DivisorOfGivenClass"/>
##    <Returns>a list</Returns>
##    <Description>
##      Computes a divisor of the variety <A>divi</A> which is member of the divisor class presented by <A>elem</A>.
##      The variable <A>elem</A> can be a homalg element or a list presenting an element.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DivisorOfGivenClass",
                  [ IsToricVariety, IsHomalgElement ] );

DeclareOperation( "DivisorOfGivenClass",
                  [ IsToricVariety, IsList ] );

##  <#GAPDoc Label="AddDivisorToItsAmbientVariety">
##  <ManSection>
##    <Oper Arg="divi" Name="AddDivisorToItsAmbientVariety"/>
##    <Returns></Returns>
##    <Description>
##      Adds the divisor <A>divi</A> to the Weil divisor list of its ambient variety.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "AddDivisorToItsAmbientVariety",
                  [ IsToricDivisor ] );

##  <#GAPDoc Label="PolytopeMethodDiv">
##  <ManSection>
##    <Oper Arg="divi" Name="Polytope"/>
##    <Returns>a polytope</Returns>
##    <Description>
##      Returns the polytope of the divisor <A>divi</A>. Another name for PolytopeOfDivisor for compatibility and shortness.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "Polytope",
                  [ IsToricDivisor ] );

DeclareOperation( "CoxRingOfTargetOfDivisorMorphism",
                  [ IsToricDivisor, IsString ] );

# DeclareOperation( "\=",
#                   [ IsToricDivisor, IsToricDivisor ] );


##################################
##
## Constructors
##
##################################

##  <#GAPDoc Label="DivisorOfCharacter">
##  <ManSection>
##    <Oper Arg="elem,vari" Name="DivisorOfCharacter"/>
##    <Returns>a divisor</Returns>
##    <Description>
##      Returns the divisor of the toric variety <A>vari</A> which correspondens to the character <A>elem</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DivisorOfCharacter",
                  [ IsHomalgElement, IsToricVariety ] );

##  <#GAPDoc Label="DivisorOfCharacter2">
##  <ManSection>
##    <Oper Arg="lis,vari" Name="DivisorOfCharacter"/>
##    <Returns>a divisor</Returns>
##    <Description>
##      Returns the divisor of the toric variety <A>vari</A> which correspondens to the character which is created by the list <A>lis</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DivisorOfCharacter",
                  [ IsList, IsToricVariety ] );

##  <#GAPDoc Label="Divisor">
##  <ManSection>
##    <Oper Arg="elem,vari" Name="Divisor"/>
##    <Returns>a divisor</Returns>
##    <Description>
##      Returns the divisor of the toric variety <A>vari</A> which correspondens to the weil group element <A>elem</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "Divisor",
                  [ IsHomalgElement, IsToricVariety ] );

##  <#GAPDoc Label="Divisor2">
##  <ManSection>
##    <Oper Arg="lis,vari" Name="Divisor"/>
##    <Returns>a divisor</Returns>
##    <Description>
##      Returns the divisor of the toric variety <A>vari</A> which correspondens to the weil group elemenet which is created by the list <A>lis</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "Divisor",
                  [ IsList, IsToricVariety ] );
