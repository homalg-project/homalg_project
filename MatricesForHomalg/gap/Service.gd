#############################################################################
##
##  Service.gd                  MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations of homalg service procedures.
##
#############################################################################

####################################
#
# attributes:
#
####################################

DeclareAttribute( "RowReducedEchelonForm",
        IsHomalgMatrix );

DeclareAttribute( "ColumnReducedEchelonForm",
        IsHomalgMatrix );

DeclareAttribute( "BasisOfRowModule",
        IsHomalgMatrix );

DeclareAttribute( "BasisOfColumnModule",
        IsHomalgMatrix );

DeclareAttribute( "SyzygiesGeneratorsOfRows",
        IsHomalgMatrix );

DeclareAttribute( "SyzygiesGeneratorsOfColumns",
        IsHomalgMatrix );

DeclareAttribute( "ReducedBasisOfRowModule",
        IsHomalgMatrix );

DeclareAttribute( "ReducedBasisOfColumnModule",
        IsHomalgMatrix );

DeclareAttribute( "ReducedSyzygiesGeneratorsOfRows",
        IsHomalgMatrix );

DeclareAttribute( "ReducedSyzygiesGeneratorsOfColumns",
        IsHomalgMatrix );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "ColoredInfoForService" );

# basic operations:

DeclareOperation( "RowReducedEchelonForm",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "ColumnReducedEchelonForm",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "DecideZeroRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "DecideZeroColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SyzygiesGeneratorsOfRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SyzygiesGeneratorsOfColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "BasisOfRowsCoeff",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "BasisOfColumnsCoeff",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "DecideZeroRowsEffectively",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "DecideZeroColumnsEffectively",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ] );
