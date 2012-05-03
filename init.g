#############################################################################
##
##  init.g              ConvexForHomalg package           Sebastian Gutsche
##
##  Copyright 2011-2012 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Gives the Methods for Polymake
##
#############################################################################

if LoadPackage( "PolymakeInterface" ) = fail then
    
    ReadPackage( "Convex", "gap/TypesFromPolymake.gd" );
    
    Print( "You are running Convex without PolymakeInterface/polymake.\n",
           "Some restrictions to the input apply:\n",
           "- Cones are supposed to be pointed.\n",
           "- Cones have to be created by ray generators.\n",
           "- Fans have to be created by maximal cones.\n",
           "- Polytopes have to be given by vertices or a reduced set of inequalities.\n"
          );
    
fi;

ReadPackage( "Convex", "gap/ConvexObject.gd" );

ReadPackage( "Convex", "gap/Fan.gd" );

ReadPackage( "Convex", "gap/Cone.gd" );

ReadPackage( "Convex", "gap/Polytope.gd" );

ReadPackage( "Convex", "gap/ExternalSystem.gd" );

ReadPackage( "Convex", "gap/Polyhedron.gd" );
