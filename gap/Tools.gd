#############################################################################
##
##  Tools.gd                                     GradedRingForHomalg package
##
##  Copyright 2009-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations for tools for (homogeneous) matrices.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "DegreeOfRingElementFunction",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "DegreesOfEntriesFunction",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "NonTrivialDegreePerRowFunction",
        [ IsHomalgRing, IsList, IsObject, IsObject ] );

DeclareOperation( "NonTrivialDegreePerRowWithColDegreesFunction",
        [ IsHomalgRing, IsList, IsObject, IsList ] );

DeclareOperation( "NonTrivialDegreePerColumnFunction",
        [ IsHomalgRing, IsList, IsObject, IsObject ] );

DeclareOperation( "NonTrivialDegreePerColumnWithRowDegreesFunction",
        [ IsHomalgRing, IsList, IsObject, IsList ] );

DeclareOperation( "MonomialMatrixWeighted",
        [ IsInt, IsHomalgRing, IsList ] );

DeclareOperation( "MonomialMatrixWeighted",
        [ IsList, IsHomalgRing, IsList ] );

DeclareOperation( "RandomMatrixBetweenGradedFreeLeftModulesWeighted",
        [ IsList, IsList, IsHomalgRing, IsList ] );

DeclareOperation( "RandomMatrixBetweenGradedFreeRightModulesWeighted",
        [ IsList, IsList, IsHomalgRing, IsList ] );

DeclareOperation( "Diff",
        [ IsHomalgMatrix, IsHomalgMatrix ] );
