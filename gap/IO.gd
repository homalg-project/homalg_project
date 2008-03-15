#############################################################################
##
##  IO.gd                     HomalgRings package            Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff to use the legendary GAP4 I/O package of Max Neunhoeffer.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

DeclareOperation( "HomalgStream",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgExternalCASystemPID",
        [ IsHomalgExternalObject ] );

DeclareGlobalFunction( "HomalgCreateStringForExternalCASystem" );

DeclareGlobalFunction( "HomalgSendBlocking" ); ## this name was implicitly suggested by Max Neunhoeffer ;)

DeclareGlobalFunction( "StringToIntList" );

