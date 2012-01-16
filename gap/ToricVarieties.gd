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

DeclareCategory( "IsToricVariety",
                 IsObject );

#################################
##
## Properties
##
#################################

DeclareProperty( "IsNormalVariety",
                  IsToricVariety );

DeclareProperty( "IsAffine",
                 IsToricVariety );

DeclareProperty( "IsProjective",
                 IsToricVariety );

DeclareProperty( "IsSmooth",
                 IsToricVariety );

DeclareProperty( "IsComplete",
                 IsToricVariety );

DeclareProperty( "HasTorusfactor",
                 IsToricVariety );

#################################
##
## Attributes
##
#################################

DeclareAttribute( "AffineOpenCovering",
                  IsToricVariety );

DeclareAttribute( "CoxRing",
                  IsToricVariety );

DeclareAttribute( "ClassGroup",
                  IsToricVariety );

DeclareAttribute( "PicardGroup",
                  IsToricVariety );

DeclareAttribute( "DivisorGroup",
                  IsToricVariety );

DeclareAttribute( "MapFromCharacterToPrincipalDivisor",
                  IsToricVariety );

DeclareAttribute( "Dimension",
                  IsToricVariety );

DeclareAttribute( "DimensionOfTorusfactor",
                  IsToricVariety );

DeclareAttribute( "CoordinateRingOfTorus",
                  IsToricVariety );

DeclareAttribute( "IsProductOf",
                  IsToricVariety );

DeclareAttribute( "CharacterGrid",
                  IsToricVariety );

DeclareAttribute( "PrimeDivisors",
                  IsToricVariety );

DeclareAttribute( "IrrelevantIdeal",
                  IsToricVariety );

#DeclareAttribute( "AmbientToricVariety",
#                  IsToricVariety );

#################################
##
## Methods
##
#################################

DeclareOperation( "UnderlyingConvexObject",
                  [ IsToricVariety ] );

DeclareOperation( "UnderlyingSheaf",
                  [ IsToricVariety ] );

DeclareOperation( "CoordinateRingOfTorus",
                  [ IsToricVariety, IsList ] );

DeclareOperation( "\*",
                  [ IsToricVariety, IsToricVariety ] );

DeclareOperation( "CharacterToRationalFunction",
                  [ IsHomalgElement, IsToricVariety ] );

DeclareOperation( "CharacterToRationalFunction",
                  [ IsList, IsToricVariety ] );

DeclareOperation( "CoxRing",
                  [ IsToricVariety, IsString ] );

#################################
##
## Constructors
##
#################################

DeclareOperation( "ToricVariety",
                  [ IsToricVariety ] );

DeclareOperation( "ToricVariety",
                  [ IsConvexObject ] );