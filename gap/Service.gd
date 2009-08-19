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

DeclareGlobalFunction( "ColoredInfoForService" );

# basic operations:

DeclareOperation( "TriangularBasisOfRows",
        [ IsHomalgMatrix ] );

DeclareOperation( "TriangularBasisOfRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "TriangularBasisOfColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "TriangularBasisOfColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "BasisOfRowModule",
        [ IsHomalgMatrix ] );

DeclareOperation( "BasisOfColumnModule",
        [ IsHomalgMatrix ] );

DeclareOperation( "DecideZeroRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "DecideZeroColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SyzygiesGeneratorsOfRows",
        [ IsHomalgMatrix ] );

DeclareOperation( "SyzygiesGeneratorsOfRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SyzygiesGeneratorsOfColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "SyzygiesGeneratorsOfColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "ReducedBasisOfRowModule",
        [ IsHomalgMatrix ] );

DeclareOperation( "ReducedBasisOfColumnModule",
        [ IsHomalgMatrix ] );

DeclareOperation( "ReducedSyzygiesGeneratorsOfRows",
        [ IsHomalgMatrix ] );

DeclareOperation( "ReducedSyzygiesGeneratorsOfColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "BasisOfRowsCoeff",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "BasisOfColumnsCoeff",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "DecideZeroRowsEffectively",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "DecideZeroColumnsEffectively",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonym( "ReduceRingElements",
        DecideZero );

