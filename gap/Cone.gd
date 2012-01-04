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

DeclareProperty( "IsPointed",
                 IsHomalgCone );

DeclareProperty( "IsSmooth",
                 IsHomalgCone );

DeclareProperty( "IsRegular",
                 IsHomalgCone );

DeclareProperty( "IsSimplicial",
                 IsHomalgCone );

################################
##
## Attributes
##
################################

DeclareAttribute( "RayGenerators",
                  IsHomalgCone );

DeclareAttribute( "Rays",
                  IsHomalgCone );

DeclareAttribute( "DualCone",
                  IsHomalgCone );

DeclareAttribute( "HilbertBasis",
                  IsHomalgCone );

DeclareAttribute( "RaysInFacets",
                  IsHomalgCone );

DeclareAttribute( "Facets",
                  IsHomalgCone );

DeclareAttribute( "GridGeneratedByCone",
                  IsHomalgCone );

DeclareAttribute( "FactorGrid",
                  IsHomalgCone );

################################
##
## Methods
##
################################

DeclareOperation( "\*",
                  [ IsHomalgCone, IsHomalgCone ] );

DeclareOperation( "IntersectionOfCones",
                  [ IsHomalgCone, IsHomalgCone ] );

################################
##
## Constructors
##
################################

DeclareOperation( "HomalgCone",
                  [ IsHomalgCone ] );

DeclareOperation( "HomalgCone",
                  [ IsList ] );

DeclareOperation( "HomalgCone",
                  [ IsInt ] );
