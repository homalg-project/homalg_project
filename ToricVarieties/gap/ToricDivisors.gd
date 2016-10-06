#############################################################################
##
##  ToricDivisors.gd         ToricVarieties package
##
##  Copyright 2011- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
##
#! @Chapter Toric divisors
##
#############################################################################

#############################
##
#! @Section The GAP category
##
#############################

#! @Description
#! The <A>GAP</A> category of torus invariant Weil divisors.
#! @Returns true or false
#! @Arguments M
DeclareCategory( "IsToricDivisor",
                 IsObject );

#!
DeclareAttribute( "twitter",
                 IsToricDivisor );

#################################
##
#! @Section Properties
##
#################################

#! @Description
#! Checks if the torus invariant Weil divisor <A>divi</A> is Cartier i.e. if it is locally principal.
#! @Returns true or false
#! @Arguments divi
DeclareProperty( "IsCartier",
                 IsToricDivisor );

#! @Description
#! Checks if the torus invariant Weil divisor <A>divi</A> is principal 
#! which in the toric invariant case means that it is the divisor of a character.
#! @Returns true or false
#! @Arguments divi
DeclareProperty( "IsPrincipal",
                 IsToricDivisor );

#! @Description
#! Checks if the Weil divisor <A>divi</A> represents a prime divisor,
#! i.e. if it is a standard generator of the divisor group.
#! @Returns true or false
#! @Arguments divi
DeclareProperty( "IsPrimedivisor",
                 IsToricDivisor );

#! @Description
#! Checks if the divisor <A>divi</A> is basepoint free.
#! @Returns true or false
#! @Arguments divi
DeclareProperty( "IsBasepointFree",
                 IsToricDivisor );

#! @Description
#! Checks if the divisor <A>divi</A> is ample, i.e. if it is colored red, yellow and green.
#! @Returns true or false
#! @Arguments divi
DeclareProperty( "IsAmple",
                 IsToricDivisor );

#! @Description
#! Checks if the divisor <A>divi</A> is very ample.
#! @Returns true or false
#! @Arguments divi
DeclareProperty( "IsVeryAmple",
                 IsToricDivisor );

#! @Description
#! Checks if the divisor <A>divi</A> is nef.
#! @Returns true or false
#! @Arguments divi
DeclareProperty( "IsNumericallyEffective",
                 IsToricDivisor );

#################################
##
#! @Section Attributes
##
#################################

#! @Description
#! Returns the Cartier data of the divisor <A>divi</A>, if it is Cartier, and fails otherwise.
#! @Returns a list
#! @Arguments divi
DeclareAttribute( "CartierData",
                 IsToricDivisor );

#! @Description
#! Returns the character corresponding to the principal divisor <A>divi</A>.
#! @Returns a homalg module element
#! @Arguments divi
DeclareAttribute( "CharacterOfPrincipalDivisor",
                 IsToricDivisor );

#! @Description
#! Returns the class group element corresponding to the divisor <A>divi</A>.
#! @Returns a homalg module element
#! @Arguments divi
DeclareAttribute( "ClassOfDivisor",
                 IsToricDivisor );

#! @Description
#! Returns the polytope corresponding to the divisor <A>divi</A>.
#! @Returns a polytope
#! @Arguments divi
DeclareAttribute( "PolytopeOfDivisor",
                  IsToricDivisor );

#! @Description
#! Returns a basis of the global section module of the quasi-coherent sheaf of the divisor <A>divi</A>.
#! @Returns a list
#! @Arguments divi
DeclareAttribute( "BasisOfGlobalSections",
                  IsToricDivisor );

#! @Description
#! Returns an integer <A>n</A> such that $n \cdot \text{divi}$ is very ample.
#! @Returns an integer
#! @Arguments divi
DeclareAttribute( "IntegerForWhichIsSureVeryAmple",
                  IsToricDivisor );

#! @Description
#! Returns the toric variety which contains the prime divisors of the divisor <A>divi</A>.
#! @Returns a variety
#! @Arguments divi
DeclareAttribute( "AmbientToricVariety",
                  IsToricDivisor );

#! @Description
#! Returns an element which represents the divisor <A>divi</A> in the Weil group.
#! @Returns a homalg module element
#! @Arguments divi
DeclareAttribute( "UnderlyingGroupElement",
                  IsToricDivisor );

#! @Description
#! Returns the closure of the torus orbit corresponding to the prime divisor <A>divi</A>. 
#! Not implemented for other divisors. Maybe we should add the support here. 
#! Is this even a toric variety? Exercise left to the reader.
#! @Returns a variety
#! @Arguments divi
DeclareAttribute( "UnderlyingToricVariety",
                  IsToricDivisor );

#! @Description
#! Returns the degree of the divisor <A>divi</A>. This is not to be confused with the (divisor) class of <A>divi</A>!
#! @Returns an integer
#! @Arguments divi
DeclareAttribute( "DegreeOfDivisor",
                  IsToricDivisor );

#! @Description
#! Returns the variety corresponding to the polytope of the divisor <A>divi</A>.
#! @Returns a variety
#! @Arguments divi
DeclareAttribute( "VarietyOfDivisorpolytope",
                  IsToricDivisor );

#! @Description
#! Returns the monoms in the Cox ring of degree equal to the (divisor) class of the divisor <A>divi</A>.
#! @Returns a list
#! @Arguments divi
DeclareAttribute( "MonomsOfCoxRingOfDegree",
                  IsToricDivisor );

