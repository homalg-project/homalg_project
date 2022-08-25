# SPDX-License-Identifier: GPL-2.0-or-later
# Gauss: Extended Gauss functionality for GAP
#
# Declarations
#

##  Declaration stuff for the Category IsSparseMatrix of sparse matrices.

##
DeclareCategory( "IsSparseMatrix",
        IsAttributeStoringRep );

DeclareGlobalFunction( "SparseMatrix" );

DeclareOperation( "ConvertSparseMatrixToMatrix",
        [ IsSparseMatrix ] );

DeclareOperation( "CopyMat",
        [ IsSparseMatrix ] );

DeclareOperation( "GetEntry",
        [ IsSparseMatrix, IsInt, IsInt ] );

DeclareOperation( "SetEntry",
        [ IsSparseMatrix, IsInt, IsInt, IsRingElement ] );

DeclareOperation( "AddToEntry",
        [ IsSparseMatrix, IsInt, IsInt, IsRingElement ] );

DeclareOperation( "FindRing",
        [ IsList ] );

DeclareGlobalFunction( "SparseZeroMatrix" );

DeclareGlobalFunction( "SparseIdentityMatrix" );

DeclareOperation( "TransposedSparseMat",
        [ IsSparseMatrix ] );

DeclareOperation( "CertainRows",
        [ IsSparseMatrix, IsList ] );

DeclareOperation( "CertainColumns",
        [ IsSparseMatrix, IsList ] );

DeclareOperation( "SparseUnionOfRows",
        [ IsList ] );

DeclareOperation( "SparseUnionOfColumns",
        [ IsList ] );

DeclareGlobalFunction( "SparseDiagMat" );

DeclareOperation( "*",
        [ IsSparseMatrix, IsRingElement ] );

DeclareOperation( "*",
        [ IsRingElement, IsSparseMatrix ] );

DeclareOperation( "*",
        [ IsSparseMatrix, IsSparseMatrix ] );

DeclareOperation( "+",
        [ IsSparseMatrix, IsSparseMatrix ] );

DeclareOperation( "-",
        [ IsSparseMatrix, IsSparseMatrix ] );

DeclareOperation( "Nrows",
        [ IsSparseMatrix ] );

DeclareOperation( "Ncols",
        [ IsSparseMatrix ] );

DeclareOperation( "IndicesOfSparseMatrix",
        [ IsSparseMatrix ] );

DeclareOperation( "EntriesOfSparseMatrix",
        [ IsSparseMatrix ] );

DeclareOperation( "RingOfDefinition",
        [ IsSparseMatrix ] );

DeclareOperation( "IsSparseZeroMatrix",
        [ IsSparseMatrix ] );

DeclareOperation( "IsSparseIdentityMatrix",
        [ IsSparseMatrix ] );

DeclareOperation( "IsSparseDiagonalMatrix",
        [ IsSparseMatrix ] );

DeclareOperation( "SparseKroneckerProduct",
        [ IsSparseMatrix, IsSparseMatrix ] );

DeclareOperation( "SparseDualKroneckerProduct",
        [ IsSparseMatrix, IsSparseMatrix ] );

DeclareOperation( "SparseZeroRows",
        [ IsSparseMatrix ] );

DeclareOperation( "SparseZeroColumns",
        [ IsSparseMatrix ] );

DeclareOperation( "MultRow",
        [ IsList, IsList, IsRingElement ] );

DeclareOperation( "AddRow",
        [ IsList, IsList, IsList, IsList ] );

DeclareOperation( "IsRowOfSparseMatrix",
        [ IsSparseMatrix, IsSparseMatrix ] );

