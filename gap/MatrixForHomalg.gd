#############################################################################
##
##  MatrixForHomalg.gd          homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg matrices.
##
#############################################################################


####################################
#
# categories:
#
####################################

# a new category of objects:

DeclareCategory( "IsMatrixForHomalg",
        IsAttributeStoringRep );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsZeroMatrix",
        IsMatrixForHomalg );

DeclareProperty( "IsIdentityMatrix",
        IsMatrixForHomalg );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "Eval",
        IsMatrixForHomalg );

DeclareAttribute( "NrRows",
        IsMatrixForHomalg );

DeclareAttribute( "NrColumns",
        IsMatrixForHomalg );

DeclareAttribute( "RankOfMatrix",
        IsMatrixForHomalg );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "MatrixForHomalg" );

# basic operations:

DeclareOperation( "Compose",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

