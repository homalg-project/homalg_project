#############################################################################
##
##  ToricVariety.gd         ToricVarietiesForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of toric Varieties
##
#############################################################################

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

## DeclareProperty( "IsNormal",
##                  [ IsToricVariety ] );

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

DeclareAttribute( "PrimeDivisors",
                  IsToricVariety );

DeclareAttribute( "Dimension",
                  IsToricVariety );

DeclareAttribute( "DimensionOfTorusfactor",
                  IsToricVariety );

DeclareAttribute( "CoordinateRingOfTorus",
                  IsToricVariety );

DeclareAttribute( "IsProductOf",
                  IsToricVariety );

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

#################################
##
## Constructors
##
#################################

DeclareOperation( "ToricVariety",
                  [ IsToricVariety ] );

DeclareOperation( "ToricVariety",
                  [ IsConvexObject ] );