#############################################################################
##
##  HomalgExternalMatrix.gd   RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for external homalg matrices.
##
#############################################################################


####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareOperation( "HomalgMatrixInExternalGAP",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInSingular",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInSage",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInMacaulay2",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInMagma",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInMaple",
        [ IsHomalgMatrix, IsHomalgRing ] );

