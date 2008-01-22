#############################################################################
##
##  Service.gd                  homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations of homalg service procedures.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "TriangularBasisOfRows",
        [ IsMatrixForHomalg ] );

DeclareOperation( "TriangularBasisOfRows",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

DeclareOperation( "TriangularBasisOfColumns",
        [ IsMatrixForHomalg ] );

DeclareOperation( "TriangularBasisOfColumns",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

DeclareOperation( "BasisOfRows",
        [ IsMatrixForHomalg ] );

DeclareOperation( "BasisOfColumns",
        [ IsMatrixForHomalg ] );

DeclareOperation( "DecideZeroRows",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

DeclareOperation( "DecideZeroColumns",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

