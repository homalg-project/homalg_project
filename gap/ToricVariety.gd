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

DeclareProperty( "IsNormal",
                 [ IsToricVariety ] );

DeclareProperty( "IsAffine",
                 [ IsToricVariety ] );

DeclareProperty( "IsProjective",
                 [ IsToricVariety ] );

DeclareProperty( "IsSmooth",
                 [ IsToricVariety ] );

DeclareProperty( "IsComplete",
                 [ IsToricVariety ] );

#################################
##
## Attributes
##
#################################

DeclareAttribute( "AffineOpenConvering",
                  [ IsToricVariety ] );

DeclareAttribute( "CoxRing",
                  [ IsToricVariety ] );

DeclareAttribute( "ClassGroup",
                  [ IsToricVariety ] );

DeclareAttribute( "PicardGroup",
                  [ IsToricVariety ] );

DeclareAttribute( "PrimeDivisors",
                  [ IsToricVariety ] );

DeclareAttribute( "Dimension",
                  [ IsToricVariety ] );

#################################
##
## Methods
##
#################################

DeclareOperation( "ConvexObject",
                  [ IsToricVariety ] );

#################################
##
## Constructors
##
#################################

DeclareOperation( "ToricVariety",
                  [ IsToricVariety ] );

DeclareOperation( "ToricVariety",
                  [ IsConvexObject ] );