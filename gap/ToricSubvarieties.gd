#############################################################################
##
##  ToricSubvariety.gd         ToricVarieties package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of toric Subvarieties
##
#############################################################################

DeclareCategory( "IsToricSubvariety",
                 IsToricVariety );

#################################
##
## Attr & Props
##
#################################



#################################
##
## Properties
##
#################################

DeclareProperty( "IsClosed",
                 IsToricSubvariety );

DeclareProperty( "IsOpen",
                 IsToricSubvariety );

################################
##
## Attributes
##
################################

DeclareAttribute( "UnderlyingToricVariety",
                  IsToricSubvariety );

DeclareAttribute( "InclusionMorphism",
                  IsToricSubvariety and IsOpen );

DeclareAttribute( "AmbientToricVariety",
                  IsToricSubvariety );

################################
##
## Constructors
##
################################

DeclareOperation( "ToricSubvariety",
                  [ IsToricVariety, IsToricVariety ] );
