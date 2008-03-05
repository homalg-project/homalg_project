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
        [ IsHomalgMatrix ] );

DeclareOperation( "TriangularBasisOfRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "TriangularBasisOfColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "TriangularBasisOfColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "BasisOfRows",
        [ IsHomalgMatrix ] );

DeclareOperation( "BasisOfRowModule",
        [ IsHomalgMatrix ] );

DeclareOperation( "BasisOfColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "BasisOfColumnModule",
        [ IsHomalgMatrix ] );

DeclareOperation( "DecideZeroRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "DecideZeroColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMatrix ] );

DeclareOperation( "SyzygiesGeneratorsOfRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SyzygiesGeneratorsOfRows",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "SyzygiesGeneratorsOfColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SyzygiesGeneratorsOfColumns",
        [ IsHomalgMatrix, IsList ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonym( "ReduceRingElements",
        DecideZero );

