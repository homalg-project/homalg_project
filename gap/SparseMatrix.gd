#############################################################################
##
##  SparseMatrix.gd              Gauss package                Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for the Category IsSparseMatrix of sparse matrices.
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
	
DeclareOperation( "AddEntry",
        [ IsSparseMatrix, IsInt, IsInt, IsObject ] );

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

DeclareOperation( "SparseZeroColumns",
        [ IsSparseMatrix ] );

DeclareOperation( "MultRow",
        [ IsList, IsList, IsRingElement ] );

DeclareOperation( "AddRow",
        [ IsList, IsList, IsList, IsList ] );

