#############################################################################
##
##  Polytope.gd         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Cones for ConvexForHomalg.
##
#############################################################################

DeclareCategory( "IsHomalgPolytope",
                 IsHomalgConvexObject );

################################
##
## Basic Properties
##
################################

DeclareProperty( "IsNotEmpty",
                 IsHomalgPolytope );

DeclareProperty( "IsLatticePolytope",
                 IsHomalgPolytope );

DeclareProperty( "IsVeryAmple",
                 IsHomalgPolytope );

DeclareProperty( "IsNormal",
                 IsHomalgPolytope );

DeclareProperty( "IsBasic",
                 IsHomalgPolytope );

################################
##
## Attributes
##
################################

DeclareAttribute( "Vertices",
                  IsHomalgPolytope );

DeclareAttribute( "LatticePoints",
                  IsHomalgPolytope );