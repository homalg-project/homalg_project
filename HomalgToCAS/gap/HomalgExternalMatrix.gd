# SPDX-License-Identifier: GPL-2.0-or-later
# HomalgToCAS: A window to the outer world
#
# Declarations
#

##  Declaration stuff for homalg matrices.

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "homalgPointer",
        [ IsHomalgMatrix ] );

DeclareOperation( "homalgExternalCASystem",
        [ IsHomalgMatrix ] );

DeclareOperation( "homalgExternalCASystemVersion",
        [ IsHomalgMatrix ] );

DeclareOperation( "homalgStream",
        [ IsHomalgMatrix ] );

DeclareOperation( "homalgExternalCASystemPID",
        [ IsHomalgMatrix ] );

# constructor methods:

## ConvertHomalgMatrix has been declared in homalg since it is called there

DeclareOperation( "ConvertHomalgMatrixViaFile",
        [ IsHomalgMatrix, IsHomalgRing ] );
