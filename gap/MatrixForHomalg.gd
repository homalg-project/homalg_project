#############################################################################
##
##  MatrixForHomalg.gd       homalg package                  Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for matrices.
##
#############################################################################


####################################
#
# Declarations for matrices:
#
####################################

# A new category of objects:

DeclareCategory( "IsMatrixForHomalg",
        IsAttributeStoringRep );

# Now the constructor method:

DeclareGlobalFunction( "MatrixForHomalg" );

# Basic operations:

DeclareOperation( "Compose",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

####################
# matrix properties:
####################

DeclareProperty( "IsZeroMatrix",
        IsMatrixForHomalg );

DeclareProperty( "IsIdentityMatrix",
        IsMatrixForHomalg );

####################
# matrix attributes:
####################

DeclareAttribute( "Eval",
        IsMatrixForHomalg );

DeclareAttribute( "NrRows",
        IsMatrixForHomalg );

DeclareAttribute( "NrColumns",
        IsMatrixForHomalg );

