# SPDX-License-Identifier: GPL-2.0-or-later
# HomalgToCAS: A window to the outer world
#
# Declarations
#

##  Declaration stuff to launch and terminate external CASystems.

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "TerminateCAS" );

DeclareGlobalFunction( "LaunchCAS" );

DeclareGlobalFunction( "LaunchCAS_IO_ForHomalg" );

DeclareGlobalFunction( "InitializeMacros" );

DeclareGlobalFunction( "UpdateMacrosOfCAS" );

DeclareGlobalFunction( "UpdateMacrosOfLaunchedCAS" );

DeclareGlobalFunction( "UpdateMacrosOfLaunchedCASs" );
