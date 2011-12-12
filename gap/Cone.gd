#############################################################################
##
##  Cone.gd         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Cones for ConvexForHomalg.
##
#############################################################################

DeclareCategory( "IsHomalgCone",
                 IsConvexObject );


################################
##
## Basic Properties
##
################################

DeclareAttribute( "RayGenerators",
                  IsHomalgCone );

DeclareAttribute( "IsPointedCone",
                  IsHomalgCone );

DeclareAttribute( "IsSmooth",
                  IsHomalgCone );

################################
##
## Constructors
##
################################


DeclareOperation( "HomalgCone",
                  [ IsHomalgCone ] );

DeclareOperation( "HomalgCone",
                  [ IsList ] );


