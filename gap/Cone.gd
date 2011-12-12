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

DeclareAttribute( "IsPointedCone",
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


