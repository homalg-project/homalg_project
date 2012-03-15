#############################################################################
##
##  Polyhedron.gi         Convex package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Polyhedrons for Convex.
##
#############################################################################

DeclareRepresentation( "IsExternalPolyhedronRep",
                       IsPolyhedron and IsExternalConvexObjectRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfPolyhedrons",
        NewFamily( "TheFamilyOfPolyhedrons" , IsPolyhedron ) );

BindGlobal( "TheTypeExternalPolyhedron",
        NewType( TheFamilyOfPolyhedrons,
                 IsPolyhedron and IsExternalPolyhedronRep ) );

#####################################
##
## Structural Elements
##
#####################################

