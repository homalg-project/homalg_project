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

DeclareOperation( "DegreeOfRingElementFunction",
        [ IsHomalgRing, IsHomalgMatrix ] );

DeclareOperation( "DegreesOfEntriesFunction",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "DegreesOfEntriesFunction",
        [ IsHomalgRing, IsHomalgMatrix ] );

DeclareOperation( "NonTrivialDegreePerRowWithColPositionFunction",
        [ IsHomalgRing, IsList, IsObject, IsObject ] );

DeclareOperation( "NonTrivialDegreePerColumnWithRowPositionFunction",
        [ IsHomalgRing, IsList, IsObject, IsObject ] );

DeclareOperation( "LinearSyzygiesGeneratorsOfRows",
        [ IsHomalgMatrix ] );

DeclareOperation( "LinearSyzygiesGeneratorsOfColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "Diff",
        [ IsHomalgMatrix, IsHomalgMatrix ] );
