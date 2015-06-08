#############################################################################
##
##  homalgSendBlocking.gd     HomalgToCAS package            Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff to manage the communication.
##
#############################################################################

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

