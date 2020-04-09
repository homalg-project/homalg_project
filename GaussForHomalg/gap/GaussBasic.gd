#############################################################################
##
##  GaussBasic.gd             GaussForHomalg package          Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations for Gauss Basic
##
#############################################################################

DeclareOperation( "MyEval",
        [ IsHomalgMatrix ] );

DeclareOperation( "SetMyEval",
        [ IsHomalgMatrix, IsSparseMatrix ] );

DeclareOperation( "SetMyEval",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "UnionOfRowsOp",
        [ IsList, IsList ] );

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "CommonHomalgTableForGaussBasic" );

