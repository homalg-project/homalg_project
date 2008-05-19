#############################################################################
##
##  Sparse.gd               Gauss package                     Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for Gauss with sparse matrices.
##
#############################################################################

##
DeclareCategory( "IsSparseMatrix",
        IsAttributeStoringRep );

DeclareGlobalFunction( "SparseMatrix" );

DeclareOperation( "ConvertSparseMatrixToMatrix",
        [ IsSparseMatrix ] );

DeclareOperation( "AddRow",
        [ IsList, IsList, IsList, IsList ] );

DeclareOperation( "EchelonMat",
        [ IsSparseMatrix ] );

DeclareOperation( "EchelonMatDestructive",
        [ IsSparseMatrix ] );

DeclareOperation( "EchelonMatTransformation",
        [ IsSparseMatrix ] );

DeclareOperation( "EchelonMatTransformationDestructive",
        [ IsSparseMatrix ] );

DeclareOperation( "ReduceMatWithEchelonMat",
        [ IsSparseMatrix, IsSparseMatrix ] ) ;

DeclareGlobalFunction( "KernelMatSparse" );

DeclareOperation( "KernelMatDestructive",
        [ IsSparseMatrix, IsList ] );

