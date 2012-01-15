#############################################################################
##
##  ToricSubarieties.gi         ToricVarieties package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of toric Varieties
##
#############################################################################

DeclareRepresentation( "IsCombinatoricalSubRep",
                       IsToricSubvariety and IsAttributeStoringRep,
                       [ "ConvexObject" ]
                      );

DeclareRepresentation( "IsFanSubRep",
                       IsCombinatoricalSubRep,
                       [ ]
                      );

InstallTrueMethod( IsToricSubvariety, IsToricVariety );

InstallTrueMethod( IsCombinatoricalSubRep, IsCombinatoricalRep );

InstallTrueMethod( IsFanSubRep, IsFanRep );

##################################
##
## Family and Type
##
##################################


BindGlobal( "TheTypeFanToricSubariety",
        NewType( TheFamilyOfToricVarietes,
                 IsFanSubRep ) );

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

DeclareAttribute( "AmbientToricVariety",
                  IsToricSubvariety );

DeclareAttribute( "UnderlyingToricVariety" );

DeclareAttribute( "InclusionMorphism",
                  IsToricSubvariety and IsOpen );

################################
##
## Constructors
##
################################



