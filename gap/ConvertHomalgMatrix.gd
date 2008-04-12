#############################################################################
##
##  ConvertHomalgMatrix.gd      RingsForHomalg package       Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg matrices.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

## ConvertHomalgMatrix have been declared in homalg since it is called there

# basic operations:

DeclareOperation( "CreateHomalgMatrixInExternalCAS",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "CreateHomalgMatrixInExternalCAS",
        [ IsString, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "CreateHomalgMatrixInExternalCAS",
        [ IsHomalgMatrix, IsHomalgRing ] );

