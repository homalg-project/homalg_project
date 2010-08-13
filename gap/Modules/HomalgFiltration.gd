#############################################################################
##
##  HomalgFiltration.gd         Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declaration stuff for a filtration.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "MatrixOfFiltration",
        [ IsHomalgFiltration, IsInt ] );

DeclareOperation( "MatrixOfFiltration",
        [ IsHomalgFiltration ] );

DeclareOperation( "BasisOfModule",
        [ IsHomalgFiltration ] );

DeclareOperation( "DecideZero",
        [ IsHomalgFiltration ] );

DeclareOperation( "OnLessGenerators",
        [ IsHomalgFiltration ] );

DeclareOperation( "ByASmallerPresentation",
        [ IsHomalgFiltration ] );

