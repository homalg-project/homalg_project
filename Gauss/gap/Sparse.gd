# SPDX-License-Identifier: GPL-2.0-or-later
# Gauss: Extended Gauss functionality for GAP
#
# Declarations
#

##  Declaration stuff for performing algorithms on sparse matrices.

##
DeclareAttribute( "EchelonMat",
        IsSparseMatrix );

DeclareAttribute( "EchelonMatTransformation",
        IsSparseMatrix );

DeclareOperation( "ReduceMat",
        [ IsSparseMatrix, IsSparseMatrix ] );

DeclareOperation( "ReduceMatTransformation",
        [ IsSparseMatrix, IsSparseMatrix ] );

DeclareGlobalFunction( "KernelMatSparse" );

DeclareGlobalFunction( "RankOfIndicesListList" );

