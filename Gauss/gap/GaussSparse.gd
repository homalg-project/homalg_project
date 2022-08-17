# SPDX-License-Identifier: GPL-2.0-or-later
# Gauss: Extended Gauss functionality for GAP
#
# Declarations
#

##  Declaration stuff for performing Gauss algorithms on sparse matrices.

##
DeclareOperation( "EchelonMatDestructive",
        [ IsSparseMatrix ] );

DeclareOperation( "EchelonMatTransformationDestructive",
        [ IsSparseMatrix ] );

DeclareOperation( "ReduceMatWithEchelonMat",
        [ IsSparseMatrix, IsSparseMatrix ] ) ;

DeclareOperation( "ReduceMatWithEchelonMatTransformation",
        [ IsSparseMatrix, IsSparseMatrix ] ) ;

DeclareOperation( "KernelEchelonMatDestructive",
        [ IsSparseMatrix, IsList ] );

DeclareOperation( "RankDestructive",
        [ IsSparseMatrix, IsInt ] );

