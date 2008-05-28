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

DeclareOperation( "CopyMat",
        [ IsSparseMatrix ] );

DeclareOperation( "GetEntry",
        [ IsSparseMatrix, IsInt, IsInt ] );

DeclareOperation( "FindField",
        [ IsList ] );

DeclareGlobalFunction( "SparseZeroMatrix" );

DeclareGlobalFunction( "SparseIdentityMatrix" );

DeclareOperation( "TransposedSparseMat",
        [ IsSparseMatrix ] );

DeclareOperation( "CertainRows",
        [ IsSparseMatrix, IsList ] );

DeclareOperation( "CertainColumns",
        [ IsSparseMatrix, IsList ] );

DeclareOperation( "UnionOfRows",
        [ IsSparseMatrix, IsSparseMatrix ] );

DeclareOperation( "UnionOfColumns",
        [ IsSparseMatrix, IsSparseMatrix ] );

DeclareOperation( "SparseDiagMat",
        [ IsList ] );

DeclareOperation( "*", #FIXME: What does SparseMatrix have to be for this to be obsolete?
        [ IsRingElement, IsSparseMatrix ] );

DeclareOperation( "*",
        [ IsSparseMatrix, IsSparseMatrix ] );

DeclareOperation( "+", #see above
        [ IsSparseMatrix, IsSparseMatrix ] );

DeclareOperation( "nrows", #FIXME: NrRows led to a weird error? Maybe conflict with NrRows-attribute in homalg?
        [ IsSparseMatrix ] );

DeclareOperation( "ncols", #see above
        [ IsSparseMatrix ] );

DeclareOperation( "IsSparseZeroMatrix",
        [ IsSparseMatrix ] );

DeclareOperation( "IsSparseIdentityMatrix",
        [ IsSparseMatrix ] );

DeclareOperation( "IsSparseDiagonalMatrix",
        [ IsSparseMatrix ] );

DeclareOperation( "SparseZeroRows",
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

