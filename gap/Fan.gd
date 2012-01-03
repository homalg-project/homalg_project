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

DeclareAttribute( "RaysInMaximalCones",
                  IsHomalgFan );

DeclareAttribute( "MaximalCones",
                  IsHomalgFan );

####################################
##
## Properties
##
####################################

DeclareProperty( "IsComplete",
                 IsHomalgFan );

DeclareProperty( "IsPointed",
                 IsHomalgFan );

DeclareProperty( "IsSmooth",
                 IsHomalgFan );

DeclareProperty( "IsRegular",
                 IsHomalgFan );

####################################
##
## Methods
##
####################################

DeclareOperation( "\*",
                 [ IsHomalgFan, IsHomalgFan ] );

DeclareOperation( "\*",
                 [ IsHomalgCone, IsHomalgFan ] );

DeclareOperation( "\*",
                 [ IsHomalgFan, IsHomalgCone ] );

####################################
##
## Constructors
##
####################################

DeclareOperation( "HomalgFan",
                 [ IsHomalgFan ] );

DeclareOperation( "HomalgFan",
                 [ IsInt ] );

DeclareOperation( "HomalgFan",
                 [ IsList ] );

DeclareOperation( "HomalgFan",
                 [ IsList, IsList ] );