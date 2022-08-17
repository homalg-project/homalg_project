# SPDX-License-Identifier: GPL-2.0-or-later
# Gauss: Extended Gauss functionality for GAP
#
# Declarations
#

##  Declaration stuff for performing Hermite algorithms on sparse matrices.

##
DeclareOperation( "HermiteMatDestructive",
        [ IsSparseMatrix ] );

DeclareOperation( "HermiteMatTransformationDestructive",
        [ IsSparseMatrix ] );

DeclareOperation( "ReduceMatWithHermiteMat",
        [ IsSparseMatrix, IsSparseMatrix ] );

DeclareOperation( "ReduceMatWithHermiteMatTransformation",
        [ IsSparseMatrix, IsSparseMatrix ] );

DeclareOperation( "KernelHermiteMatDestructive",
        [ IsSparseMatrix, IsList ] );

