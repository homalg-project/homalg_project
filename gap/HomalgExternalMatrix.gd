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

DeclareOperation( "HomalgMatrixInExternalGAP",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInSingular",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInSingular",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInSage",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInSage",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInMacaulay2",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInMacaulay2",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInMAGMA",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInMAGMA",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInMaple",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInMaple",
        [ IsString, IsHomalgRing ] );

