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
                 IsHomalgFan );

################################
##
## Basic Properties
##
################################

DeclareProperty( "IsRegularCone",
                 IsHomalgCone );

################################
##
## Attributes
##
################################

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

DeclareAttribute( "GridGeneratedByOrthogonalCone",
                  IsHomalgCone );

DeclareAttribute( "DefiningInequalities",
                  IsHomalgCone );

DeclareAttribute( "IsContainedInFan",
                  IsHomalgCone );

DeclareAttribute( "FactorGridMorphism",
                  IsHomalgCone );

################################
##
## Methods
##
################################

DeclareOperation( "IntersectionOfCones",
                  [ IsHomalgCone, IsHomalgCone ] );

DeclareOperation( "Contains",
                  [ IsHomalgCone, IsHomalgCone ] );

DeclareOperation( "StarFan",
                  [ IsHomalgCone ] );

DeclareOperation( "StarFan",
                  [ IsHomalgCone, IsHomalgFan ] );

DeclareOperation( "StarSubdivisionOfIthMaximalCone",
                  [ IsHomalgFan, IsInt ] );

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
