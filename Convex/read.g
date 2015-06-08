#############################################################################
##
##  read.g              ConvexForHomalg package           Sebastian Gutsche
##
##  Copyright 2011-2012 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Gives the Methods for Polymake
##
#############################################################################

ReadPackage( "Convex", "gap/ConvexObject.gi" );

## Fan Methods
ReadPackage( "Convex", "gap/LIFan.gi" );
ReadPackage( "Convex", "gap/Fan.gi" );

## Cone Methods
ReadPackage( "Convex", "gap/LICon.gi" );
ReadPackage( "Convex", "gap/Cone.gi" );

## Polytope Methods
ReadPackage( "Convex", "gap/Polytope.gi" );

if IsPackageMarkedForLoading( "PolymakeInterface", ">=0" ) = true then
    
    ReadPackage( "Convex", "gap/Polymake.gi" );
    
fi;

ReadPackage( "Convex", "gap/Polyhedron.gi" );
