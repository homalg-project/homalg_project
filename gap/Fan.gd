#############################################################################
##
##  Fan.gd         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Fans for ConvexForHomalg.
##
#############################################################################

DeclareCategory( "IsHomalgFan",
                 IsConvexObject );

####################################
##
## Attributes
##
####################################

DeclareAttribute( "Rays",
                  IsHomalgFan );

DeclareAttribute( "MaximalCones",
                  IsHomalgFan );

####################################
##
## Properties
##
####################################

DeclareProperty( "IsCompleteFan",
                 IsHomalgFan );

DeclareProperty( "IsPointed",
                 IsHomalgFan );

DeclareProperty( "IsSmooth",
                 IsHomalgFan );

####################################
##
## Constructors
##
####################################

DeclareOperation( "HomalgFan",
                 [ IsHomalgFan ] );

DeclareOperation( "HomalgFan",
                 [ IsList ] );