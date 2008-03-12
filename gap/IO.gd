#############################################################################
##
##  IO.gd                       homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff to use the legendary GAP4 I/O package of Max Neunhoeffer.
##
#############################################################################

####################################
#
# properties:
#
####################################

DeclareProperty( "IsHomalgExternalObjectWithIOStream",
        IsHomalgExternalObject );

DeclareProperty( "IsHomalgExternalRingElementWithIOStream",
        IsHomalgExternalRingElement );

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

DeclareGlobalFunction( "StringToElementStringList" );
