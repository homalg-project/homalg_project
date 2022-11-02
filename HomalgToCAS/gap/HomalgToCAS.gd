# SPDX-License-Identifier: GPL-2.0-or-later
# HomalgToCAS: A window to the outer world
#
# Declarations
#

##  Declaration stuff for HomalgToCAS.

# our info class:
DeclareInfoClass( "InfoHomalgToCAS" );
SetInfoLevel( InfoHomalgToCAS, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_IO" );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "homalgTime" );

DeclareGlobalFunction( "homalgMemoryUsage" );

DeclareGlobalFunction( "homalgIOMode" );

DeclareGlobalFunction( "FingerprintOfGapProcess" );
