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
DeclareOperation( "EchelonMat",
        [ IsSparseMatrix ] );

DeclareOperation( "EchelonMatTransformation",
        [ IsSparseMatrix ] );

DeclareOperation( "ReduceMat",
        [ IsSparseMatrix, IsSparseMatrix ] ) ;

DeclareGlobalFunction( "KernelMatSparse" );

