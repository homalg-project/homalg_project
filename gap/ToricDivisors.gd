#############################################################################
##
##  ToricDivisors.gd     ToricVarietiesForHomalg package       Sebastian Gutsche
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

#################################
##
## Methods
##
#################################

DeclareOperation( "AmbientToricVariety",
                  [ IsToricDivisor ] );

DeclareOperation( "UnderlyingGroupElement",
                  [ IsToricDivisor ] );

DeclareOperation( "\+",
                  [ IsToricDivisor, IsToricDivisor ] );

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
