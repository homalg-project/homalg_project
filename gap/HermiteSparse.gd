#############################################################################
##
##  HermiteSparse.gd             Gauss package                Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for performing Hermite algorithms on sparse matrices.
##
#############################################################################

##
DeclareOperation( "HermiteMatDestructive",
        [ IsSparseMatrix ] );

DeclareOperation( "HermiteMatTransformationDestructive",
        [ IsSparseMatrix ] );

DeclareOperation( "ReduceMatWithHermiteMat",
        [ IsSparseMatrix, IsSparseMatrix ] ) ;

DeclareOperation( "KernelHermiteMatDestructive",
        [ IsSparseMatrix, IsList ] );

