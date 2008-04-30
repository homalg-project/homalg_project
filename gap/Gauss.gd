#############################################################################
##
##  Gauss.gd                Gauss package                     Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for Gauss.
##
#############################################################################

##
DeclareOperation( "EchelonMatTransformationDestructive", #RREF over a field, returns the same record as SemiEchelonMatTransformation but w/ ordered vectors
        [ IsMatrix ] );

DeclareOperation( "EchelonMatTransformation",
        [ IsMatrix ] );

##
DeclareOperation( "EchelonMatDestructive", #RREF over a field, returns the same record as SemiEchelonMat but with ordered vectors
        [ IsMatrix ] );

DeclareOperation( "EchelonMat",
        [ IsMatrix ] );

##
DeclareOperation( "ReduceMatWithEchelonMat", #Reduce the rows of a matrix with another matrix, which MUST be at least in REF.
        [ IsMatrix, IsMatrix ] );

##
DeclareOperation( "KernelMatDestructive", #REF over a field, returns a record with relations (list: certain columns of relations) as only entry
        [ IsMatrix, IsList ] );

DeclareGlobalFunction( "KernelMat" );
