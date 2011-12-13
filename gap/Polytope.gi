#############################################################################
##
##  Polytope.gi         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Cones for ConvexForHomalg.
##
#############################################################################

####################################
##
## Reps
##
####################################

DeclareRepresentation( "IsExternalPolytopeRep",
                       IsHomalgPolytope and IsExternalConvexObjectRep,
                       [ ]
                      );

DeclareRepresentation( "IsPolymakePolytopeRep",
                       IsExternalPolytopeRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfPolytopes",
        NewFamily( "TheFamilyOfPolytopes" , IsHomalgPolytope ) );

BindGlobal( "TheTypeExternalPolytope",
        NewType( TheFamilyOfPolytopes,
                 IsHomalgPolytope and IsExternalPolytopeRep ) );

BindGlobal( "TheTypePolymakePolytope",
        NewType( TheFamilyOfPolytopes,
                 IsPolymakePolytopeRep ) );

####################################
##
## Properties
##
####################################



####################################
##
## Constructors
##
####################################