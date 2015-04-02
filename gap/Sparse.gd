#############################################################################
##
##  Sparse.gd                  Gauss package                  Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for performing algorithms on sparse matrices.
##
#############################################################################

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

