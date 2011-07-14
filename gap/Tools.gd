#############################################################################
##
##  Tools.gd                                     GradedRingForHomalg package
##
##  Copyright 2009-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Declarations for tools for matrices over graded rings.
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

DeclareOperation( "NonTrivialDegreePerRowWithColPositionFunction",
        [ IsHomalgRing, IsList, IsObject, IsObject ] );

DeclareOperation( "NonTrivialDegreePerColumnWithRowPositionFunction",
        [ IsHomalgRing, IsList, IsObject, IsObject ] );

DeclareOperation( "LinearSyzygiesGeneratorsOfRows",
        [ IsHomalgMatrix ] );

DeclareOperation( "LinearSyzygiesGeneratorsOfColumns",
        [ IsHomalgMatrix ] );

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
