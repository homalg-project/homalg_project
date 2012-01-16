#############################################################################
##
##  ToricDivisors.gd     ToricVarieties       Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of the Divisors of a toric Variety
##
#############################################################################

DeclareCategory( "IsToricDivisor",
                 IsObject );

#################################
##
## Properties
##
#################################

DeclareProperty( "IsCartier",
                 IsToricDivisor );

DeclareProperty( "IsPrincipal",
                 IsToricDivisor );

DeclareProperty( "IsPrimedivisor",
                 IsToricDivisor );

DeclareProperty( "IsBasepointFree",
                 IsToricDivisor );

DeclareProperty( "IsAmple",
                 IsToricDivisor );

DeclareProperty( "IsVeryAmple",
                 IsToricDivisor );

#################################
##
## Attributes
##
#################################

DeclareAttribute( "CartierData",
                 IsToricDivisor );

DeclareAttribute( "CharacterOfPrincipalDivisor",
                 IsToricDivisor );

DeclareAttribute( "ToricVarietyOfDivisor",
                 IsToricDivisor );

DeclareAttribute( "ClassOfDivisor",
                 IsToricDivisor );

DeclareAttribute( "PolytopeOfDivisor",
                  IsToricDivisor );

DeclareAttribute( "BasisOfGlobalSectionsOfDivisorSheaf",
                  IsToricDivisor );

DeclareAttribute( "IntegerForWhichIsSureVeryAmple",
                  IsToricDivisor );

DeclareAttribute( "AmbientToricVariety",
                  IsToricDivisor );

DeclareAttribute( "UnderlyingGroupElement",
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
