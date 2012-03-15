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

DeclareAttribute( "ExternalObject",
                  IsPolyhedron );

DeclareAttribute( "MainPolytope",
                  IsPolyhedron );

DeclareAttribute( "VerticesOfMainPolytope",
                  IsPolyhedron );

DeclareAttribute( "TailCone",
                  IsPolyhedron );

DeclareAttribute( "RayGeneratorsOfTailCone",
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


