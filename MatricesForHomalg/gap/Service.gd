# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Declarations
#

####################################
#
# attributes:
#
####################################

if IsBound( RowEchelonForm ) and not IsOperation( RowEchelonForm ) then
    BindGlobal( "_RowEchelonForm", RowEchelonForm );
    Unbind( RowEchelonForm );
fi;

DeclareAttribute( "RowEchelonForm",
        IsHomalgMatrix );

DeclareAttribute( "ColumnEchelonForm",
        IsHomalgMatrix );

DeclareAttribute( "ReducedRowEchelonForm",
        IsHomalgMatrix );

DeclareAttribute( "ReducedColumnEchelonForm",
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

DeclareOperation( "RowEchelonForm",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "ColumnEchelonForm",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "ReducedRowEchelonForm",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "ReducedColumnEchelonForm",
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
