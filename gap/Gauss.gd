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
DeclareOperation( "EchelonMatTransformationDestructive", #RREF over a field, returns [ RREF, Transformation_Matrix ]
        [ IsMatrix ] );

DeclareOperation( "EchelonMatTransformation",
        [ IsMatrix ] );

##
DeclareOperation( "EchelonMatDestructive", #RREF over a field, returns only RREF (Zero Rows are omitted). Could be changed to return Rank as well
        [ IsMatrix ] );

DeclareOperation( "EchelonMat",
        [ IsMatrix ] );

##
DeclareOperation( "ReduceMatWithEchelonMat", #Reduce the rows of a matrix with another matrix, which MUST be at least in REF.
        [ IsMatrix, IsMatrix ] );

