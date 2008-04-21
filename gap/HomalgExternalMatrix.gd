#############################################################################
##
##  HomalgExternalMatrix.gd   IO_ForHomalg package           Mohamed Barakat
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

DeclareOperation( "ConvertHomalgMatrixViaFile",
        [ IsHomalgMatrix, IsHomalgRing ]
        );

DeclareOperation( "SaveDataOfHomalgMatrixToFile",
        [ IsString, IsHomalgMatrix, IsHomalgRing ]
        );

DeclareOperation( "SaveDataOfHomalgMatrixToFile",
        [ IsString, IsHomalgMatrix ]
        );

DeclareOperation( "LoadDataOfHomalgMatrixFromFile",
        [ IsString, IsHomalgRing ]
        );

DeclareOperation( "LoadDataOfHomalgMatrixFromFile",
        [ IsString, IsInt, IsInt, IsHomalgRing ]
        );
