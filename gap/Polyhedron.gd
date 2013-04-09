#############################################################################
##
##  Polyhedron.gd         Convex package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Polyhedrons for Convex.
##
#############################################################################

DeclareCategory( "IsPolyhedron",
                 IsConvexObject );

#####################################
##
## Structural Elements
##
#####################################

# DeclareAttribute( "ExternalObject",
#                   IsPolyhedron );

DeclareAttribute( "MainPolytope",
                  IsPolyhedron );

DeclareAttribute( "VerticesOfMainPolytope",
                  IsPolyhedron );

DeclareAttribute( "TailCone",
                  IsPolyhedron );

DeclareAttribute( "RayGeneratorsOfTailCone",
                  IsPolyhedron );

DeclareAttribute( "HomogeneousPointsOfPolyhedron",
                  IsPolyhedron );

DeclareAttribute( "LatticePointsGenerators",
                  IsPolyhedron );

DeclareAttribute( "BasisOfLinealitySpace",
                  IsPolyhedron );

#####################################
##
## Properties
##
#####################################

DeclareProperty( "IsNotEmpty",
                 IsPolyhedron );

DeclareProperty( "IsBounded",
                 IsPolyhedron );

#####################################
##
## Constructors
##
#####################################

DeclareOperation( "PolyhedronByInequalities",
                  [ IsList ] );

DeclareOperation( "Polyhedron",
                  [ IsPolytope, IsCone ] );

DeclareOperation( "Polyhedron",
                  [ IsList, IsCone ] );

DeclareOperation( "Polyhedron",
                  [ IsPolytope, IsList ] );

DeclareOperation( "Polyhedron",
                  [ IsList, IsList ] );

DeclareOperation( "PolyhedronWithHomogeneousCoordinates",
                  [ IsList ] );
