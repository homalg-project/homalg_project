# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Declarations
#

# our info classes:
DeclareInfoClass( "InfoMatricesForHomalg" );
SetInfoLevel( InfoMatricesForHomalg, 1 );

DeclareInfoClass( "InfoHomalgBasicOperations" );
SetInfoLevel( InfoHomalgBasicOperations, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_MATRICES" );

####################################
#
# categories:
#
####################################

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "homalgMode" );

DeclareGlobalFunction( "FFEToString" );
