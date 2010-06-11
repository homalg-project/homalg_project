#############################################################################
##
##  Tools.gd                    Sheaves package              Mohamed Barakat
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##
##  Declarations of tool procedures.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "Eliminate",
        [ IsList, IsList ] );

DeclareOperation( "Eliminate",
        [ IsList, IsHomalgRingElement ] );

DeclareOperation( "Eliminate",
        [ IsHomalgModule, IsList ] );

DeclareOperation( "Eliminate",
        [ IsHomalgModule, IsHomalgRingElement ] );

DeclareOperation( "Diff",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