#! @Description
#! A basepoint free divisor <A>divi</A> defines a map from its ambient variety in a projective space.
#! This method returns the Cox ring of such a projective space.
#! @Returns a ring
#! @Arguments divi
DeclareAttribute( "CoxRingOfTargetOfDivisorMorphism",
                  IsToricDivisor );

#! @Description
#! A basepoint free divisor <A>divi</A> defines a map from its ambient variety in a projective space.
#! This method returns the morphism between the cox ring of this projective space to the cox ring of the
#! ambient variety of <A>divi</A>.
#! @Returns a ring map
#! @Arguments divi
DeclareAttribute( "RingMorphismOfDivisor",
                  IsToricDivisor );

#################################
##
#! @Section Methods
##
#################################

#! @Description
#! Returns a very ample multiple of the ample divisor <A>divi</A>. The method will fail if divisor is not ample.
#! @Returns a divisor
#! @Arguments divi
DeclareOperation( "VeryAmpleMultiple",
                  [ IsToricDivisor ] );

#! @Description
#! Returns characters for closed embedding defined via the ample divisor <A>divi</A>.
#! The method fails if the divisor <A>divi</A> is not ample.
#! @Returns a list
#! @Arguments divi
DeclareOperation( "CharactersForClosedEmbedding",
                  [ IsToricDivisor ] );

#! @Description
#! Returns the sum of the divisors <A>divi1</A> and <A>divi2</A>.
#! @Returns a divisor
#! @Arguments divi1,divi2
DeclareOperation( "\+",
                  [ IsToricDivisor, IsToricDivisor ] );

#! @Description
#! Returns the divisor <A>divi1</A> minus <A>divi2</A>.
#! @Returns a divisor
#! @Arguments divi1,divi2
DeclareOperation( "\-",
                  [ IsToricDivisor, IsToricDivisor ] );

#! @Description
#! Returns <A>k</A> times the divisor <A>divi</A>.
#! @Returns a divisor
#! @Arguments k,divi
DeclareOperation( "\*",
                  [ IsInt, IsToricDivisor ] );

#! @Description
#! Returns the monoms of the Cox ring of the variety <A>vari</A> with degree equal to the class
#! group element <A>elem</A>. The variable <A>elem</A> can also be a list.
#! @Returns a list
#! @Arguments vari, elem
DeclareOperation( "MonomsOfCoxRingOfDegree",
                  [ IsToricVariety, IsHomalgElement ] );

DeclareOperation( "MonomsOfCoxRingOfDegree",
                  [ IsToricVariety, IsList ] );

#! @Description
#! Computes a divisor of the variety <A>divi</A> which is member of the divisor class presented by <A>elem</A>.
#! The variable <A>elem</A> can be a homalg element or a list presenting an element.
#! @Returns a divisor
#! @Arguments vari, elem
DeclareOperation( "DivisorOfGivenClass",
                  [ IsToricVariety, IsHomalgElement ] );

DeclareOperation( "DivisorOfGivenClass",
                  [ IsToricVariety, IsList ] );

#! @Description
#! Adds the divisor <A>divi</A> to the Weil divisor list of its ambient variety.
#! @Returns
#! @Arguments divi
DeclareOperation( "AddDivisorToItsAmbientVariety",
                  [ IsToricDivisor ] );

#! @Description
#! Returns the polytope of the divisor <A>divi</A>. Another name for **PolytopeOfDivisor**
#! for compatibility and shortness.
#! @Returns a polytope
#! @Arguments divi
DeclareOperation( "Polytope",
                  [ IsToricDivisor ] );

#! @Description 
#! Given a toric divisor <A>divi</A>, it induces a toric morphism. The target of this morphism is a toric variety.
#! This method returns the Cox ring of this target. The variables are named according to <A>string</A>.
#! @Returns a ring
#! @Arguments divi, string
DeclareOperation( "CoxRingOfTargetOfDivisorMorphism",
                  [ IsToricDivisor, IsString ] );

#DeclareOperation( "\=",
#                   [ IsToricDivisor, IsToricDivisor ] );


##################################
##
#! @Section Constructors
##
##################################

#! @Description
#! Returns the divisor of the toric variety <A>vari</A> which corresponds to the character <A>elem</A>.
#! @Returns a divisor
#! @Arguments elem, vari
DeclareOperation( "DivisorOfCharacter",
                  [ IsHomalgElement, IsToricVariety ] );

#! @Description
#! Returns the divisor of the toric variety <A>vari</A> which corresponds to the character which is created 
#! by the list <A>lis</A>.
#! @Returns a divisor
#! @Arguments lis, vari
DeclareOperation( "DivisorOfCharacter",
                  [ IsList, IsToricVariety ] );

#! @Description
#! Returns the divisor of the toric variety <A>vari</A> which corresponds to the Weil group element <A>elem</A>.
#! by the list <A>lis</A>.
#! @Returns a divisor
#! @Arguments elem, vari
DeclareOperation( "CreateDivisor",
                  [ IsHomalgElement, IsToricVariety ] );

#! @Description
# !Returns the divisor of the toric variety <A>vari</A> which corresponds to the Weil group element 
#! which is created by the list <A>lis</A>.
#! @Returns a divisor
#! @Arguments lis, vari
DeclareOperation( "CreateDivisor",
                  [ IsList, IsToricVariety ] );