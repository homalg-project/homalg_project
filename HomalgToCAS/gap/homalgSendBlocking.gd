# SPDX-License-Identifier: GPL-2.0-or-later
# HomalgToCAS: A window to the outer world
#
# Declarations
#

##  Declaration stuff to manage the communication.

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "homalgFlush" );

DeclareGlobalFunction( "TerminateAllCAS" );

DeclareGlobalFunction( "_SetElmWPObj_ForHomalg" );

DeclareGlobalFunction( "homalgCreateStringForExternalCASystem" );

DeclareGlobalFunction( "homalgSendBlocking" ); ## this name was implicitly suggested by Max Neunhöffer ;)

DeclareGlobalFunction( "homalgDisplay" );

DeclareGlobalFunction( "StringToInt" );

DeclareGlobalFunction( "StringToIntList" );

DeclareGlobalFunction( "StringToDoubleIntList" );

