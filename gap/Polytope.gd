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
                 IsConvexObject );

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

DeclareProperty( "IsNormalPolytope",
                 IsHomalgPolytope );

DeclareProperty( "IsSimplicial",
                 IsHomalgPolytope );

DeclareProperty( "IsSimplePolytope",
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

DeclareAttribute( "FacetInequalities",
                  IsHomalgPolytope );

DeclareAttribute( "VerticesInFacets",
                  IsHomalgPolytope );

DeclareAttribute( "NormalFan",
                  IsHomalgPolytope );

DeclareAttribute( "AffineCone",
                  IsHomalgPolytope );

################################
##
## Constructors
##
################################

DeclareOperation( "HomalgPolytope",
                  [ IsHomalgPolytope ] );

DeclareOperation( "HomalgPolytope",
                  [ IsList ] );

DeclareOperation( "HomalgPolytopeByInequalities",
                  [ IsList ] );