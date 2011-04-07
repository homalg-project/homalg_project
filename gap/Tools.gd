#############################################################################
##
##  Tools.gd                GradedRingForHomalg package      Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009-2010, Mohamed Barakat, University of Kaiserslautern
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

DeclareOperation( "DegreesOfEntries",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "Diff",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "NonTrivialDegreePerRowWeighted",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "NonTrivialDegreePerRowWeighted",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "NonTrivialDegreePerColumnWeighted",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "NonTrivialDegreePerColumnWeighted",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "DegreesOfEntriesWeighted",
        [ IsHomalgMatrix, IsList, IsList ] );

