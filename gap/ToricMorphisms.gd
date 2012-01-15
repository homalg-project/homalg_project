#############################################################################
##
##  ToricMorphisms.gd         ToricVarieties         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Morphisms for toric varieties
##
#############################################################################

DeclareCategory( "IsToricMorphism",
                 IsObject );

###############################
##
## Properties
##
###############################

DeclareProperty( "IsMorphism",
                 IsToricMorphism );

DeclareProperty( "IsProper",
                 IsToricMorphism );

###############################
##
## Attributes
##
###############################

DeclareAttribute( "SourceObject",
                  IsToricMorphism );

DeclareAttribute( "UnderlyingGridMorphism",
                  IsToricMorphism );

DeclareAttribute( "ToricImageObject",
                  IsToricMorphism );

DeclareAttribute( "RangeObject",
                  IsToricMorphism );

###############################
##
## Methods
##
###############################

DeclareOperation( "UnderlyingListList",
                  [ IsToricMorphism ] );

###############################
##
## Constructors
##
###############################

DeclareOperation( "ToricMorphism",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "ToricMorphism",
                  [ IsToricVariety, IsList, IsToricVariety ] );
