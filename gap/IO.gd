#############################################################################
##
##  IO.gd                       homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff to use the legendary GAP4 I/O package of Max Neunhoeffer
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new category of objects:

DeclareCategory( "IsHomalgExternalObject",
        IsAttributeStoringRep );

####################################
#
# representations:
#
# CAUTION: here we need the representations in the declaration part!!!
#
####################################

# a new representation for the category IsHomalgExternalObject:
DeclareRepresentation( "IsHomalgExternalObjectRep",
        IsHomalgExternalObject,
        [ "object", "cas" ] );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsHomalgExternalObjectWithIOStream",
        IsHomalgExternalObject );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "HomalgExternalObject" );

# basic operations:

DeclareOperation( "HomalgPointer",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgExternalCASystem",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgExternalCASystemVersion",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgStream",
        [ IsHomalgExternalObject ] );

DeclareOperation( "HomalgExternalCASystemPID",
        [ IsHomalgExternalObject ] );

DeclareGlobalFunction( "HomalgCreateStringForExternalCASystem" );

DeclareGlobalFunction( "HomalgSendBlocking" ); ## this name was implicitly suggested by Max Neunhoeffer ;)

DeclareGlobalFunction( "StringToIntList" );

DeclareGlobalFunction( "StringToElementStringList" );
